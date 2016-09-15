require 'open3'

require 'pry'
require 'active_model/serializers'
require 'mongo_mapper'

require_relative '../database'
require_relative '../modules'

class Importer::MongoDB
  def initialize(file_name, file_path)
    @file_name = file_name
    @file_path = file_path
  end

  def mongo_import_csv_no_validations
    Database.mongo_mapper_db # create a connection to the db
    drop_collection_if_exists(@file_name)

    command = "mongoimport --db learnup_dev --collection #{@file_name} --type csv --headerline --file #{@file_path}"

    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      puts "\nSTDOUT\n" + stdout.read
      puts "\nSTDERR\n" + stderr.read
    end
  end

  private

  def drop_collection_if_exists(collection_name)
    if MongoMapper.database.collection_names.include?(collection_name)
      MongoMapper.database.drop_collection(collection_name)
    end
  end
end

m = Importer::MongoDB.new('client_two', '/Users/jacindazhong/Documents/jacinda/learnup_etl_version/data/client_two.csv')
puts m.mongo_import_csv_no_validations

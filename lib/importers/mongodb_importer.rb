require 'open3'

require 'pry'
require 'active_model/serializers'
require 'mongo_mapper'

require_relative '../database'

module Importers
  class MongoDB
    def initialize(file_name, file_path)
      @file_name = file_name
      @file_path = file_path
    end

    def mongo_import_csv_no_validations
      Database.mongo_mapper_db # create a connection to the db

      command = "mongoimport --db learnup --collection #{@file_name} --type csv --headerline --file #{@file_path}"

      Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
        puts "\nSTDOUT\n" + stdout.read
        puts "\nSTDERR\n" + stderr.read
      end
    end
  end
end

m = Importers::MongoDB.new('client_one', '/Users/jacindazhong/Documents/jacinda/learnup_etl_version/data/client_one.csv')
puts m.import_csv

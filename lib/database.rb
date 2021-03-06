require 'pry'

require 'sequel'
require 'mongo_mapper'

module Database
  def self.postgres_db
    Sequel.postgres(
        {host: 'localhost', port: 5432, database: 'learnup_dev', username: nil, password: nil}
      ).extension :pg_array, :pg_hstore, :pg_json
  end

  def self.mongo_mapper_db(database)
    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
    MongoMapper.database = database
  end

  def self.mongo_db_connection(database)
    Mongo::Connection.new("localhost", 27017).db(database)
  end
end

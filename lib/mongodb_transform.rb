require 'pry'
require 'mongo_mapper'

require_relative 'database'
require_relative 'transform/mongo/user'

module Transform
  class MongoDB
    include Database

    def self.run
      Transform::MongoDB.setup
      Transform::MongoDB.run_transforms
    end

    def self.setup
      db = Database.mongo_mapper_db("learnup_etl")

      if MongoMapper.database.collection_names.include?("learnup_users")
        MongoMapper.database.drop_collection("learnup_users")
      end
    end

    def self.run_transforms
      Transform::Mongo::User.new.transform_data
    end
  end
end

Transform::MongoDB.run

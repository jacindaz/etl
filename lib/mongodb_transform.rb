require 'pry'
require 'mongo_mapper'

require_relative 'database'

module Transform
  class MongoDB
    include Database

    def self.run
      Transform::MongoDB.setup
      Transform::MongoDB.run_transforms
    end

    def self.setup
      db = Database.mongo_mapper_db

      if MongoMapper.database.collection_names.include?("learnup")
        MongoMapper.database.drop_collection("learnup")
      end
    end

    def self.run_transforms
    end
  end
end

Transform::MongoDB.run

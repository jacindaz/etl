require 'pry'

require_relative '../../../models/user'
require_relative '../../modules'
require_relative '../../database'

class Transform::Mongo::User
  def self.transform_client_one
    db = ::Mongo::Connection.new("localhost", 27017).db("learnup_dev")
    Database.mongo_mapper_db

    db.collection('client_one').find.to_a.each do |client_one_user|
      MongoModels::User.new(email: client_one_user["Email"]).save
    end
  end
end

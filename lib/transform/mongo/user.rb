require 'pry'
require 'people'

require_relative '../../../models/user'
require_relative '../../modules'
require_relative '../../database'

class Transform::Mongo::User
  def self.transform_data
    Transform::Mongo::User.transform_client_one
    Transform::Mongo::User.transform_client_two
  end

  def self.transform_client_one
    db = ::Mongo::Connection.new("localhost", 27017).db("learnup_dev")
    Database.mongo_mapper_db

    db.collection('client_one').find.to_a.each do |client_one_user|
      MongoModels::User.new(email: client_one_user["Email"]).save
    end
  end

  def self.transform_client_two
    db = ::Mongo::Connection.new("localhost", 27017).db("learnup_dev")
    Database.mongo_mapper_db

    np = ::People::NameParser.new
    client_two_data = db.collection('client_two').find.to_a

    client_two_data.each do |client_two_user|
      parsed_name = np.parse(client_two_user["Name"])

      MongoModels::User.new(first_name: parsed_name[:first],
                            middle_name: parsed_name[:middle],
                            last_name: parsed_name[:last],
                            prefix: parsed_name[:title],
                            suffix: parsed_name[:suffix]
                            ).save!
    end
  end
end

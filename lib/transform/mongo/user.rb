require 'pry'
require 'people'
require 'ruby-progressbar'

require_relative '../../../models/user'
require_relative '../../modules'
require_relative '../../database'

class Transform::Mongo::User
  def initialize
    db = ::Mongo::Connection.new("localhost", 27017).db("learnup_dev")
    Database.mongo_mapper_db

    @client_one_data = db.collection('client_one').find.to_a
    @client_two_data = db.collection('client_two').find.to_a

    @progress_bar = ProgressBar.create(title: 'transforming Transform::Mongo::User', starting_at: 0, total: (@client_one_data + @client_two_data).length)
  end

  def transform_data
    transform_client_one
    transform_client_two
  end

  def transform_client_one
    @client_one_data.each do |client_one_user|
      MongoModels::User.new(email: client_one_user["Email"]).save!
      @progress_bar.increment
    end
  end

  def transform_client_two
    np = ::People::NameParser.new

    @client_two_data.each do |client_two_user|
      parsed_name = np.parse(client_two_user["Name"])

      MongoModels::User.new(first_name: parsed_name[:first],
                            middle_name: parsed_name[:middle],
                            last_name: parsed_name[:last],
                            prefix: parsed_name[:title],
                            suffix: parsed_name[:suffix]
                            ).save!
      @progress_bar.increment
    end
  end
end

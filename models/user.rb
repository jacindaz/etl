require 'pry'
require 'active_model/serializers'
require 'mongo_mapper'

require_relative '../lib/database'

module MongoModels
  class User
    include ::MongoMapper::Document
    set_collection_name "learnup_users"

    key :email, String, length: 254
    key :first_name, String
    key :middle_name, String
    key :last_name, String
    key :prefix, String
    key :suffix, String
  end
end


email_not_valid = 'tasdfasdfasdfasdfasdfasdfasdfasdfasdfsadfasdfasdfesdfasdfasdfasdfasdfsadfasdfsdfsadfsadfsadfsaasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadfasdfsadfasdfsdfasdfasdfasdfasaasdfasdfasdfsadfasdfsadfsadfasdfasdfasdfasdfasdfsadfasdfasdfasdfsadfsadfasdfasdfasdfdfdfst@test.com'
valid_email = "test@test.com"
# this works!!
# interestingly this creates a collection called
# "client_one_applicants"
a = MongoModels::User.new(email: 'test_2@test.com', job: 'Cashier', status: 'Closed')
Database.mongo_mapper_db
a.save!

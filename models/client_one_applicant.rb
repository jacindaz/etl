require 'pry'
require 'active_model/serializers'
require 'mongo_mapper'

require_relative '../lib/database'

class ClientOneApplicant
  include ::MongoMapper::Document

  attr_accessor :email, :job, :status

  key :email, String
  key :job, String
  key :status, String
end

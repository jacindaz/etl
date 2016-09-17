require 'pry'
require 'active_model/serializers'
require 'mongo_mapper'

require_relative '../lib/database'

module MongoModels
  class User
    include ::MongoMapper::Document
    set_collection_name "user"

    key :email, String, length: { minimum: 4, maximum: 254, allow_nil: true }

    key :first_name, String, allow_nil: true
    key :middle_name, String, allow_nil: true
    key :last_name, String, allow_nil: true

    # validates_uniqueness_of :last_name, scope: [:first_name, :middle_name]
    validate :validate_full_name

    key :prefix, String, allow_nil: true
    key :suffix, String, allow_nil: true

    private

    def validate_full_name
      first_name_string = first_name || ''
      middle_name_string = middle_name || ''
      last_name_string = last_name || ''

      # 225 is the guiness book of world records longest name
      if (first_name_string + middle_name_string + last_name_string).length > 225
        errors.add(:first_name, 'Length of first, middle, last combined must be less than 225 characters.')
      end
    end
  end
end


# email_not_valid = 'tasdfasdfasdfasdfasdfasdfasdfasdfasdfsadfasdfasdfesdfasdfasdfasdfasdfsadfasdfsdfsadfsadfsadfsaasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadfasdfsadfasdfsdfasdfasdfasdfasaasdfasdfasdfsadfasdfsadfsadfasdfasdfasdfasdfasdfsadfasdfasdfasdfsadfsadfasdfasdfasdfdfdfst@test.com'
# valid_email = "test@test.com"

# a = MongoModels::User.new(first_name: 'Barnaby Marmaduke Aloysius Benjy Cobweb Dartagnan Egbert Felix Gaspar Humbert Ignatius Jayden Kasper Leroy Maximilian Neddy Obiajulu Pepin Quilliam Rosencrantz Sexton Teddy Upwood Vivatma Wayland Xylon Yardley Zachary Usansky', last_name: 'LastName', job: 'Cashier', status: 'Closed')
# Database.mongo_mapper_db
# a.save!

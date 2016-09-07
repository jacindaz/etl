require 'pry'
require 'sequel'
require 'pg'

require_relative 'database'
require_relative 'transform/users.rb'

class Transform
  include Database

  def self.run
    Transform.setup
    Transform.run_transforms
  end

  def self.setup
    Database.db.run <<-SQL
      drop schema if exists applicant cascade;
      create schema if not exists applicant;
    SQL
  end

  def self.run_transforms
    Users.run
    # Jobs.run
    # User::Jobs.run
    # User::Statuses.run
  end
end

Transform.run

require 'pry'
require 'people'
require 'pg'
require_relative '../database'

class User
  include Database

  def self.run
    self.create_table
    self.insert_learnup_users
    self.insert_client_users
    self.insert_client_two_users
  end

  def self.create_table
    Database.db.run <<-SQL
      create table if not exists applicant.users(
        id                serial,
        email             varchar(255),
        first_name        varchar(255),
        middle_name       varchar(255),
        last_name         varchar(255),
        prefix            varchar(50),
        suffix            varchar(50),

        programs_completed_job_ids int[],
        current_status    varchar(255),
        status_last_updated timestamp
      )
    SQL
  end

  def self.create_indexes
  end

  def self.insert_learnup_users
    Database.db.run <<-SQL
      insert into applicant.users (
        id,
        email,
        first_name,
        last_name
      )
      select id, email, first_name, last_name
      from learnup.users
    SQL
  end

  def self.insert_client_users
    Database.db.run <<-SQL
      insert into applicant.users (
        email
      )
      select email
      from client.client_one c1
      where email not in (select email from applicant.users)
    SQL
  end

  def self.insert_client_two_users
    # new_person = People::NameParser.new

    # got stuck here, couldn't exactly figure out how to parse
    # the names, and to do it using Ruby or SQL
    # if i was really good at regex i'd probably dump some fancy
    # regex and parse it in SQL so it's faster

    Database.db.run <<-SQL
      insert into applicant.users (
        first_name,
        middle_name,
        last_name,
        prefix,
        suffix
      )
      select '', '', '', '', ''
      from applicant.users au
      left join client.client_two c2 on
        position(au.first_name IN c2.name)<>0
        and position(au.last_name IN c2.name)<>0
    SQL
  end
end

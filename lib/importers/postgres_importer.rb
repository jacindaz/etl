require 'pry'

require 'json'
require_relative '../database'
require_relative '../modules'

class Importer::Postgres
  include Database

  def initialize
    users_file = File.read("#{File.dirname(__FILE__)}/../data/users.json")
    @json_users = JSON.parse(users_file)

    jobs_file = File.read("#{File.dirname(__FILE__)}/../data/jobs.json")
    @json_jobs = JSON.parse(jobs_file)

    user_jobs_file = File.read("#{File.dirname(__FILE__)}/../data/user_jobs.json")
    @json_user_jobs = JSON.parse(user_jobs_file)
  end

  def setup
    Database.db.run <<-SQL
      drop schema if exists learnup cascade;
      create schema if not exists learnup;
    SQL

    create_tables
  end

  def create_tables
    Database.db.run <<-SQL
      create table if not exists learnup.users(
        id                int primary key,
        first_name        varchar(255),
        last_name         varchar(255),
        email             varchar(255)
      )
    SQL

    Database.db.run <<-SQL
      create table if not exists learnup.jobs(
        id                int primary key,
        title             varchar(255)
      )
    SQL

    Database.db.run <<-SQL
      create table if not exists learnup.user_jobs(
        id                int,
        user_id           int,
        job_title_id      int
      )
    SQL
  end

  def insert_data
    prepared_statement_users = Database.db[:learnup__users].prepare(:insert, :prepare_users_insert, id: :$id, first_name: :$first_name, last_name: :$last_name, email: :$email)
    @json_users.each do |user|
      prepared_statement_users.call(id: user["id"], first_name: user["first_name"], last_name: user["last_name"], email: user["email"])
    end

    prepared_statement_jobs = Database.db[:learnup__jobs].prepare(:insert, :prepare_jobs_insert, id: :$id, title: :$title)
    @json_jobs.each do |job|
      prepared_statement_jobs.call(id: job["id"], title: job["title"])
    end

    prepared_statement_user_jobs = Database.db[:learnup__user_jobs].prepare(:insert, :prepare_jobs_insert, id: :$id, user_id: :$user_id, job_title_id: :$job_title_id)
    @json_user_jobs.each do |user_job|
      prepared_statement_user_jobs.call(id: user_job["id"], user_id: user_job["user_id"], job_title_id: user_job["job_title_id"])
    end
  end
end

# importer = Importer::Postgres.new
# importer.setup
# importer.insert_data

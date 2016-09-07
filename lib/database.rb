require 'sequel'

module Database
  def self.db
    Sequel.postgres(
        {host: 'localhost', port: 5432, database: 'learnup_dev', username: nil, password: nil}
      ).extension :pg_array, :pg_hstore, :pg_json
  end
end

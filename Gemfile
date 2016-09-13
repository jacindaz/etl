source 'https://rubygems.org'

ruby '2.3.0'

# Postgres
gem 'pg'
gem 'sequel'
gem 'sequel_pg'

# MongoDB
# hack, had to include these gems manually bc mongo_mapper
# depends on them, but they got taken out of active_model...
gem 'activemodel-serializers-xml'
gem 'active_model_serializers'
gem 'mongo_mapper'
gem 'bson_ext'

# Name parsing for user transform
gem 'people'

group :development, :test do
  gem 'better_errors'
  gem 'pry'
end

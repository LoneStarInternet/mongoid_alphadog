$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require "mongoid"
require "rspec"
require "database_cleaner"

require File.expand_path("../../lib/mongoid/alphadog", __FILE__)

MODELS = File.join(File.dirname(__FILE__), "models")

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

Mongoid.config.master = Mongo::Connection.new.db("mongoid-alphadog-spec")
Mongoid.logger = Logger.new($stdout)

DatabaseCleaner.orm = "mongoid"

RSpec.configure do |config|
  config.before(:all) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
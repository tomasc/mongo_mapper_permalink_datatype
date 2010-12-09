require 'rubygems'
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'mongo_mapper'
require 'mongo_mapper/datatypes/permalink'
require 'test/unit'
require 'shoulda'
require 'ruby-debug'

class ActiveSupport::TestCase
	
	# Drop all collections after each test case.
  def teardown
    MongoMapper.database.collections.each { |coll| coll.remove }
  end

  # Make sure that each test case has a teardown
  # method to clear the db after each test.
  def inherited(base)
    base.define_method teardown do 
      super
    end
  end

	# DOCUMENT

  def Doc(name='Class', &block)
    klass = Class.new
    klass.class_eval do
      include MongoMapper::Document
      set_collection_name :test

      if name
        class_eval "def self.name; '#{name}' end"
        class_eval "def self.to_s; '#{name}' end"
      end
    end

    klass.class_eval(&block) if block_given?
    klass.collection.remove
    klass
  end

	# EMBEDDED DOCUMENT

  def EDoc(name='Class', &block)
    klass = Class.new do
      include MongoMapper::EmbeddedDocument

      if name
        class_eval "def self.name; '#{name}' end"
        class_eval "def self.to_s; '#{name}' end"
      end
    end

    klass.class_eval(&block) if block_given?
    klass
  end

end

MongoMapper.connection = Mongo::Connection.new('127.0.0.1', 27017)
MongoMapper.database = "permalink_datatype_test"
MongoMapper.database.collections.each { |c| c.drop_indexes }

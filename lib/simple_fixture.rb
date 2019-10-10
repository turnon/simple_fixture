require "simple_fixture/version"
require "active_record"
require "active_record/fixtures"

class SimpleFixture

  DB_DIR = 'tmp'
  DB_NAME = 'simple_fixture'
  CONFIG_DIR = File.join('test', 'simple_fixture')
  FIXTURES_DIR = File.join(CONFIG_DIR, 'fixtures')

  class << self
    def migrate(&block)
      Class.new(ActiveRecord::Migration::Current) do
        define_method :change do
          instance_eval &block
        end
      end.new.change
    end
  end

  def initialize
    build_db_file
    establish_connection

    load File.join(CONFIG_DIR, 'migration.rb')
    load File.join(CONFIG_DIR, 'models.rb')
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::FixtureSet.create_fixtures(FIXTURES_DIR, ymls)

    true
  end

  private

  def ymls
    Dir[File.join(FIXTURES_DIR, '*.yml')].map{ |f| File.basename(f, '.*') }
  end

  def build_db_file
    Dir.mkdir DB_DIR unless Dir.exists? DB_DIR
    path = File.join(DB_DIR, "#{DB_NAME}.splite3")
    File.delete(path) if File.exists? path
    @path = path
  end

  def establish_connection
    ::ActiveRecord::Base.configurations = {test: {adapter: 'sqlite3', database: @path}}.with_indifferent_access
    ::ActiveRecord::Base.establish_connection(:test)
  rescue => _
    ::ActiveRecord::Base.establish_connection('test')
  end
end

require "simple_fixture/version"
require "active_record"
require "active_record/fixtures"

module SimpleFixture

  DB_DIR = 'tmp'
  DB_NAME = 'simple_fixture'
  CONFIG_DIR = File.join('test', 'simple_fixture')
  FIXTURES_DIR = File.join(CONFIG_DIR, 'fixtures')

  class << self
    def create(name: DB_NAME)
      path = build_db_file(name)
      establish_connection(path)

      load File.join(CONFIG_DIR, 'migration.rb')
      load File.join(CONFIG_DIR, 'models.rb')
      ActiveRecord::FixtureSet.create_fixtures(FIXTURES_DIR, ymls)
    end

    def migrate(&block)
      Class.new(ActiveRecord::Migration::Current) do
        define_method :change do
          instance_eval &block
        end
      end.new.change
    end

    private

    def ymls
      Dir[File.join(FIXTURES_DIR, '*.yml')].map{ |f| File.basename(f, '.*') }
    end

    def build_db_file(name)
      Dir.mkdir DB_DIR unless Dir.exists? DB_DIR
      path = File.join(DB_DIR, "#{name}.splite3")
      File.delete(path) if File.exists? path
      path
    end

    def establish_connection(path)
      ::ActiveRecord::Base.configurations = {test: {adapter: 'sqlite3', database: path}}.with_indifferent_access
      ::ActiveRecord::Base.establish_connection(:test)
    rescue => _
      ::ActiveRecord::Base.establish_connection('test')
    end
  end
end

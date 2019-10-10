require "simple_fixture/version"
require "active_record"

module SimpleFixture

  DB_DIR = 'tmp'
  DB_NAME = 'simple_fixture'

  class << self
    def create(name: DB_NAME)
      path = build_db_file(name)
      establish_connection(path)

      load 'test/simple_fixture/migration.rb'
    end

    def migrate(&block)
      Class.new(ActiveRecord::Migration::Current) do
        define_method :change do
          instance_eval &block
        end
      end.new.change
    end

    private

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

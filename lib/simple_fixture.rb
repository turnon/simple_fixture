require "simple_fixture/version"
require "active_record"

module SimpleFixture

  DB_NAME = 'simple_fixture'

  class << self
    def create(name: DB_NAME, renew: false)
      path = "/tmp/#{name}.splite3"
      `rm #{path}` if File.exists? path

      ::ActiveRecord::Base.configurations = {test: {adapter: 'sqlite3', database: path}}
      ::ActiveRecord::Base.establish_connection(:test)

      load 'test/simple_fixture/migration.rb'
    end

    def migrate(&block)
      Class.new(ActiveRecord::Migration::Current) do
        define_method :change do
          instance_eval &block
        end
      end.new.change
    end
  end
end

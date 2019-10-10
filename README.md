# SimpleFixture

Help create fixtures off rails project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_fixture'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_fixture

## Usage

You should have directory `test/simple_fixture` in your project, with structure as below. You can run `simple-fixture` to generate it. Also check file content examples in this gem's test directory.

```
test
├── simple_fixture
│   ├── fixtures
│   │   ├── goods.yml
│   │   ├── items.yml
│   │   └── orders.yml
│   ├── migration.rb
│   └── models.rb
├── your_gem_test.rb
└── test_helper.rb
```

Then call `SimpleFixture.new`, or just `require 'simple_fixture/load'`, then fixtures will be loaded into a new sqlite file in directory `tmp/` of your project, and you can use ActiveRecord to find them, such as `Order.where(...)`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_fixture. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleFixture project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simple_fixture/blob/master/CODE_OF_CONDUCT.md).

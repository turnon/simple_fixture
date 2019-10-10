require "test_helper"

class SimpleFixtureTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SimpleFixture::VERSION
  end

  def test_it_does_something_useful
    SimpleFixture.create
    goods = Order.find_by(order_no: '1').items.includes(:good).map{ |i| i.good.name }.sort
    assert_equal ['addidas', 'nike'], goods
  end
end

require 'test/unit'
require 'checkout'

class CheckoutTest < Test::Unit::TestCase

  def setup
    promotional_rules = {
      :total_threshold => 6000,
      :total_discount => 0.1,
      :promo_items => [
        {
          :code => '001',
          :min_count => 2,
          :promo_price => 850
        }
      ]
    }
    @co = Checkout.new(promotional_rules)
  end

  def test_1
    @co.scan('001')
    @co.scan('002')
    @co.scan('003')
    assert_equal 66.78, @co.total
  end

  def test_2
    @co.scan('001')
    @co.scan('003')
    @co.scan('001')
    assert_equal 36.95, @co.total
  end

  def test_3
    @co.scan('001')
    @co.scan('002')
    @co.scan('001')
    @co.scan('003')
    assert_equal 73.76, @co.total
  end

end
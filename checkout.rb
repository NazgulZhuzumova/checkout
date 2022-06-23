class Checkout

    PRODUCTS = {
      '001' => 925,
      '002' => 4500,
      '003' => 1995
    }
  
    def initialize(promotional_rules)
      @promotional_rules = promotional_rules
      @basket = {}
    end
  
    def scan(item)
      @basket[item] ||= 0
      @basket[item] += 1
    end
  
    def total
      total = 0
      basket = @basket.dup
      @promotional_rules[:promo_items].each do |promo_item|
        if (count = basket[promo_item[:code]]) && count >= promo_item[:min_count]
          total += promo_item[:promo_price] * count
          basket.delete(promo_item[:code])
        end
      end
      total += basket.keys.inject(0) { |result, item| result + PRODUCTS[item] }
      if total >= @promotional_rules[:total_threshold]
        total -= @promotional_rules[:total_discount] * total
      end
      total.round.to_f / 100
    end
  
  end
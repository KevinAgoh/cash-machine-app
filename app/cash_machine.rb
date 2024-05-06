class CashMachine
  attr_reader :cart

  def initialize
    @cash_machine = []
  end

  def add(product)
    if product['code'] == 'GR1' && tea_promotion_applicable?(@cash_machine)
      product = { 'name' => 'Green Tea', 'price' => 0,
                  'code' => 'GR1' }
    end
    if product['code'] == 'SR1' && stawberry_promotion_applicable?(@cash_machine)
      apply_stawberry_promotion(@cash_machine)
    end
    if product['code'] == 'CF1' && coffee_promotion_applicable?(@cash_machine)
      apply_coffee_promotion(@cash_machine)
      product['price'] = 7.48
    end

    @cash_machine << product
  end

  def all
    @cash_machine
  end

  private

  def tea_promotion_applicable?(cash_machine)
    count = cash_machine.filter { |product| product['code'] == 'GR1' }.length
    count.positive? && count.odd?
  end

  def stawberry_promotion_applicable?(cash_machine)
    count = cash_machine.filter { |product| product['code'] == 'SR1' }.length
    count == 2
  end

  def coffee_promotion_applicable?(cash_machine)
    count = cash_machine.filter { |product| product['code'] == 'CF1' }.length
    count == 2
  end

  def apply_stawberry_promotion(cash_machine)
    cash_machine.each do |product|
      product['price'] = 4.5 if product['code'] == 'SR1'
    end
  end

  def apply_coffee_promotion(cash_machine)
    cash_machine.each do |product|
      product['price'] = ((product['price'] / 3) * 2).round(2) if product['code'] == 'CF1'
    end
  end
end

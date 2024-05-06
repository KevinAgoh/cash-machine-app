require_relative 'cash_machine_view'

class CashMachineController
  def initialize(cash_machine, products_repositoriy)
    @cash_machine = cash_machine
    @products_repository = products_repositoriy
    @view = CashMachineView.new
  end

  def add_product_to_cart
    product_index = @view.ask_user_for_product
    product = @products_repository.find(product_index)
    @cash_machine.add(product)
  end

  def compute_total_price(cash_machine)
    cash_machine.sum { |product| product['price'].to_f }
  end

  def show_cash_machine_overview
    cash_machine = @cash_machine.all
    total_price = compute_total_price(cash_machine)
    @view.display_cash_machine_overview(cash_machine, total_price)
  end

  private

  def tea_promotion_applicable?(cash_machine)
    counts = Hash.new 0

    cash_machine.each do |product|
      counts[product] += 1
    end

    counts.even? && counts != 0
  end

  def stawberry_promotion_applicable?(cash_machine)
    counts = Hash.new 0

    cash_machine.each do |product|
      counts[product['code'] == 'SR1'] += 1
    end

    counts >= 3
  end

  def coffee_promotion_applicable?(cash_machine)
    counts = Hash.new 0

    cash_machine.each do |product|
      counts[product['code'] == 'CF1'] += 1
    end

    counts >= 3
  end

  def apply_stawberry_promotion(cash_machine)
    cash_machine.each do |product|
      product.price = 4.5 if product['code'] == 'SR1'
    end
  end

  def apply_coffee_promotion(cash_machine)
    cash_machine.each do |product|
      (product.price * (2 / 3).round(2)).round(2) if product['code'] == 'SR1'
    end
    puts cash_machine
  end
end

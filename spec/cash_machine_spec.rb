require_relative '../app/cash_machine'
require_relative '../app/cash_machine_controller'
require_relative '../app/products_repository'

RSpec.describe CashMachine do
  it 'creates a cash machine class' do
    cash_machine = CashMachine.new
    expect(cash_machine).to be_kind_of(CashMachine)
  end

  it 'adds a product to the cart' do
    cash_machine = CashMachine.new
    product = { name: 'Green Tea', price: 3.11, code: 'GR1' }
    cash_machine.add(product)
    expect(cash_machine.all).to include(product)
  end

  it 'computes the total price of products in the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)
    product1 = { name: 'Green Tea', price: 3.11, code: 'GR1' }
    product2 = { name: 'Strawberries', price: 5.00, code: 'SR1' }
    cash_machine.add(product1)
    cash_machine.add(product2)
    expect(cash_machine_controller.compute_total_price).to eq(8.11)
  end

  it 'applies a buy one, get one for free discount when you add a second tea to the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)

    product1 = { name: 'Green Tea', price: 3.11, code: 'GR1' }
    cash_machine.add(product1)
    cash_machine.add(product1)
    expect(cash_machine_controller.compute_total_price).to eq(3.11)
  end

  it 'reduces prices of strawberries to 4,50€ if there are 3 or more strawberries in the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)
    product1 = { name: 'Green Tea', price: 3.11, code: 'GR1' }
    product2 = { name: 'Strawberries', price: 5.00, code: 'SR1' }
    cash_machine.add(product1)
    cash_machine.add(product2)
    cash_machine.add(product1)
    cash_machine.add(product1)
    expect(cash_machine_controller.compute_total_price).to eq(16.61)
  end

  it 'reduces prices of strawberries to 2/3 of the original price if there are 3 or more coffees in the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)
    product1 = { name: 'Green Tea', price: 3.11, code: 'GR1' }
    product2 = { name: 'Strawberries', price: 5.00, code: 'SR1' }
    product3 = { name: 'Coffee', price: 11.23, code: 'CF1' }
    cash_machine.add(product1)
    cash_machine.add(product3)
    cash_machine.add(product2)
    cash_machine.add(product3)
    cash_machine.add(product3)
    expect(cash_machine_controller.compute_total_price).to eq(30.57)
  end
end

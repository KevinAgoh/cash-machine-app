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
    green_tea = products_repository.all[0]
    strawberries = products_repository.all[1]
    cash_machine.add(green_tea)
    cash_machine.add(strawberries)
    expect(cash_machine_controller.compute_total_price(cash_machine.all)).to eq(8.11)
  end

  it 'applies a buy one, get one for free discount when you add a second tea to the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)
    green_tea = products_repository.all[0]
    cash_machine.add(green_tea)
    cash_machine.add(green_tea)
    expect(cash_machine_controller.compute_total_price(cash_machine.all)).to eq(3.11)
  end

  it 'reduces prices of strawberries to 4,50€ if there are 3 or more strawberries in the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)
    green_tea = products_repository.all[0]
    strawberries = products_repository.all[1]
    cash_machine.add(strawberries)
    cash_machine.add(green_tea)
    cash_machine.add(strawberries)
    cash_machine.add(strawberries)
    expect(cash_machine_controller.compute_total_price(cash_machine.all)).to eq(16.61)
  end

  it 'reduces prices of strawberries to 2/3 of the original price if there are 3 or more coffees in the cart' do
    cash_machine = CashMachine.new
    products_repository = ProductsRepositories.new
    cash_machine_controller = CashMachineController.new(cash_machine, products_repository)
    green_tea = products_repository.all[0]
    strawberries = products_repository.all[1]
    coffee = products_repository.all[2]
    cash_machine.add(green_tea)
    cash_machine.add(coffee)
    cash_machine.add(strawberries)
    cash_machine.add(coffee)
    cash_machine.add(coffee)
    expect(cash_machine_controller.compute_total_price(cash_machine.all)).to eq(30.57)
  end
end

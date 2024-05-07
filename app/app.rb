require_relative 'cash_machine'
require_relative 'products_repository'
require_relative 'cash_machine_controller'
require_relative 'router'

products_repository = ProductsRepositories.new
cash_machine = CashMachine.new
controller = CashMachineController.new(cash_machine, products_repository)
router     = Router.new(controller)

router.run

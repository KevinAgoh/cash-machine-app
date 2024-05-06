class Router
  def initialize(controller)
    @controller = controller
  end

  def run
    loop do
      print_actions
      action = gets.chomp.to_i
      dispatch(action)
    end
  end

  private

  def print_actions
    puts "\n---"
    puts 'What would you like to do ?'
    puts '1 - Add a product to the cart'
    puts '2 - See cart status'
    puts '---'
  end

  def dispatch(action)
    case action
    when 1 then @controller.add_product_to_cart
    when 2 then @controller.show_cash_machine_overview

    else
      puts 'Please type 1 or 2'
    end
  end
end

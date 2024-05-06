class CashMachineView
  def display_cash_machine_overview(cash_machine, total_price)
    cash_machine.each do |product|
      puts " #{product['name']} - #{product['price']}€"
    end
    puts "\n---"
    puts "Total Price : #{total_price.round(2)}€"
    puts '---'
  end

  def ask_user_for_product
    puts "\n---"
    puts 'Which product do you want to add to your cart ?'
    puts '1 - Green Tea'
    puts '2 - Strawberries'
    puts '3 - Coffee'
    puts '---'
    gets.chomp.to_i - 1
  end
end

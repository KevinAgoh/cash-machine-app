class ProductsRepositories
  def initialize
    @products = [{ 'name' => 'Green Tea', 'price' => 3.11, 'code' => 'GR1' },
                 { 'name' => 'Strawberries', 'price' => 5.00, 'code' => 'SR1' },
                 { 'name' => 'Coffee', 'price' => 11.23, 'code' => 'CF1' }]
  end

  def find(index)
    @products[index]
  end

  def all
    @products
  end
end

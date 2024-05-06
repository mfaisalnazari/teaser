Tea.destroy_all
Subscription.destroy_all
Customer.destroy_all
customers_data = [
  { first_name: 'John', last_name: 'Doe', email: 'john1@example.com', address: '123 Main St, City, Country' },
  { first_name: 'Jane', last_name: 'Smith', email: 'jane1@example.com', address: '456 Elm St, City, Country' }
]

teas_data = [
  { title: 'Green Tea', description: 'Light and refreshing tea with a grassy flavor.', temperature: 75, brew_time: 2 },
  { title: 'Black Tea', description: 'Full-bodied tea with a bold flavor and rich aroma.', temperature: 95, brew_time: 4 },
  { title: 'Herbal Tea', description: 'Caffeine-free infusion made from herbs, flowers, or spices.', temperature: 90, brew_time: 5 }
]

customers_data.each do |customer_data|
  Customer.find_or_create_by!(email: customer_data[:email]) do |customer|
    customer.update(customer_data)
  end
end

teas_data.each do |tea_data|
  Tea.find_or_create_by!(title: tea_data[:title]) do |tea|
    tea.update(tea_data)
  end
end

Subscription.create!([
  { title: 'Subscription 1', price: 9.99, status: 'active', frequency: 'monthly', customer: Customer.first, tea: Tea.first },
  { title: 'Subscription 2', price: 14.99, status: 'cancelled', frequency: 'monthly', customer: Customer.last, tea: Tea.last }
])


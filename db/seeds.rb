# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

15.times do
  Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "123456")
end

10.times do
  Category.create!(name: Faker::Commerce.department)
end 

15.times do
  Item.create!(name: Faker::Commerce.material)
end

item_ids = Item.pluck(:id)
category_ids = Category.pluck(:id)
30.times do
  p = Product.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, category_id: category_ids.sample)
  item_ids.sample(rand(5) + 2).each do |item_id|
    p.product_items.create!(item_id: item_id, quantity: (rand(10) + 1) )
  end
end

product_ids = Product.pluck(:id)
customer_ids = Customer.pluck(:id)
statuses = Order.statuses.values
100.times do
  created_datetime = Faker::Time.between(2.weeks.ago, DateTime.now)
  Order.create!(product_id: product_ids.sample, status: statuses.sample, customer_id: customer_ids.sample, created_at: created_datetime, updated_at: created_datetime)
end


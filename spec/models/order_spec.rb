require "rails_helper"
RSpec.describe Order, :type => :model do
  let(:customer) {create(:customer)}
  let(:category) {create(:category)}
  let(:item) {create(:item)}
  let(:product) {create(:product,category: category)}
  let(:order) {create(:order,product: product,customer: customer,status: 0)}

  it "should order by week" do
    order.update(status: 1)
    Order.by_week(1.weeks.ago..Date.yesterday).should_not include(order)
  end

  it "should display sold_products" do
    customer.orders.by_week(1.weeks.ago..1.weeks.from_now).sold_products.map(&:product).should_not include(order.product)
  end

  it "should get monthly data" do
    order
    data = Order.month_data.first
    expect(data[:new_customer]).to eq(1)
    expect(data[:reccuring_customer]).to eq(0)
    expect(data[:total]).to eq(1)
  end
end
require "rails_helper"
RSpec.describe ProductItem, :type => :model do
  let(:customer) {create(:customer)}
  let(:category) {create(:category)}
  let(:item) {create(:item)}
  let(:product) {create(:product,category: category)}
  let(:order) {create(:order,product: product,customer: customer)}

  it "should order by week" do
    product_item = product.product_items.create!(item_id: item.id, quantity: (rand(10) + 1) )
    ProductItem.by_week(1.weeks.ago..Date.yesterday,customer).should_not include(product_item)
  end
end
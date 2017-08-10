require "rails_helper"
RSpec.describe Customer, :type => :model do
    let!(:customer) { create(:customer,last_name: "chelimsky")}
    let!(:customer1) { create(:customer,last_name: "lindeman")}
  it "orders by last name" do
    expect(Customer.count).to eq(2)
  end
end
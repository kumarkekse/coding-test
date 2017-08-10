FactoryGirl.define do
  factory :item do
    name {Faker::Commerce.material}
  end
end
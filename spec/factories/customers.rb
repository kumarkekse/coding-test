FactoryGirl.define do
  factory :customer do
    email { Faker::Internet.email }
    password "123456"
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
  end
end
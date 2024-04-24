FactoryBot.define do
  factory :coupon do
    name { Faker::Name.name }
    special_code { Faker::Company.unique.name }
    amount_off { Faker::Number.number(digits: 5) }
    percent_off { false }
    status { "active" }
    association :merchant
  end
end
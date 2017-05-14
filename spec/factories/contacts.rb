FactoryGirl.define do
  factory :contact do
    sequence(:first_name) { |n| "firstname#{n}" }
    sequence(:last_name) { |n| "lastname#{n}" }
    sequence(:username) { |n| "#{n}username#{n}" }
    sequence(:phone_number) { |n| "123-456-789#{n}"}
    sequence(:email) { |n| "#{n}email@#{n}website.com" }
  end
end

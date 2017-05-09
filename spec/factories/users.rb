FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "firstname#{n}" }
    sequence(:last_name) { |n| "lastname#{n}" }
    sequence(:username) { |n| "#{n}username#{n}" }
    sequence(:phone_number) { |n| "123-456-789#{n}"}
    sequence(:email) { |n| "#{n}email@#{n}website.com" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:password_confirmation) { |n| "password#{n}" }
  end
end

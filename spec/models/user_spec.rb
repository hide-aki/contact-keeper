require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when('John', 'Sally') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Williams') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:username).when('username1', 'testuser') }
  it { should_not have_valid(:username).when(nil, '') }

  it { should have_valid(:email).when('user@example.com', 'test@test.com') }
  it { should_not have_valid(:email).when(nil, '', 'user', 'user@', '.com', 'user@example', 'user.com') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  describe '#touch_base' do
    it 'updates the last_contacted attribute with current date/time' do
      contact = Contact.create(first_name: 'Test', last_name: 'Test', email: 'test@test.com')
      now = Time.zone.now
      contact.touch_base

      expect(contact.last_contacted).to be > now
    end
  end
end

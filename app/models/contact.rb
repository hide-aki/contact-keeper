class Contact < ApplicationRecord
  belongs_to :user
  
  validates_uniqueness_of :email, scope: [:user_id]

  def touch_base
    self.update_attributes(last_contacted: Time.zone.now)
  end
end

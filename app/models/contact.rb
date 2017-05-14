class Contact < ApplicationRecord
  belongs_to :user

  def touch_base
    self.update_attributes(last_contacted: Time.zone.now)
  end
end

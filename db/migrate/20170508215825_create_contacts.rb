class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.datetime :last_contacted
      t.text :notes
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end

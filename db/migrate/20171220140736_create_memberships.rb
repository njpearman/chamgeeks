class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.string :email
      t.string :name
      t.integer :calendar_year
      t.string :paid_via

      t.timestamps
    end
  end
end

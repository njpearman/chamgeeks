class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.string :email
      t.string :name
      t.string :payment_ref
      t.string :year

      t.timestamps
    end
  end
end

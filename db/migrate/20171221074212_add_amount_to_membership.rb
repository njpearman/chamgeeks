class AddAmountToMembership < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :amount, :integer
  end
end

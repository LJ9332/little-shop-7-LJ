class AddColumnToCoupons < ActiveRecord::Migration[7.1]
  def change
    remove_column :coupons, :status, :integer
    add_column :coupons, :status, :integer, default: 1
  end
end

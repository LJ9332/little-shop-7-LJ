class ChangeCoupons < ActiveRecord::Migration[7.1]
  def change
    remove_column :coupons, :percent_off, :integer
    remove_column :coupons, :dollar_off, :integer
    add_column :coupons, :amount_off, :integer
    add_column :coupons, :percent_off, :boolean
    add_column :coupons, :status, :integer  
  end
end

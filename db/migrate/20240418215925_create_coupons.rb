class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :special_code, null: false, index: { unique: true }
      t.integer :percent_off
      t.integer :dollar_off
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

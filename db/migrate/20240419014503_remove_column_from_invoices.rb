class RemoveColumnFromInvoices < ActiveRecord::Migration[7.1]
  def change
    remove_reference :invoices, :coupon, null: false, foreign_key: true
    add_reference :invoices, :coupon, foreign_key: true
  end
end

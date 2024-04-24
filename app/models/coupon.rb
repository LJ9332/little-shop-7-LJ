class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum status: {0 => "Active", 1 => "Deactive"} 
end
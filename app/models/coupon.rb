class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :name, presence: true
  validates :special_code, presence: true
  validates :amount_off, presence: true, numericality: true
  
  enum status: {active: 0, inactive: 1} 

  # def amount_off_in_dollars
  #   self.amount_off / 100.00
  # end
end
class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :special_code, presence: true, uniqueness: true
  validates :amount_off, presence: true, numericality: true
  
  enum status: {active: 0, inactive: 1} 


  # def count_successful_transactions
  #   self.joins(invoices: :transactions)
  #   .select("transactions.*, coupon.*")
  #       .where("transactions.result = 0")
  #       .count
  # end
  
  # def amount_off_in_dollars
  #   self.amount_off / 100.00
  # end
end
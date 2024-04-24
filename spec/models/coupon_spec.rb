require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices) }
  end

  describe "vaildation" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :special_code}
    it { should validate_presence_of :amount_off}
    it { should validate_numericality_of :amount_off}
  end
end
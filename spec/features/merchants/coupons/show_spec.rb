require 'rails_helper'

RSpec.describe "Merchant Coupon Show" do
  before(:each) do
    @merchant1 = create(:merchant)
    @coupon1 = @merchant1.coupons.create!(name: "10 off", special_code: "BANKI", percent_off: false, amount_off: 10000, status: "active")
    @coupon2 = create(:coupon, status: "inactive", merchant_id: @merchant1.id)
    @coupon3 = create(:coupon, merchant_id: @merchant1.id)
    @coupon4 = create(:coupon, merchant_id: @merchant1.id)
  end

  describe 'CC User Story 3' do
    it "Displays a coupons name, code, amount off, and status"  do
      visit merchant_coupon_path(@merchant1, @coupon1)

      expect(page).to have_content(@coupon1.name)
      expect(page).to have_content(@coupon1.special_code)
      expect(page).to have_content(@coupon1.amount_off)
      expect(page).to have_content(@coupon1.status)
    end

    xit "counts how many times the coupon has been used" do
      visit merchant_coupon_path(@merchant1, @coupon1)

      expect(page).to have_content("Times Used: 0")
    end
  end

  describe 'CC User Story 4' do
    it "has a deactivate status button" do
      visit merchant_coupon_path(@merchant1, @coupon1)
      expect(page).to have_content("Status: active")
      
      expect(page).to have_button("Deactivate #{@coupon1.name}")
      click_on "Deactivate #{@coupon1.name}"
      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))

      expect(page).to have_content("Status: inactive")
    end
  end

  describe 'CC User Story 5' do
    it "has a activate status button" do
      visit merchant_coupon_path(@merchant1, @coupon2)
      expect(page).to have_content("Status: inactive")
      
      expect(page).to have_button("Activate #{@coupon2.name}")
      click_on "Activate #{@coupon2.name}"
      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon2))

      expect(page).to have_content("Status: active")
    end
  end
end
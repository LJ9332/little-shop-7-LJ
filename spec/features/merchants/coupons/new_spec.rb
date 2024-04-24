require 'rails_helper'

RSpec.describe "Merchant Coupon New" do
  before(:each) do
    @merchant1 = create(:merchant)
    @coupon1 = create(:coupon, merchant_id: @merchant1.id)
    @coupon2 = create(:coupon, merchant_id: @merchant1.id)
    @coupon3 = create(:coupon, merchant_id: @merchant1.id)
    @coupon4 = create(:coupon, merchant_id: @merchant1.id)
  end

  describe "CC User Story 2" do
    it "has a form to create a new merchant coupon" do
      visit new_merchant_coupon_path(@merchant1)

      expect(page).to have_field("Name")
      expect(page).to have_field("Special Code")
      expect(page).to have_field("Amount Off")
      expect(page).to have_select('Percentage Off', with_options: [true, false])
      expect(page).to have_button("Create Coupon")

      fill_in "Name", with: "15 off"
      fill_in "Special Code", with: "GRT14"
      fill_in "Amount Off", with: "15000"
      page.select false , from: 'Percentage Off'

      click_on "Create Coupon"
      expect(current_path).to eq(merchant_coupons_path(@merchant1))
      expect(page).to have_content("15 off")
    end

    it "has a sad path to create a new merchant coupon" do
      visit new_merchant_coupon_path(@merchant1)

      expect(page).to have_field("Name")
      expect(page).to have_field("Special Code")
      expect(page).to have_field("Amount Off")
      expect(page).to have_select('Percentage Off', with_options: [true, false])
      expect(page).to have_button("Create Coupon")

    
      fill_in "Amount Off", with: "15000"
      page.select false , from: 'Percentage Off'

      click_on "Create Coupon"
      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
      expect(page).to have_content("Error: Please fill in all fields")
    end
  end
end
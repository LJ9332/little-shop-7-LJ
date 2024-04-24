require 'rails_helper'

RSpec.describe "Merchant Coupon Index" do
  before(:each) do
    @merchant1 = create(:merchant)
    @coupon1 = create(:coupon, merchant_id: @merchant1.id)
    @coupon2 = create(:coupon, merchant_id: @merchant1.id)
    @coupon3 = create(:coupon, status: "inactive", merchant_id: @merchant1.id)
    @coupon4 = create(:coupon, status: "inactive", merchant_id: @merchant1.id)
  end

  describe 'CC User Story 1' do
    it "Displays all coupons"  do
      visit merchant_coupons_path(@merchant1)

      expect(page).to have_link(@coupon1.name)
      expect(page).to have_link(@coupon2.name)
      expect(page).to have_link(@coupon3.name)
      expect(page).to have_link(@coupon4.name)

      click_on @coupon1.name
      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
    end
  end

  describe 'CC User Story 2' do
    it "has a link to create a coupon" do
      visit merchant_coupons_path(@merchant1)

      expect(page).to have_link("Create a Coupon")
      click_on "Create a Coupon" 
      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
    end
  end

  describe 'CC User Story 6' do
    it "has active coupons section" do
      visit merchant_coupons_path(@merchant1)

      within ".active-coupons" do
        expect(page).to have_content(@coupon1.name)
        expect(page).to have_content(@coupon2.name)
        expect(page).to_not have_content(@coupon3.name)
        expect(page).to_not have_content(@coupon4.name)
      end
    end

    it "has inactive coupons section" do
      visit merchant_coupons_path(@merchant1)

      within ".inactive-coupons" do
        expect(page).to have_content(@coupon3.name)
        expect(page).to have_content(@coupon4.name)
        expect(page).to_not have_content(@coupon1.name)
        expect(page).to_not have_content(@coupon2.name)
      end
    end
  end
end
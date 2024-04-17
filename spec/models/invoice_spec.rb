require "rails_helper"

RSpec.describe Invoice, type: :model do

  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items) }
    it { should have_many(:merchants) }
  end

  before(:each) do
    @customers = create_list(:customer, 10)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customer5 = @customers[4]
    @customer6 = @customers[5]

    @invoice1 = create(:invoice, customer: @customer1, created_at:  Time.utc(2004, 9, 13, 12, 0, 0) )
    @invoices = create_list(:invoice, 2, customer: @customer1)
    @invoice2 = @invoices[0]
    @invoice3 = @invoices[1]
    @invoice4 = create(:invoice, customer_id: @customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
    @invoice5 = create(:invoice, customer_id: @customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
    @invoice6 = create(:invoice, customer_id: @customer4.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @invoice7 = create(:invoice, customer_id: @customer5.id, created_at: Time.utc(2024, 4, 6, 12, 0, 0))
    @invoice8 = create(:invoice, customer_id: @customer6.id, created_at: Time.utc(2024, 4, 7, 12, 0, 0))

    @invoice1_transactions = create_list(:transaction, 4, invoice: @invoice1)
    @invoice4_transactions = create_list(:transaction, 3, invoice: @invoice4)
    @invoice5_transactions = create_list(:transaction, 2, invoice: @invoice5)

    @transaction1 = @invoice1_transactions[0]
    @transaction2 = @invoice1_transactions[1]
    @transaction3 = @invoice1_transactions[2]
    @transaction4 = @invoice1_transactions[3]
    @transaction5 = @invoice4_transactions[0]
    @transaction6 = @invoice4_transactions[1]
    @transaction7 = @invoice4_transactions[2]
    @transaction8 = @invoice5_transactions[0]
    @transaction9 = @invoice5_transactions[1]
    @transaction10 = create(:transaction, invoice_id: @invoice2.id)
    @transaction11 = create(:transaction, invoice_id: @invoice3.id)
    @transaction12 = create(:transaction, invoice_id: @invoice6.id)
    @transaction13 = create(:transaction, invoice_id: @invoice7.id)

    @merchant1 = create(:merchant, name: "Amazon")

    @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 1, 12, 0, 0))
    @item2 = create(:item, unit_price: 23, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 2, 12, 0, 0))
    @item3 = create(:item, unit_price: 100, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 3, 12, 0, 0))
    @item4 = create(:item, unit_price: 5, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 4, 12, 0, 0))
    @item5 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item6 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item7 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item8 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item9 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item10 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, status: 2)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, status: 2)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item6 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item7 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
    @invoice_item8 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
    @invoice_item9 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice6.id, status: 1)
    @invoice_item10 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice7.id, status: 1)
    @invoice_item11 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item12 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice5.id, status: 1)
    @invoice_item13 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice6.id, status: 1)
    @invoice_item14 = create(:invoice_item, item_id: @item9.id, invoice_id: @invoice7.id, status: 1)
    @invoice_item15 = create(:invoice_item, item_id: @item10.id, invoice_id: @invoice8.id, status: 1)

  end

  describe "class methods" do
    describe "#incomplete_invoices" do
      it "displays all invoices that haven't been shipped" do
        expect(Invoice.incomplete_invoices).to contain_exactly(@invoice1, @invoice4, @invoice5, @invoice6, @invoice7, @invoice8)
      end
    end

    describe '#best_day' do
      it 'returns a string that displays that merchants best selling day' do
        
        # merchant1 = create(:merchant)
 
        # customer1 = Customer.create!(first_name:"Billy", last_name:"W" )
   
        # invoice1 = customer1.invoices.create!(status: "completed", created_at: Time.new(2012,12,12))
        # invoice1 = customer1.invoices.create!(status: "completed", created_at: Time.new(2010,11,1))
        # invoice1 = customer1.invoices.create!(status: "completed", created_at: Time.new(2020,8,2))
        # invoice2 = customer1.invoices.create!(status: "completed", created_at: Time.new(2015,3,4))
        # invoice2 = customer1.invoices.create!(status: "completed", created_at: Time.new(2004,9,22))
        # invoice2 = customer1.invoices.create!(status: "completed", created_at: Time.new(2002,10,14))
   
        # item1 = create(:item, merchant: merchant1)
        # item2 = create(:item, merchant: merchant1)

        # invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
        # invoice_item1 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, status: 0)

  
        # create_list(:invoice_item, 5, unit_price: 1000, quantity: 5, invoice: invoice1, item: item1)
        # create_list(:invoice_item, 1, unit_price: 2000, quantity: 3, invoice: invoice1, item: item1)
        # create_list(:invoice_item, 9, unit_price: 1200, quantity: 2, invoice: invoice2, item: item2)
        # create_list(:invoice_item, 4, unit_price: 6000, quantity: 4, invoice: invoice2, item: item2)
  
        # create(:transaction, result: 1, invoice: invoice1)
        # create(:transaction, result: 1, invoice: invoice2)
  
        expect(Invoice.best_day.strftime("%m/%d/%y")).to eq("09/13/04")
      end
    end
  end

  describe "instance methods" do
    describe ".format_date" do
      it "formats date day, month, year" do
        expect(@invoice1.format_date).to eq("Monday, September 13, 2004")
      end
    end

    describe ".total_revenue" do
      it "returns the total revenue from all invoice items" do
        @cust1 = create(:customer)
        @inv1 = create(:invoice, customer_id: @cust1.id)
        @merch1 = create(:merchant)
        @it1 = create(:item, unit_price: 10000, merchant_id: @merch1.id)
        @it2 = create(:item, unit_price: 500, merchant_id: @merch1.id)
        @it3 = create(:item, unit_price: 7500, merchant_id: @merch1.id)
        @inv_it1 = @inv1.invoice_items.create!(item_id: @it1.id, quantity: 5, unit_price: @it1.unit_price, status: 0)
        @inv_it2 = @inv1.invoice_items.create!(item_id: @it2.id, quantity: 10, unit_price: @it2.unit_price, status: 0)
        @inv_it3 = @inv1.invoice_items.create!(item_id: @it3.id, quantity: 1, unit_price: @it3.unit_price, status: 0)

        expected_revenue = ((10000*5)+(500*10)+(7500*1))

        expect(@inv1.total_revenue).to eq(expected_revenue)
      end
    end

    describe ".total_revenue_in_dollars" do
      it "returns the total revenue from all invoice items in dollars" do
        @cust1 = create(:customer)
        @inv1 = create(:invoice, customer_id: @cust1.id)
        @merch1 = create(:merchant)
        @it1 = create(:item, unit_price: 10000, merchant_id: @merch1.id)
        @it2 = create(:item, unit_price: 500, merchant_id: @merch1.id)
        @it3 = create(:item, unit_price: 7500, merchant_id: @merch1.id)
        @inv_it1 = @inv1.invoice_items.create!(item_id: @it1.id, quantity: 5, unit_price: @it1.unit_price, status: 0)
        @inv_it2 = @inv1.invoice_items.create!(item_id: @it2.id, quantity: 10, unit_price: @it2.unit_price, status: 0)
        @inv_it3 = @inv1.invoice_items.create!(item_id: @it3.id, quantity: 1, unit_price: @it3.unit_price, status: 0)

        expected_revenue = ((10000*5)+(500*10)+(7500*1))/100.00

        expect(@inv1.total_revenue_in_dollars).to eq(expected_revenue)
      end
    end
  end
end
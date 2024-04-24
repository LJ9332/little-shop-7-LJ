class Merchant::InvoicesController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:id])
    # @subtotal = @invoice.total_revenue_in_dollars
    # @grand_total = @invoice.grand_total
  end
end
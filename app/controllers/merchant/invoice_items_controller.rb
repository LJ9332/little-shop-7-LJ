class Merchant::InvoiceItemsController < ApplicationController 
  def update
    @merchant = Merchant.find(params[:merchant_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)

    redirect_to merchant_invoice_path(@merchant, invoice_item.invoice_id)
  end

  private

  def invoice_item_params
    params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :status)
  end
end
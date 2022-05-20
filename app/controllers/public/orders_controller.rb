class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

   def create
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.order_status = 0

    @order.save
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price
      order_detail.save
    end
    current_customer.cart_items.all.destroy_all
    render "complete"
   end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.1}
    @order.charge = 800
    @order.total_payment = @total + @order.charge

    if  params[:order][:select_address] == "0"
      @order.post_number = current_customer.post_number
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_number = @address.post_number
      @order.address = @address.address
      @order.name = @address.name
    else
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:post_number, :address, :name, :payment_method, :customer_id, :charge, :total_payment, :order_status)
  end

end

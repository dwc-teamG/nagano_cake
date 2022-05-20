class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @order.charge = 800
    @total = @order_details.sum{|order_detail|order_detail.item.price * order_detail.amount * 1.1}
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if params[:order] [:order_status]=="入金確認"
       @order_details.update(production_status: 1)
    end
    if params[:order][:order_status]=="発送済み"
       @order_details.update(production_status: 3)
    end
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(order_status)
  end
end

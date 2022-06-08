class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
   @order_detail = OrderDetail.find(params[:id])
   @order_detail.update(order_detail_params)
   if params[:order_detail][:production_status]=="製作中"
      @order_detail.order.update(order_status: 2)
   end
   if @order_detail.order.order_details==@order_detail.order.order_details.where(production_status:3)
      params[:order_detail][:production_status]=="製作完了"
      @order_detail.order.update(order_status: 3)
   end
    redirect_to request.referer
  end

  private
  def order_detail_params
   params.require(:order_detail).permit(:production_status)
  end

end

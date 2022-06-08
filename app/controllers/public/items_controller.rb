class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def index
    @items = Item.latest.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

end
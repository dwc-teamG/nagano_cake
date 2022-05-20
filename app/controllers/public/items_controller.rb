class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

end
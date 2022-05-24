class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.page(params[:page])
  end

  def about
  end
end

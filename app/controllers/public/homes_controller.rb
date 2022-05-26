class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.latest.limit(4)
  end

  def about
  end
end

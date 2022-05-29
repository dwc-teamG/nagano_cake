class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    flash[:notice] = "ジャンルを登録しました"
    #非同期を行っているので、saveを行った後でデータを全て取り出してくる必要がある
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
    flash[:notice] = "ジャンル情報を登録しました"
    redirect_to admin_genres_path
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
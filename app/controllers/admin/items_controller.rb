class Admin::ItemsController < ApplicationController
  def index
    if params[:search].present? #もしform_withで:search情報が送られてきたら
      @items = Item.where('name LIKE ?', "%#{params[:search]}%")
      #Itemの情報からwhereでnameカラムに送られた文字と一致するものを探す
      # @items = @items.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present? 一行で書くとこうなる
    else #form_withで送られなかったら
      @items = Item.all
    end
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save #エラー箇所？？？
    redirect_to admin_item_path(item)

  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:name, :genre_id, :description, :tax_excluded_price, :image, :is_on_sale)
  end


end

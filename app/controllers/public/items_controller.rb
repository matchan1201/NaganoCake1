class Public::ItemsController < ApplicationController
  def top
  end

  def index
  @genres = Genre.where(is_valid: true)

  @items = [] ## 空の配列を作成
  @genres.each do |genre|## is_validがtrueのジャンルの情報をeachで回す。
    genre.items.each do |item|##is_validがtrueのジャンルに紐づいているitemsをとりだしてeachで回す
      if item.is_on_sale == true##itemのis_on_saleがtrueだったら
         @items.push(item)##@itemsの空の配列の中にitemの情報を代入する。
      end
    end
  end



  	if params[:genre_id]
         genre = Genre.find(params[:genre_id])
         @items = genre.items
         @name = genre.name
    end
  end

  def show
  	@item = Item.find(params[:id])
  	@cart_item = CartItem.new
  	@end_user = current_end_user
  end
end

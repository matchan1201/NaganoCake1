class Public::CartItemsController < ApplicationController

    def index
    	# @cart_items = CartItem.where(end_user_id: current_end_user.id)
    	@end_user = current_end_user
    	@cart_items = @end_user.cart_item.all #current_end_userが持っているcart_itemのすべてを取得
        @cart_item = CartItem.new
    end


	def create
		@cart_item = CartItem.new(cart_items_params) #空のCartItemにcart_items_paramsを代入
		# @cart_items = CartItem.all #@cart_itemsにすべての情報を入れる
		# @cart_items.each do |cart_item| #eachで一つ一つ取り出す
		@cart = current_end_user.cart_item.find_by(item_id: params[:cart_item][:item_id]) #current_end_userのcart_itemから送られてきたcart_itemモデルのitem_idとitem_idが一致するものを探して@cartに代入
			# if cart_item.item_id == @cart_item.item_id #元々あるitem_idと追加したitem_idが一緒の時
			if @cart.present? #もし、@cartが存在したら？
			 new_amount = @cart.amount + @cart_item.amount #new_amountに、探した@cartのamountと追加した@cart_itemのamountを足していく
			 @cart.update(amount: new_amount) #cart_itemのamountカラムの内容をnew_amountに更新する
			else #もし、@cartがfalseで存在しなかったら、追加した@cart_itemを保存
			 @cart_item.save
			end
		# end
		 #cart_itemを保存
		redirect_to cart_items_path #redirectしてカートの一覧へ
	end

	def update
		@cart_item = CartItem.find(params[:id]) #送られてきたidを受け取って、CartItemモデルのidと同じものを探す
		@cart_item.update(cart_items_params)
		redirect_to cart_items_path
    end

    def destroy
    	@cart_item = CartItem.find(params[:id])#送られてきたidを受け取って、CartItemモデルのidと同じものを探す
    	@cart_item.destroy
    	redirect_to cart_items_path
    end

    def destroy_all
    	@cart_item = CartItem.all
    	@cart_item.destroy_all #modelを介して削除を行うため関連付けているモデルも削除される
    	redirect_to cart_items_path
    end


	private
	def cart_items_params
	params.require(:cart_item).permit(:item_id, :end_user_id, :amount)
  end
end

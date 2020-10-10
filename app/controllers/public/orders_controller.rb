class Public::OrdersController < ApplicationController
	def new
		@cart_item = CartItem.find_by(end_user_id: current_end_user.id) #CartItemモデルからend_user_idカラムのidがcurrent_end_user.idと一緒のものを探して1つだけ@cart_itemに代入
		@order =Order.new #orderモデルのからモデルを作成
		@end_user = current_end_user
		# @address = Address.where(end_user_id: @end_user.id).count
		# binding.pry
		# if @address == 0
		# 	redirect_to cart_items_path
		# end
	end

	def information
		@cart_items = CartItem.where(end_user_id: current_end_user.id) #@cart_itemsにCartItemモデルのend_user_idカラムのidがcurrent_end_user.idと一緒のものを探してすべてを@cart_itemsに代入
		@shipping = 800 #@shippingに800を代入
		if params[:order][:address_option] == "0" #もし、受け取った値がOrderモデルのaddress_optionが０の場合
			@order = Order.new(payment_methods: params[:order][:payment_methods], postal_code: current_end_user.postal_code,address: current_end_user.address, addressee: current_end_user.first_name, addressee: current_end_user.last_name)
			#ストロングパラメーターを使わない場合のnewの使い方。
		elsif params[:order][:address_option] == "1" #受け取った値がOrderモデルのaddress_optionが1の場合
			@add = Address.find_by(id: params[:order][:adress]) #@addにAddressモデルにあるidが受け取ったorderモデルのadressを探して代入
			#<%= f.collection_select :adress, Address.all, :id, :postal_address_addressee, {},{ class: "col-xs-10" } %>このadressの値を探している
			@order = Order.new(payment_methods: params[:order][:payment_methods], postal_code: @add.postal_code,address: @add.address, addressee: @add.addressee)
		elsif params[:order][:address_option] == "2"#受け取った値がOrderモデルのaddress_optionが1の場合
			@order = Order.new(orders_params) #@orderの空のモデルを作成し、そこにストロングパラメーターを代入する
		end
	end

	def completed
	end

	def create
		@cart_item = CartItem.where(end_user_id: current_end_user.id) #@cart_itemsにCartItemモデルのend_user_idカラムのidがcurrent_end_user.idと一緒のものを探してすべてを@cart_itemsに代入
		@order = Order.new(orders_params) #@orderの空のモデルを作成し、そこにストロングパラメーターを代入する
		@order.save #@orderを保存する

        current_end_user.cart_item.each do |cart_item| #current_end_userが持っているcart_itemテーブルを呼び出して,ブロック変数にcart_itemとして代入することで
                                                       #繰り返しごとにidを与えることが出来る
            order_detail = @order.order_details.new #order_detailというローカル変数に@orderがもつorder_detailsテーブルを作り空のモデルを作成する
            order_detail.order_id = @order.id #order_detailがもつorder_idカラムに@orderがもつidを代入する
            order_detail.item_id = cart_item.item_id #order_detailがもつitem_idカラムにcurrent_end_userが持つitem_idを代入
            order_detail.quanitity = cart_item.amount #order_detailが持つ数量カラムにcurrent_end_userが持つcart_itemのamountを代入する
            order_detail.unit_price = cart_item.item.tax_excluded_price #ordet_detailsの単価の部分にcart_itemがもつitemの価格を代入
            order_detail.production_status = :not_start #order_detailの製作ステータスの部分に modelに記入したenumを代入する
            order_detail.save #order_detailを保存する
            cart_item.destroy #保存出来たらcart_itemの商品を削除する
        end
		redirect_to cart_item_completed_path
	end

	def index
	end

	def show
	end

	private

	def orders_params
		params.require(:order).permit(:payment_methods, :address, :postal_code, :addressee,:end_user_id,:shipping_fee, :billing_price_sum, :order_status)
	end
end

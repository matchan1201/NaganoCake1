class Admin::OrdersController < ApplicationController
	def index
		 @orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		@change_order = Order.new
		@change_item = CartItem.all
	end

	def update
		@order = Order.find(params[:id]) #送られてきたidを受け取って、CartItemモデルのidと同じものを探す
		@order.update(order_status: params[:order][:order_status])
		if @order.order_status == "confilm"
		   @detail = OrderDetail.where(order_id: params[:id]) #送られてきたidを受け取って、CartItemモデルのidと同じものを探す
		   @detail.update(production_status: "waiting")
		 end
		# @order.update(orders_params)
		redirect_to request.referer
	end

	# private
	# def orders_params
	# params.require(:order).permit(:payment_methods, :address, :postal_code, :addressee,:end_user_id,:shipping_fee, :billing_price_sum, :order_status)
 #  end

end

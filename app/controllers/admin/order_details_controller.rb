class Admin::OrderDetailsController < ApplicationController
	def update
		@detail = OrderDetail.find(params[:id]) #送られてきたidを受け取って、CartItemモデルのidと同じものを探す
		@detail_all = OrderDetail.where(order_id: @detail.order_id)
		@order = Order.find_by(id: @detail.order.id)
		@detail.update(production_status: params[:cart_item][:production_status])
		if @detail.production_status == "start"
		   @order.update(order_status: "producting")
		elsif
		 @detail_all.where(production_status: "finish").count == @order.order_details.count
		 @order.update(order_status: "before_shipping")
		end
		redirect_to request.referer
	end
end



# elsifの部分に入れる
# # production_statuses = Array.new
# # #@order.order_details.each do |order_detail|
#    # production_statuses.push(order_detail.production_status)
# # end
#  unless production_statuses.include?~含む("finish")|| production_statuses.include?~含む("waiting")|| production_statuses.include?~含む("producting")
#    @order.update(order_status: "before_shipping")
#  end
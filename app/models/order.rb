class Order < ApplicationRecord
	belongs_to :end_user, -> {with_deleted} #親のクラスは削除したものも取ってくるように設定
	has_many :order_details

	validates :payment_methods, presence: true

	enum payment_methods: { credit: 0, bank: 1 }
	enum order_status: {waiting: 0, confilm: 1, producting: 2, before_shipping: 3, done_shipping: 4}
	

	def order_count
		sum = 0
		self.order_details.each do |detail| # selfはorderモデルを表しているため、order.allと同じ意味？
			# selfは使う先(view)を利用している
			sum += detail.quanitity
		end
		return sum
	end

	def order_prace
		sum = 0
		self.order_details.each do |order_detail|
			sum += order_detail.unit_price * order_detail.quanitity
		end 
		return sum
	end

end

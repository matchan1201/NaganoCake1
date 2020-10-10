class Item < ApplicationRecord
	belongs_to :genre
	has_many :cart_item #cart_itemsになっていないので、コントローラで呼び出すときにcart_itemsにするとエラーが出る
	has_many :order_datails
	attachment :image
end

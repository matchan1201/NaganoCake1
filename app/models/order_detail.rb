class OrderDetail < ApplicationRecord
	belongs_to :order
	belongs_to :item

	enum production_status: { not_start: 0, waiting: 1, start: 3, finish: 4 }
end

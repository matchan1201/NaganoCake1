class Address < ApplicationRecord
	belongs_to :end_user
	def postal_address_addressee
		self.postal_code.to_s + "　" + self.address + "　" + self.addressee 
	end
end

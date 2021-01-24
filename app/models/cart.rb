class Cart < ApplicationRecord
	belongs_to :user, optional: true
	has_many :position
	has_many :items, through: :positions
	# TODO for_carts_items
	#has_and_belongs_to_many :items
end

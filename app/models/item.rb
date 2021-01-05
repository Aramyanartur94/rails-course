class Item < ApplicationRecord
	validates :price, numericality: { greater_than: 0 }
	validates :name, presence: true
end

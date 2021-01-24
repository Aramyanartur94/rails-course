class Item < ApplicationRecord
	validates :price, numericality: { greater_than: 0 }
	validates :name, presence: true
	has_many :position
	has_many :carts, through: :positions
	# TODO for_carts_items
	#has_and_belongs_to_many :carts

	after_initialize { p 'initialize' } # Item.new Item.first , колбек будет вызван после инициализации
	after_save { p 'save' } # колбек будет вызван после Item.create либо после Item.save
	#after_create { WhatsApp.sent_messege(self) } # колбек будет вызван после Item.create
	after_update { p 'update' } # колбек будет вызван после Item.update
	after_destroy { p 'destroy' } # колбек будет вызван после Item.last.destroy 
end
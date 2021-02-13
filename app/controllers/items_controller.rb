class ItemsController < ApplicationController
		layout "application"
	skip_before_action :verify_authenticity_token
	before_action :find_item, only: %i[show edit update destroy upvote]
	before_action :admin?, only: %i[edit]
	after_action :show_info, only: %i[index] 
	
	def index
		@items = Item.all
		@items = @items.includes(:image)

		#@items = Item.all.order(:votes_count)
		#@items = Item.all.order(:price)
		#@items = Item.all.sort
		#@items = Item.all.order('votes_count DESC')
		#@items = Item.all.order('votes_count DESC', 'price') сначала отсортировал по order_count потом отсортировал еще по price
		#@items = Item.all.order('votes_count DESC', 'price').limit 3  (ограничело выборку 3 товара)
		#@items = Item.all.order(:id).limit 10

		#@items = Item.where('price: 200')
		#@items = Item.where('votes_count: 3')
		#@items = Item.where('price: 200, votes_count: 3')
		#@items = Item.where('name: car, price: 200, votes_count: 3')
		#@items = Item.where('price >= 200 OR votes_count >= 3')
		#@items = Item.where('price >= ?', params[:price_from])

		##@items = Item
		##@items = @items.where('price >= ?', params[:price_from]) if params[:price_from]
		##@items = @items.where('created_at >= ?', 1.day.ago) if params[:today]
		##@items = @items.where('votes_count >= ?', params[:votes_from]) if params[:votes_from]
		##@items = @items.order(:id)
	end

	def create

		item = Item.new(items_params)
		if item.valid?
			item.save
			redirect_to items_path
		else
			render body: "NO"
			#render json: item.errors, status: :unprocessable_entity
		end
	end

	
	def new
	end

	def show
			render body: 'Page not found', status: 4040 unless @item
	end

	def edit
	end

	def update 
    if @item.update(items_params)
      redirect_to item_path(@item)
    else
      render action: 'edit'
    end
	end

	def destroy
		if @item.destroy.destroyed?
			redirect_to items_path
		else
			render json: item.errors, status: :unprocessable_entity
		end
	end

	def upvote
		@item.increment!(:votes_count) #увеличим на единицу данное поле
		redirect_to items_path
	end

	def expensive
		@items = Item.where("price > 50")
		render :index
	end

	private
	
	def items_params
		params.require(:item).permit(:name, :price, :description)
	end
	
	def find_item
		@item = Item.where(id: params[:id]).first
		#@item = Item.find(params[:id])
		render_404 unless @item	
	end	

	def show_info
		puts 'Index endpoint'
	end

end

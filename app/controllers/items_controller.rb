class ItemsController < ApplicationController
		
	skip_before_action :verify_authenticity_token

	def index
		@items = Item.all
	end

	def create

		item = Item.new(items_params)
		if item.valid?
			item.save
			render plain: params[:item].inspect
			#render json: item.name, status: :created
		else
			render body: "NO"
			#render json: item.errors, status: :unprocessable_entity
		end
	end

	
	def new
	end

	def show
		unless (@item = Item.where(id: params[:id]).first)
			render body: 'Page not found', status: 4040
		end
	end

	def edit
			@item = Item.find(params[:id])
	end

	def update 
		@item = Item.find(params[:id])
      if @item.update(items_params)
      redirect_to item_path(@item)
    else
      render action: 'edit'
    end
	end

	def destroy
		item = Item.where(id: params[:id]).first.destroy
		if item.destroyed?
			redirect_to items_path
		else
			render json: item.errors, status: :unprocessable_entity
		end
	end

	private
	
	def items_params
		params.require(:item).permit(:name, :price, :description)
	end
	
end

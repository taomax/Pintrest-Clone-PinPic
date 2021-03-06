class PinsController < ApplicationController

	before_action :authenticate_user!
	
	def index
		@pins=Pin.all
	end

	def show
		@pin=Pin.find(params[:id])
	end

	def new
		@pin=current_user.pins.build
	end

	def create
		@pin=current_user.pins.build(pin_params)
		if @pin.save
			redirect_to @pin, notice: "Your new pin was successfully created."
		else
			render :new
		end
	end

	def edit
		@pin=Pin.find(params[:id])
	end

	def update
		@pin=Pin.find(params[:id])
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Successfully Updated!"
		else
			render :edit
		end
	end

	def destroy
		@pin=Pin.find(params[:id])
		@pin.destroy
		redirect_to root_path
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end
end

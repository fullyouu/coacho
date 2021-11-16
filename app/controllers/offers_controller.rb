class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @offers = Offer.all
  end

  def show
    id = params[:id]
    @offer = Offer.find(id)
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(strong_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new
    end
  end

  private

  def strong_params
    params.require(:offer).permit(:title, :details, :price, :duration, :category)
  end
end

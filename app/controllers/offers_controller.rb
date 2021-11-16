class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_offer, only: %i[show edit update destroy]

  def index
    @offers = Offer.all
  end

  def show
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

  def edit
  end

  def update
    @offer.update(strong_params)

    redirect_to offer_path(@offer)
  end

  def destroy
    @offer.destroy

    redirect_to offers_path
  end

  private

  def strong_params
    params.require(:offer).permit(:title, :details, :price, :duration, :category)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end

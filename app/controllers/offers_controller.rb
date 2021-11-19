class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_offer, only: %i[show edit update destroy]

  def index
    @offers = policy_scope(Offer)
  end

  def show
    @appointment = Appointment.new
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(strong_params)
    authorize @offer
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
    if @offer.update(strong_params)
      redirect_to offer_path(@offer)
    else
      render :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_to offers_path
  end

  private

  def strong_params
    params.require(:offer).permit(:title, :details, :price, :duration, :category, :photo)
  end

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end
end

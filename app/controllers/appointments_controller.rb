class AppointmentsController < ApplicationController
  def index
    appointments = Appointment.all
    @appointments_as_coachee = appointments.select { |appoint| appoint.user_id == params[:id] }
    @appointments_as_coach = appointments.select { |appoint| appoint.user_id == appoint.offer.user_id }
  end

  def create
    appointment = Appointment.new(strong_params)
    authorize appointment
    appointment.user = current_user
    offer = Offer.find(params[:offer_id])
    appointment.offer = offer
    appointment.status = "unconfirmed"
    appointment.save!
    redirect_to offer_path(offer)
  end

  def update
    appointment = Appointment.find(params[:id])
    authorize appointment
    appointment.update!
  end

  private

  def strong_params
    params.require(:appointment).permit(:date)
  end
end

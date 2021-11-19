class DashboardController < ApplicationController

  def show
    current_user
    authorize(:dashboard)
    @appointments_as_coach = Appointment.select { |appoint| appoint.offer.user == current_user }
    @appointments_as_coachee = Appointment.select { |appoint| appoint.user == current_user }
  end
end

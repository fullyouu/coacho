class DashboardController < ApplicationController

  def show
    current_user
    authorize(:dashboard)
  end
end

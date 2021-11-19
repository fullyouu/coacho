class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    true
  end

  def update?
    true
  end
end

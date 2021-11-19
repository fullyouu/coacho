class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :appointments # appointments as a client
  has_many :offers
  has_many :appointments_as_owner, through: :offers, source: :appointments
  has_one_attached :photo
  validates :first_name, :last_name, :city, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end

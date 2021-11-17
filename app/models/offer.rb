class Offer < ApplicationRecord
  belongs_to :user

  validates :details, length: { minimum: 20 }
  validates :title, :details, :price, :duration, :category, presence: true
end

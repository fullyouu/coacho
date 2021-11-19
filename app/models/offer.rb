class Offer < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_one_attached :photo

  validates :details, length: { minimum: 20 }
  validates :title, :details, :price, :duration, :category, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
  against: %i[ title details ],
  using: {
    tsearch: { prefix: true }
  }
end

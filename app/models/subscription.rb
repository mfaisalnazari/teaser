class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates :frequency, presence: true

  belongs_to :customer
  belongs_to :tea
end

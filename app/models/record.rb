class Record < ApplicationRecord

  validates :title, :amount, presence: true
  validates :amount, numericality: true
  belongs_to :user
end

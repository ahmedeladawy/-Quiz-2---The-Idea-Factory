class Idea < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
end

class Idea < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :title, presence: true

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user


  def liked_by?(user)
      likes.exists?(user: user)
  end

  def like_for(user)
      likes.find_by(user: user)
  end

end

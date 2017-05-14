class User < ApplicationRecord
  has_secure_password
  has_many :ideas , dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea

  validates :user_id, uniqueness: { scope: :question_id }

  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


def full_name
  "#{first_name}"
end

end

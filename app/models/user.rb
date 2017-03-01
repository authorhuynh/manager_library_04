class User < ApplicationRecord
  has_many :active_follow_user, class_name:  FollowUser.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow_user, class_name:  FollowUser.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_follow_user, source: :followed
  has_many :followers, through: :passive_follow_user, source: :follower
  has_many :requests, dependent: :destroy
  validates :name,  presence: true, length: {maximum: Settings.maximum_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.maximum_email},
    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end

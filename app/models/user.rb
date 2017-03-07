class User < ApplicationRecord

  attr_accessor :remember_token
  before_save {self.email = email.downcase}
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
  validates :password, presence: true, length: {minimum:Settings.maximum_password}, 
    allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token 
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end

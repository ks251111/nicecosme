class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :articles
  has_many :comments
  has_many :likes
  has_many :talks
  has_many :responses
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user
  has_one_attached :image
  
  with_options presence: true do
    validates :nickname
    validates :user_id
    validates :follower_id
  end

  VALID_PASSWORD_REGIX = /\A[a-z0-9]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGIX }, on: :create
  validates :password, format: { with: VALID_PASSWORD_REGIX }, on: :update, allow_blank: :true

  def liked_by?(article_id)
    likes.where(article_id: article_id).exists?
  end

  def following?(user)
    followings.include?(user)
  end

  def follow(user_id)
    relationships.create(follower: user_id)
  end

  def unfollow(relationship_id)
    relationships.find(relationship_id).destroy!
  end
end

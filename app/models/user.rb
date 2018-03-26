class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: {male:1, female:2}

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships

  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  belongs_to :residence
  belongs_to :alcohol

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def followered?(other_user)
    follower_relationships.find_by(follower_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def matchers
    followings & followers
  end

end

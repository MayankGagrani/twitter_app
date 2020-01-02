class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:token_authenticatable

  has_many :authentication_tokens, dependent: :destroy
  has_many :tweets, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  # has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  # has_many :following, through: :following_relationships, source: :following


  def follow(user_id)
    begin
      follower_relationships.create(follower_id: user_id)
    rescue Exception => e
      self.errors.add(:base, e.message)
    end
  end

  def unfollow(user_id)
    begin
      follower_relationships.find_by(follower_id: user_id).destroy
    rescue Exception => e
      self.errors.add(:base, "Please follow this user first")
    end
  end

end

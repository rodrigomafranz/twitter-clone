class User < ApplicationRecord
	has_many :messages
	has_many :followers, -> {active}, class_name: 'Fellowship', foreign_key: 'followed_user_id'
	has_many :following, -> {active}, class_name: 'Fellowship', foreign_key: 'follower_user_id'

	has_secure_password

	validates :name, :email, presence: true
	validates :email,      uniqueness: {case_sensitive: false}

	def authenticate(password)
		user = super(password)

		return user if user.is_a?(User)

		errors.add(:password, 'is invalid!')

		false
	end

	def follow(user)
		following.create(followed_user: user)
	end

	def unfollow(user)
		following.find_by(followed_user: user).destroy
	end

	def following?(user_id)
		following.pluck(:followed_user_id ).include?(user_id)
	end

end

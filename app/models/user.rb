class User < ApplicationRecord
	has_many :messages
	has_secure_password

	validates :name, :email, presence: true
	validates :email,      uniqueness: {case sensitive: false}

	def authenticate(password)
		user = super(password)

		return user unless user.is_a?(User)

		errors.add(:password, 'is invalid!')

		false
	end
end

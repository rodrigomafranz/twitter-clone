class User < ApplicationRecord
	has_many :messages
	has_secure_password

	validates :name, :email, presence: true
	validates :email,      uniqueness: {case_sensitive: false}

	def authenticate(password)
		user = super(password)

		return user if user.is_a?(User)

		errors.add(:password, 'is invalid!')

		false
	end
end

class User < ApplicationRecord
	validates :email, presence: true, uniqueness: true 
	validates :password, length: {minimum: 6}
	has_many :posts
	has_secure_password

	def readPosts
		return self.posts
	end

end

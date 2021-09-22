class User < ApplicationRecord
	validates :email, presence: true, uniqueness: true #email have to be exist
	validates :password, length: {minimum: 6}
	has_many :posts

	def readPosts
		return self.posts
	end
end

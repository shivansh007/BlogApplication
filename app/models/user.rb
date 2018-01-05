class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	validates :username, presence: true,
			   length: {minimum: 2}
end

class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true
  validates :article, presence: true
end

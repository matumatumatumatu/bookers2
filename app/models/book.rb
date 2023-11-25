class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: { message: "Title can't be blank" }
  validates :body, presence: true, length: { minimum: 1, maximum: 200 }
end
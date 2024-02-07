# frozen_string_literal: true

# Validate for title and date
class Book < ApplicationRecord
  validates :title, presence: true
  validates :publish_date, presence: true

  has_one_attached :avatar

  def book_image(size)
    avatar.variant(resize_to_limit: [size, size]).processed
  end
end

# frozen_string_literal: true

# Validate for title and date
class Book < ApplicationRecord
  validates :title, :publish_date, presence: true
  has_one_attached :book_cover

  def book_image(size)
    book_cover.variant(resize_to_limit: [size, size]).processed
  end
end

# frozen_string_literal: true

# Validate for title and date
class Book < ApplicationRecord
  validates :title, :publish_date, :isbn, presence: true
  validate :isbn_valid

  has_one_attached :book_cover

  def book_image(size)
    book_cover.variant(resize_to_limit: [size, size]).processed
  end

  private

  def isbn_valid
    if isbn.length == 10
      unless valid_isbn_10?(isbn)
        errors.add(:isbn, 'is not a valid ISBN')
      end
    elsif isbn.length == 13
      unless valid_isbn_13?(isbn)
        errors.add(:isbn, 'is not a valid ISBN')
      end
    else
      errors.add(:isbn, 'ISBN must 10 or 13 characters long')
    end
  end

  def valid_isbn_10?(isbn)
    sum = isbn.chars[0..8].map.with_index { |num, index| num.to_i * (10 - index) }.sum
    checksum = sum % 11
    checksum = 11 - checksum if checksum != 0
    checksum == isbn[-1].to_i || (checksum == 10 && isbn[-1].upcase == 'X')
  end

  def valid_isbn_13?(isbn)
    sum = isbn.chars[0..11].map.with_index { |num, index| num.to_i * (index.even? ? 1 : 3) }.sum
    checksum = sum % 10
    checksum = 10 - checksum if checksum != 0
    checksum == isbn[-1].to_i
  end
end

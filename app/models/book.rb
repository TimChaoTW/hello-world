# frozen_string_literal: true

# Validate for title and date
class Book < ApplicationRecord
  validates :title, presence: true
  validates :publish_date, presence: true
end

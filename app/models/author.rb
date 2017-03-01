class Author < ApplicationRecord 
  has_many :books, dependent: :destroy
  has_many :follow_authors, dependent: :destroy
end

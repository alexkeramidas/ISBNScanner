class Book < ActiveRecord::Base
    has_many :authors_book
    has_many :authors, through: :authors_book
    has_many :books_publisher
    has_many :publishers, through: :books_publisher
    validates_uniqueness_of :isbn
end

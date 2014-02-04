class Author < ActiveRecord::Base
    has_many :authors_book
    has_many :books, through: :authors_book
    validates_uniqueness_of :name
end

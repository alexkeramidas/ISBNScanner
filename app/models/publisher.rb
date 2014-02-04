class Publisher < ActiveRecord::Base
    has_many :books_publisher
    has_many :books, through: :books_publisher
    validates_uniqueness_of :name
end

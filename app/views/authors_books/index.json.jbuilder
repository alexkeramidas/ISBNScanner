json.array!(@authors_books) do |authors_book|
  json.extract! authors_book, :id, :author_id, :book_id
  json.url authors_book_url(authors_book, format: :json)
end

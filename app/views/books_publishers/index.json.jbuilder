json.array!(@books_publishers) do |books_publisher|
  json.extract! books_publisher, :id, :book_id, :publisher_id
  json.url books_publisher_url(books_publisher, format: :json)
end

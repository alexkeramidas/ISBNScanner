json.array!(@books) do |book|
  json.extract! book, :id, :isbn, :title, :image, :published
  json.url book_url(book, format: :json)
end

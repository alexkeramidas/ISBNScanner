module Isbnscanner
    class API < Grape::API
        prefix "api"
        version 'v1', using: :path
        format :json

        resource :books do
            desc 'Return the collection of books'
            get do
                {books: Book.all.as_json(only: [:id,:isbn, :title, :image, :published], include: [{authors: {only: [:id,:name]}}, {publishers: {only: [:id,:name]}}])}
            end

            desc 'Return a book by id'
            get ':id' do
                {book: Book.where(id: params[:id]).as_json(only: [:id,:isbn, :title, :image, :published], include: [{authors: {only: [:id,:name]}}, {publishers: {only: [:id,:name]}}])}
            end

            desc 'Post a full new book with multiple authors and multiple publishers or skip'
            post do
                    if
                        !Book.find_by isbn: params[:isbn]
                            @book = Book.new
                            @book.isbn = params[:isbn] if params[:isbn]
                            @book.title = params[:title] if params[:title]
                            @book.image = params[:image] if params[:image]
                            @book.published = params[:published] if params[:published]
                            @book.save

                            @numberofauthors = Integer(params[:authors]) if params[:authors]

                            (1..@numberofauthors).each do |i|

                                @authorparameter = "author_#{i}"

                                if
                                    Author.find_by name: params[@authorparameter]
                                    @author = Author.find_by name: params[@authorparameter]
                                else
                                    @author = Author.new
                                    @author.name = params[@authorparameter] if params[@authorparameter]
                                    @author.save
                                end

                                @authorbook = AuthorsBook.new
                                @authorbook.author_id = @author.id
                                @authorbook.book_id = @book.id
                                @authorbook.save

                            end

                            @numberofpublishers = Integer(params[:publishers]) if params[:publishers]

                            (1..@numberofpublishers).each do |i|

                                @publisherparameter = "publisher_#{i}"

                                if
                                    Publisher.find_by name: params[@publisherparameter]
                                    @publisher = Publisher.find_by name: params[@publisherparameter]
                                else
                                    @publisher = Publisher.new
                                    @publisher.name = params[@publisherparameter] if params[@publisherparameter]
                                    @publisher.save
                                end

                                @bookpublisher = BooksPublisher.new
                                @bookpublisher.book_id = @book.id
                                @bookpublisher.publisher_id = @publisher.id
                                @bookpublisher.save

                            end

                            @response = "Book, publishers and authors saved succesfully"
                    else
                            @response = "The book exists"
                    end
                    status 201
                    @response
            end
        end

        resource :authors do
            desc 'Return the collection of authors'
            get do
                {authors: Author.all.as_json(only: [:id, :name])}
            end

            desc 'Return a specific author'
            get ':id' do
                {author: Author.where(id: params[:id]).as_json(only: [:id, :name])}
            end

            desc 'Post a new author'
            post do
                @author = Author.new
                @author.name = params[:name] if params[:name]
                @author.save

                status 201
                @author
            end

            desc 'Get books for author'
            get ':id/books' do
                {books: Author.find(params[:id]).books.as_json(only: [:id,:isbn, :title, :image, :published], include: [{authors: {only: [:id,:name]}}, {publishers: {only: [:id,:name]}}])}
            end


            desc 'Get book for author'
            get ':id/books/:book_id' do
                {book: Author.find(params[:id]).books.where(id: params[:book_id]).as_json(only: [:id,:isbn, :title, :image, :published], include: [{authors: {only: [:id,:name]}}, {publishers: {only: [:id,:name]}}])}
            end
        end

        resource :publishers do
            desc 'Return the collection of publishers'
            get do
                {publishers: Publisher.all.as_json(only: [:id, :name])}
            end

            desc 'Return a specific publisher'
            get ':id' do
                {publisher: Publisher.where(id: params[:id]).as_json(only: [:id, :name])}
            end

            desc 'Post a new publisher'
            post do
                @publisher = Publisher.new
                @publisher.name = params[:name] if params[:name]
                @publisher.save

                status 201
                @publisher
            end

            desc 'Get books for publisher'
            get ':id/books' do
                {books: Publisher.find(params[:id]).books.as_json(only: [:id,:isbn, :title, :image, :published], include: [{authors: {only: [:id,:name]}}, {publishers: {only: [:id,:name]}}])}
            end

            desc 'Get book for publisher'
            get ':id/books/:book_id' do
                {book: Publisher.find(params[:id]).books.where(id: params[:book_id]).as_json(only: [:id,:isbn, :title, :image, :published], include: [{authors: {only: [:id,:name]}}, {publishers: {only: [:id,:name]}}])}
            end
        end
    end
end
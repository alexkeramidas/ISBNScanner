ActiveAdmin.register Book do
    menu :priority => 2, :parent => "Books Management"
    filter :authors, collection: proc {Author.all.map { |author| [author.name, author.id] }}
    filter :publishers, collection: proc {Publisher.all.map { |publisher| [publisher.name, publisher.id] }}
    filter :ibsn
    filter :title
    filter :published
    filter :created_at
    filter :updated_at

    index do
        selectable_column
        column :isbn
        column :title
        column :published
        column :image
        column "Authors" do |author|
            author.authors.map{ |a| [a.name]}.join(', ')
        end
        column "Publishers" do |publisher|
            publisher.publishers.map{ |p| [p.name]}.join(', ')
        end
        column :created_at
        column :updated_at
        default_actions
    end

    show do |book|
        attributes_table do
            row :isbn
            row :title
            row :published
            row :authors do
                ul do
                    book.authors.each do |author|
                        ul do
                            li do author.name end
                        end
                    end
                end
            end
            row :publishers do
                ul do
                    book.publishers.each do |publisher|
                        ul do
                            li do publisher.name end
                        end
                    end
                end
            end
        end
    end

    form do |book|
        book.inputs "Book Details" do
            book.input :isbn
            book.input :title
            book.input :image
            book.input :published
        end
        book.inputs "Select from the available authors" do
            book.input :authors, :as => :check_boxes
        end
        book.inputs "Select from the available publishers" do
            book.input :publishers, :as => :check_boxes
        end
        book.actions
    end

    controller do
        def permitted_params
            params.permit book: [:isbn, :title, :image, :published, {author_ids: []}, {publisher_ids: []}]
        end
    end

end

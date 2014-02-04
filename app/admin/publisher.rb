ActiveAdmin.register Publisher do
  menu :priority => 3, :parent => "Books Management"
    filter :books, collection: proc {Book.all.map { |book| [book.title, book.id] }}
    filter :name
    filter :created_at
    filter :updated_at

    index do
        selectable_column
        column :name
        column "Books" do |book|
            book.books.map{ |b| [b.title]}.join(', ')
        end
        column :created_at
        column :updated_at
        default_actions
    end

    show do |publisher|
        attributes_table do
            row :name
            row :books do
                ul do
                    publisher.books.each do |book|
                        ul do
                            li do book.title end
                        end
                    end
                end
            end
        end
    end

    form do |publisher|
        publisher.inputs "Publisher Details" do
            publisher.input :name
        end
        publisher.actions
    end
  controller do
        def permitted_params
            params.permit publisher: [:name]
        end
    end
end

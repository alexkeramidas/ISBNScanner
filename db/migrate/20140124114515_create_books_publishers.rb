class CreateBooksPublishers < ActiveRecord::Migration
  def change
    create_table :books_publishers do |t|
      t.belongs_to :book
      t.belongs_to :publisher

      t.timestamps
    end
  end
end

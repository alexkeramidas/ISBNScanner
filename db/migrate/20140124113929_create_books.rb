class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :image
      t.string :published

      t.timestamps
    end
  end
end

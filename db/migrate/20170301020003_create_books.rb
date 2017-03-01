class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :image
      t.datetime :publish_date
      t.integer :page_number
      t.integer :number
      t.references :category, foreign_key: true
      t.references :author, foreign_key: true
      t.references :publisher, foreign_key: true
      t.timestamps
    end
  end
end

class CreatePublishers < ActiveRecord::Migration[5.0]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :city
      t.string :country
      t.timestamps
    end
  end
end

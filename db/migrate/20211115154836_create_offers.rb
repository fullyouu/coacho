class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.integer :price
      t.string :title
      t.text :details
      t.integer :duration
      t.string :category

      t.timestamps
    end
  end
end

class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :details
      t.integer :price
      t.integer :duration
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

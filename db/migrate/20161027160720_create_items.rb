class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :full_name
      t.string :brand
      t.integer :sku
      t.string :category_1
      t.integer :product_code
      t.boolean :in_stock
      t.text :details
      t.text :sizes
      t.string :color
      t.float :price
      t.string :washing_instructions
      t.string :materials
      t.text :photo_urls
      t.string :product_url

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :full_name
      t.string :brand
      t.integer :sku, null: false
      t.string :category_1
      t.integer :product_code
      t.boolean :in_stock
      t.string :details, array: true, default: []
      t.jsonb :sizes, default: {}
      t.string :color
      t.float :price
      t.string :washing_instructions
      t.jsonb :materials, default: {}
      t.string :photo_urls, array: true, default: []
      t.string :product_url

      t.timestamps
    end
  end
end

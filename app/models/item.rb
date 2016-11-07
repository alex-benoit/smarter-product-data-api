class Item < ApplicationRecord
  include PgSearch

  default_scope { order('id ASC') }

  pg_search_scope :full_name, against: :full_name
  pg_search_scope :brand, against: :brand
  scope :sku, -> (sku) { where sku: sku }
  pg_search_scope :category_1, against: :category_1
  scope :product_code, -> (product_code) { where product_code: product_code }
  scope :in_stock, -> { where in_stock: true }
  pg_search_scope :details, against: :details
  pg_search_scope :color, against: :color
  scope :price_under, -> (price) { where 'price < ?', price }
  scope :price_over, -> (price) { where 'price > ?', price }
end

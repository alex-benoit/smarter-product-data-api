class Item < ApplicationRecord
  include PgSearch

  default_scope { order('id ASC') }

  pg_search_scope :full_name, against: :full_name
  pg_search_scope :brand, against: :brand # THIS COULD BE A CHOSEN DROPDOWN
  scope :sku, -> (sku) { where sku: sku }
  pg_search_scope :category_1, against: :category_1 # THIS COULD BE A DROPDOWN
  scope :product_code, -> (product_code) { where product_code: product_code }
  scope :in_stock, -> (in_stock) { where in_stock: in_stock }
  pg_search_scope :details, against: :details
  pg_search_scope :color, against: :color # THIS COULD BE A CHOSEN DROPDOWN
  scope :min_price, -> (min_price) { where 'price >= ?', min_price }
  scope :max_price, -> (max_price) { where 'price <= ?', max_price }
end

class Item < ApplicationRecord
  default_scope { order('id ASC') }

  serialize :details, Array
  serialize :sizes, Array
  serialize :photo_urls, Array
end

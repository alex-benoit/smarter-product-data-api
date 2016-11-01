class Item < ApplicationRecord
  include AlgoliaSearch

  default_scope { order('id ASC') }

  serialize :details, Array
  serialize :sizes, Array
  serialize :photo_urls, Array

  algoliasearch index_name: "#{name}#{ENV['ALGOLIA_SUFFIX']}" do
    add_attribute :updated_at_i
    attributesToIndex ['unordered(full_name)', 'unordered(sku)', 'unordered(details)']
    customRanking ['asc(full_name)']
    attributesForFaceting %w(brand category_1 color)

    # tags do
    #   here we can add the incomplete tag for example
    #   eg: [first_name.blank? ? 'partial' : 'full']
    # end
  end

  def updated_at_i
    updated_at.to_i
  end
end

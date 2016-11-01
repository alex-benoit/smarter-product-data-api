class Item < ApplicationRecord
  include AlgoliaSearch

  default_scope { order('id ASC') }

  serialize :details, Array
  serialize :sizes, Array
  serialize :photo_urls, Array

  algoliasearch index_name: "#{name}#{ENV['ALGOLIA_SUFFIX']}" do
    # add_attribute :created_at_i do
    #   created_at.to_i
    # end
    add_attribute :updated_at_i do
      updated_at.to_i
    end
    attributesToIndex %w(unordered(full_name) unordered(sku) unordered(details))
    customRanking ['asc(full_name)']
    attributesForFaceting %w(brand category_1 color)

    # tags do
    # here we can add the incomplete tag for example
    # eg: [first_name.blank? ? 'partial' : 'full']
    # end
  end
end

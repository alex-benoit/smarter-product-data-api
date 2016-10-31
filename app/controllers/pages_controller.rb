class PagesController < ApplicationController
  def home
    render json: {
      items: 'api/v1/items',
      item: 'api/v1/items/{:id}'
    }
  end
end

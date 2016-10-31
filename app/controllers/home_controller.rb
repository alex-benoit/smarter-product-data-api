class HomeController < ApplicationController
  def home
    render json: {
      items: '.../v1/items',
      item: '.../v1/items/{:id}'
    }
  end
end

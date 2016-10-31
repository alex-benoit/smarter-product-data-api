class V1::ItemsController < V1::BaseController
  def index
    items = Item.all
    paginate json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end
end

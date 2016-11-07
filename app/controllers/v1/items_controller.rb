class V1::ItemsController < V1::BaseController
  def index
    items = Item.where(nil)
    filter_params(params).each do |key, value|
      items = items.public_send(key, value) if value.present?
    end
    paginate json: items, per_page: 20
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  private

  def filter_params(params)
    params.slice(:full_name, :brand, :sku, :category_1, :product_code, :in_stock, :details, :color, :price_under, :price_over)
  end
end

class PricesController < ApplicationController
  def index
    @stock = Stock.find_by_id(params[:stock_id])
    @prices = @stock.prices.order(id: :desc)
  end
end

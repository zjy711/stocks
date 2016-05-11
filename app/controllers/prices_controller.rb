class PricesController < ApplicationController
  def index
    @stock = Stock.find(params[:stock_id])
    @prices = @stock.prices.order(date: :desc)
  end
end

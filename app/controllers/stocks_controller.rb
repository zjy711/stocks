class StocksController < ApplicationController
  def index
    @stocks = Stock.all.order(id: :desc)
  end

  def show
    @stock = Stock.find_by_id(params[:id])
  end

  def price_history
  end

  def search_prices
    stock = Stock.find_by_id(params[:stock][:id])
    stock_prices = stock.prices.where(date: 30.days.ago..1.day.since).order(date: :asc)

    dates = stock_prices.pluck(:date).map {|date| date.strftime('%Y-%m-%d')}
    prices = stock_prices.pluck(:price)

    respond_to do |format|
      format.json { render json: { stock_name: stock.name, dates: dates, prices: prices } }
    end
  end
end

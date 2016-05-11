class StocksController < ApplicationController
  def index
    @stocks = Stock.all.order(id: :desc)
  end

  def price_history
  end

  def search_prices
    stock = Stock.find(params[:stock][:id])

    stock_prices = stock.prices.where(date: 30.days.ago.to_date..1.day.from_now.to_date).order(date: :asc)

    dates = stock_prices.pluck(:date).map {|date| date.strftime('%Y-%m-%d')}
    prices = stock_prices.pluck(:price)

    respond_to do |format|
      format.json { render json: { stock_name: stock.name, dates: dates, prices: prices } }
    end
  end
end
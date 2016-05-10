require 'rails_helper'

RSpec.describe PricesController, type: :controller do
  describe 'GET#index' do
    it 'returns 200 status code' do
      stock = Stock.create(name: 'SF Symphony')

      get :index, stock_id: stock.id
      expect(response.status).to eq 200
    end

    it 'renders the view' do
      stock = Stock.create(name: 'SF Symphony')

      get :index, stock_id: stock.id
      expect(response).to render_template(:index)
    end

    it 'assigns @prices' do
      stock1 = Stock.create(name: 'SF Symphony')
      stock2 = Stock.create(name: 'SFJAZZ')

      stock1_price1 = stock1.prices.create(date: 1.day.ago, price: 12.55)
      stock1_price2 = stock1.prices.create(date: 3.day.ago, price: 22.55)
      stock2_price1 = stock2.prices.create(date: 2.day.ago, price: 32.55)
      stock2_price2 = stock2.prices.create(date: 3.day.ago, price: 42.55)

      get :index, stock_id: stock1.id
      expect(assigns(:prices).map(&:id)).to eq [stock1_price1.id, stock1_price2.id]
    end
  end
end

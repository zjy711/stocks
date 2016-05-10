require 'rails_helper'

RSpec.describe StocksController do
  describe 'GET#index' do
    it 'returns 200 status code' do
      get :index
      expect(response.status).to eq 200
    end

    it 'renders the view' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @stocks' do
      stock1 = Stock.create(name: 'SF Symphony')
      stock2 = Stock.create(name: 'SFJAZZ')

      get :index
      expect(assigns(:stocks).map(&:id)).to eq [stock2.id, stock1.id]
    end
  end
end

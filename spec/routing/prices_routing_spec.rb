require 'rails_helper'

RSpec.describe 'routes for prices', type: :routing do
  it 'routes /index to prices controller' do
    expect(get('/stocks/1/prices')).to route_to(controller: 'prices', action: 'index', stock_id: '1')
  end
end

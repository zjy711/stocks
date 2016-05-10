require 'rails_helper'

RSpec.describe 'routes for stocks', type: :routing do
  it 'routes root to stocks index action' do
    expect(get('/')).to route_to('stocks#index')
  end

  it 'routes /index to stocks controller' do
    expect(get('/stocks')).to route_to('stocks#index')
  end
end

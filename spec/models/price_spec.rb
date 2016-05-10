require 'rails_helper'

RSpec.describe Price, type: :model do
  before { @stock = Stock.create(name: 'Apple') }

  specify { expect(@stock.prices.new).not_to be_valid }
  specify { expect(@stock.prices.new(date: DateTime.now)).not_to be_valid }
  specify { expect(@stock.prices.new(date: DateTime.now, price: 'a')).not_to be_valid }
  specify { expect(@stock.prices.new(date: DateTime.now, price: -12.2)).not_to be_valid }

  specify { expect(@stock.prices.new(date: DateTime.now, price: 12.2)).to be_valid }
end

require 'rails_helper'

RSpec.describe Stock do
  specify { expect(Stock.new(name: 'PG&E')).to be_valid }
  specify { expect(Stock.new).not_to be_valid }
end

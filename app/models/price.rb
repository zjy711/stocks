class Price < ActiveRecord::Base
  belongs_to :stock

  validates :stock, presence: true
  validates :date, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end

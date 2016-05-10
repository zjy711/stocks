# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_stocks_with_prices
  companys = ['SF Symphony', 'SF JAZZ', 'PG&E', 'WallStreet Journal', 'National Geographic']
  companys.each do |name|
    stock = Stock.create(name: name)

    1.upto(60) do |i|
      date = i.days.ago.utc.beginning_of_day
      price = rand(1..100.00).round(2)
      stock.prices.create(date: date, price: price)
    end
  end
end

create_stocks_with_prices

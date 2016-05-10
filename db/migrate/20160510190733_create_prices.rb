class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.belongs_to :stock, index: true

      t.datetime :date, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps null: false
    end
  end
end

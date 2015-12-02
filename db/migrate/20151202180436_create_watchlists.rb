class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :watchlists do |t|
      t.integer :buyer_id
      t.integer :listing_id

      t.timestamps null: false
    end
  end
end

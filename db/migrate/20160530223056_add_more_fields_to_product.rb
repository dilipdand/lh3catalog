class AddMoreFieldsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :base_price, :string
    add_column :products, :per_campaign_price, :string
  end
end

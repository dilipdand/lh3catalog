class AddFieldsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :saas, :boolean
    add_column :products, :agency, :boolean
    add_column :products, :api, :boolean
    add_column :products, :compensation, :string
    add_column :products, :city, :string
    add_column :products, :state, :string
    add_column :products, :country, :string
    add_column :products, :smb_price, :string
    add_column :products, :ent_price, :string
    add_column :products, :freemium, :boolean
  end
end

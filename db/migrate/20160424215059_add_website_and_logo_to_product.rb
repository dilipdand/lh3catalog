class AddWebsiteAndLogoToProduct < ActiveRecord::Migration
  def change
    add_column :products, :website, :string
    add_column :products, :logo, :string
  end
end

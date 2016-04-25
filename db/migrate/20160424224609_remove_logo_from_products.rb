class RemoveLogoFromProducts < ActiveRecord::Migration
  def change
		remove_column :products, :logo
  end
end

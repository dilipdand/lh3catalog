class AddLogoToProducts < ActiveRecord::Migration
  def self.up
	add_attachment :products, :logo
  end

  def self.down
	remove_attachment :products, :logo
  end
end

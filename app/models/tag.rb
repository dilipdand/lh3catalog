class Tag < ActiveRecord::Base
has_many :product_tags
has_many :products, through: :product_tags

has_many :category_tags
has_many :categories, through: :category_tags

def all_categories=(names)
  self.categories = names.split(",").map do |name|
      Category.where(name: name.strip).first_or_create!
  end
end

def all_categories
  self.categories.map(&:name).join(", ")
end
end

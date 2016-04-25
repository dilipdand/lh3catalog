class Category < ActiveRecord::Base
has_many :product_categories
has_many :products, through: :product_categories

has_many :category_tags
has_many :tags, through: :category_tags

def all_tags=(names)
  self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
  end
end

def all_tags
  self.tags.map(&:name).join(", ")
end

end

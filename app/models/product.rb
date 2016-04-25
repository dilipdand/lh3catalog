class Product < ActiveRecord::Base
has_many :product_tags
has_many :tags, through: :product_tags

has_many :product_categories
has_many :categories, through: :product_categories

has_attached_file :logo, :styles => { :small => "100x100>", :med => "200x200>", :large => "514x386>" }, :default_url => ":style/fallback-product-img.png"
validates_attachment :logo, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }, :size => { :in => 0..3.megabytes }

def all_tags=(names)
  self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
  end
end

def all_tags
  self.tags.map(&:name).join(", ")
end
def all_categories=(names)
  self.categories = names.split(",").map do |name|
      Category.where(name: name.strip).first_or_create!
  end
end

def all_categories
  self.categories.map(&:name).join(", ")
end
end

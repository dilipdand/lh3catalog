class Product < ActiveRecord::Base
has_many :product_tags
has_many :tags, through: :product_tags

has_many :product_categories
has_many :categories, through: :product_categories

has_attached_file :logo, :styles => { :small => "100x100>", :med => "200x200>", :large => "514x386>" }, :default_url => "/images/:style/fallback-product-img.png"
validates_attachment :logo, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }, :size => { :in => 0..3.megabytes }

scope :has_saas,  -> { where(saas: true)     }
scope :has_api,   -> { where(api: true)      }
scope :is_agency, -> { where(agency: true)   }
scope :is_free,   -> { where(freemium: true) }

def all_tags=(names)
  if (names != nil)
	  self.tags = names.split(",").map do |name|
		  Tag.where(name: name.strip).first_or_create!
	  end
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

def self.import(file)
	accessible_attributes = ["name","saas","agency","api","all_tags","all_categories","compensation","description","url","city","state","country","per_campaign_price","base_price","smb_price","ent_price","freemium"]
	CSV.foreach(file.path,  :headers => true ) do |row|
		product = self.new
		product.attributes = row.to_hash.select{ |k, v| accessible_attributes.include? k}
		product.save!
	end
end


end

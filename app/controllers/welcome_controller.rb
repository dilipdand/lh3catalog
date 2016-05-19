class WelcomeController < ApplicationController

def index
	@categories = Category.all
end

def tagsForCategory
	@category = Category.find(params[:id])
	@tagsForCategory = @category.tags
	respond_to do |format|
		format.js {}
	end
end

def productsForCategory
	@category = Category.find(params[:id])
	@productsForCategory = @category.products
	respond_to do |format|
		format.js {}
	end

end
private
def category_params
	params.require(:category).permit( :name, :description, :all_tags, :all_product)
end
end

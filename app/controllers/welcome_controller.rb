class WelcomeController < ApplicationController
protect_from_forgery except: :filter_products


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

def filter_products
	@productsForCategory = Array.new
	@filters = params[:filters]
	@category = params[:category]
	if (@category[:selected_category_ids].empty? || @category.nil?) then
		@selected_categories = Category.all 
	else
		@cat_ids = @category[:selected_category_ids].reject { |c| c.empty? || c == ""}
		logger.debug "Selected Categories = " + @cat_ids.inspect
		if (@cat_ids.empty?) then
			@selected_categories = Category.all
		else
			@selected_categories = Category.find(@cat_ids)
		end
	end
	@selected_categories.each do |category|	
	logger.debug "Category " + category.name 
		if (!@filters.nil?) then
			@filters.each do |filter|
				if (filter == "") then
					@productsForCategory = @productsForCategory + category.products
				elsif (filter =="saas") then 
					@productsForCategory = @productsForCategory + category.products.has_saas
				elsif (filter =="agency") then
					@productsForCategory = @productsForCategory + category.products.is_agency
				elsif (filter =="freemium") then
					@productsForCategory = @productsForCategory + category.products.is_free
				elsif (filter =="api") then
					@productsForCategory = @productsForCategory + category.products.has_api
				end
			end
		else 
			@productsForCategory = @productsForCategory + category.products
		end
	end

	respond_to do |format|
		format.js 
	end				
	
end
private
def category_params
	params.require(:category).permit( :name, :description, :all_tags, :all_product, :logo, )
end
end

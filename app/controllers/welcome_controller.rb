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
	@filters = params[:filters].reject {|f| f == ""}
	logger.debug "Selected Category " + @cat_id.to_s
	@cat_id = params[:categories_ids]
	if ( @cat_id.nil? || @cat_id.empty? || @cat_id == "All") then
		@selected_categories = Category.all 
	else
		@category = Category.find(@cat_id) 
		@selected_categories = [@category]
	end
	@selected_categories.each do |category|	
	logger.debug "Category " + category.name 
		if (@filters.nil? || @filters.empty?) then
			@productsForCategory = @productsForCategory + category.products
		else 
			@filters.each do |filter|
				logger.debug "Filter " + filter.to_s
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

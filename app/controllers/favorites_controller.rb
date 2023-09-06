class FavoritesController < ApplicationController
    def create
        product.favorite!
        respond_to do |format|
           format.html do
             redirect_to product_path(product), status: :see_other
           end 
           format.turbo_stream do 
            render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product})
           end
        end
    end
    
    def index
        
    end

    def destroy
        product.unfavorite!
        respond_to do |format|
            format.html do
              redirect_to product_path(product), status: :see_other
            end
             format.turbo_stream do
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product})
             end
         end
    end

    private

    def product
        # cachear el producto para ahorrarnos una query
        @product ||= Product.find(params[:product_id])
    end

end
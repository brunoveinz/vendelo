class ProductsController < ApplicationController
    skip_before_action :protect_pages, only: [:index, :show]
    # index devuelde un conjunto de cosas
    def index
        # @ estas son variables de instancia esto lo podemos leer en nuestra vista
        @categories = Category.all.order(name: :asc).load_async
        @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items:12)
    end

    def show 
        product
    end

    def new
        @product = Product.new 
    end

    def create 
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: t('.created')
        else
            render :new, status: :unprocessable_entity
        end
    end 

    def edit
        authorize! product
        product
    end

    def update
        authorize! product
        if  product.update(product_params)
            product.broadcast
            redirect_to products_path, notice: t('.updated')
        else
            render :edit, status: :unprocessable_entity            
        end
    end

    def destroy
        authorize! product # solo el dueño puedo hacer esto
        product.destroy
        redirect_to products_path, notice: t('.destroyed') , status: :see_other
    end

    def product 
        @product ||= Product.find(params[:id])
    end


    private 

    def product_params_index
        params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites, :user_id)
    end

    def product_params
         params.require(:product).permit(:title, :description, :price, :foto, :category_id)
    end
end
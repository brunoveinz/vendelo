require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
   def setup 
      login   
   end

    test 'render a list of products' do
       get products_path

       assert_response :success
       assert_select '.product', 12
       assert_select '.category', 9
    end
    
    test 'render a list of products filtered by category' do
      get products_path(category_id: categories(:computers).id)

      assert_response :success
      assert_select '.product', 5
   end

   test 'render a list of products filtered by min_price and max_price' do
      get products_path(min_price: 160, max_price: 200)

      assert_response :success
      assert_select '.product', 3
      assert_select 'h2', 'Nintendo Switch'
   end

   test 'render a list of products filtered by name' do
      get products_path(query_text: 'switch')

      assert_response :success
      assert_select '.product', 1
      assert_select 'h2', 'Nintendo Switch'
   end

   test 'sort products by expensives prices first ' do
      get products_path(order_by: 'expensives')

      assert_response :success
      assert_select '.product', 12
      assert_select '.products .product:first-child h2', 'Seat Panda clásico'
   end


   
   test 'sort products by cheapets prices first ' do
      get products_path(order_by: 'cheapest')

      assert_response :success
      assert_select '.product', 12
      assert_select '.products .product:first-child h2', 'El hobbit'
   end

    test 'render a detailed product page' do
       get product_path(products(:ps4))

       assert_response :success
       assert_select '.title', 'PS4 Fat'
       assert_select '.description', 'ps4 en buen estado'
       assert_select '.price', '120'
    end

    test 'render a new product form' do
      get new_product_path

      assert_response :success
      assert_select 'form'
    end

    test 'allow to create a new product' do
      post products_path, params: {
         product: {
            title: 'Nintendo 42',
            description: 'le faltan cables',
            price: 44,
            category_id: categories(:videogames).id
         }
      }

      assert_redirected_to products_path
      assert_equal flash[:notice], 'Tu producto se ha creado correctamente'
    end


    test 'does not allow to create a new product with empty fields' do
      post products_path, params: {
         product: {
            title: '',
            description: 'le faltan cables',
            price: 1
         }
      }

      assert_response :unprocessable_entity
    end


    test 'render an new edit product form' do
      get new_product_path(products(:ps4))

      assert_response :success
      assert_select 'form'
    end

    test 'allow to update a product' do
      patch product_path(products(:ps4)), params: {
         product: {
            price: 1111
         }
      }

      assert_redirected_to products_path
      assert_equal flash[:notice], 'Tu producto se ha actualizado correctamente'
    end

    test 'can delete products' do
      assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
      end
      
      assert_redirected_to products_path
      assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
    end
end
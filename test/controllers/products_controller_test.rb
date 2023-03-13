require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 3
    assert_select '.category', 3
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:computers).id)

    assert_response :success
    assert_select '.product', 1
  end

  test 'render a list of products filtered by min_price and max_price' do
    get products_path(min_price: 160, max_price: 200)

    assert_response :success
    assert_select '.product', 1
    assert_select 'h2', 'Nintendo Switch'
  end

  test 'search a product by query_text' do
    get products_path(query_text: 'Switch')

    assert_response :success
    assert_select '.product', 1
    assert_select 'h2', 'Nintendo Switch'
  end

  test 'sort products by expensive prices first' do
    get products_path(order_by: 'expensive')

    assert_response :success
    assert_select '.product', 3
    assert_select '.products .product:first-child h2', 'MacBook Pro 2018'
  end

  test 'sort products by cheapest prices first' do
    get products_path(order_by: 'cheapest')

    assert_response :success
    assert_select '.product', 3
    assert_select '.products .product:first-child h2', 'PS4 Fat'
  end



  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select '.title', 'PS4 Fat'
    assert_select '.description', 'PS4 en buen estado'
    assert_select '.price', '150'
  end

  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end

  test 'create a new product' do
    assert_difference 'Product.count', 1 do
      post products_path, params: { product: { title: 'PS5', description: 'PS5 en buen estado', price: 400, category_id: categories(:videogames).id } }
    end
    assert_redirected_to products_path
    assert_equal 'Tu producto se ha creado correctamente.', flash[:notice]
  end

  test 'render a new product form with errors' do
    post products_path, params: { product: { title: '', description: '', price: '' } }
    assert_response :unprocessable_entity
    assert_select 'form'
  end

  test 'render a edit product form' do
    get edit_product_path(products(:ps4))
    assert_response :success
    assert_select 'form'
  end

  test 'update a product' do
    patch product_path(products(:ps4)), params: { product: { title: 'PS4 Slim' } }
    assert_redirected_to products_path
    assert_equal 'Tu producto se ha actualizado correctamente.', flash[:notice]
    assert_equal 'PS4 Slim', products(:ps4).reload.title
  end

  test 'render a edit product form with errors' do
    patch product_path(products(:ps4)), params: { product: { title: '' } }
    assert_response :unprocessable_entity
    assert_select 'form'
  end

  test 'delete a product' do
    assert_difference 'Product.count', -1 do
      delete product_path(products(:ps4))
    end
    assert_redirected_to products_path
    assert_equal 'Tu producto se ha eliminado correctamente.', flash[:notice]
  end

end

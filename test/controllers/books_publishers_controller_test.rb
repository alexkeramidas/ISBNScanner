require 'test_helper'

class BooksPublishersControllerTest < ActionController::TestCase
  setup do
    @books_publisher = books_publishers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books_publishers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create books_publisher" do
    assert_difference('BooksPublisher.count') do
      post :create, books_publisher: { book_id: @books_publisher.book_id, publisher_id: @books_publisher.publisher_id }
    end

    assert_redirected_to books_publisher_path(assigns(:books_publisher))
  end

  test "should show books_publisher" do
    get :show, id: @books_publisher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @books_publisher
    assert_response :success
  end

  test "should update books_publisher" do
    patch :update, id: @books_publisher, books_publisher: { book_id: @books_publisher.book_id, publisher_id: @books_publisher.publisher_id }
    assert_redirected_to books_publisher_path(assigns(:books_publisher))
  end

  test "should destroy books_publisher" do
    assert_difference('BooksPublisher.count', -1) do
      delete :destroy, id: @books_publisher
    end

    assert_redirected_to books_publishers_path
  end
end

require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test "/wide_open is accessible to anyone" do
    visit "/wide_open"

    assert_equal "Welcome everyone!", page.body
  end

  test "/users calls login_required for unregistered users" do
    ProtectedController.any_instance.expects(:current_user).returns(nil)
    visit "/users"
    assert_equal "You must login to view this page!", page.body
  end

  test "/users calls lockdown for users with the wrong role" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:admin))
    visit "/users"
    assert_equal "admins not allowed! Only users are!", page.body
  end

  test "/users renders its body for users with user right" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:user))
    visit "/users"
    assert_equal "Welcome user!", page.body
  end

  test "/admins calls login_required for unregistered users" do
    ProtectedController.any_instance.expects(:current_user).returns(nil)
    visit "/admins"
    assert_equal "You must login to view this page!", page.body
  end

  test "/admins calls lockdown for users with the wrong role" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:user))
    visit "/admins"
    assert_equal "users not allowed! Only admins are!", page.body
  end

  
  test "/admins renders its body for users with admin right" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:admin))
    visit "/admins"
    assert_equal "Welcome admin!", page.body
  end

  test "/users_and_admins calls login_required for unregistered users" do
    ProtectedController.any_instance.expects(:current_user).returns(nil)
    visit "/users_and_admins"
    assert_equal "You must login to view this page!", page.body
  end

  test "/users_and_admins calls lockdown for users with the wrong role" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:guest))
    visit "/users_and_admins"
    assert_equal "guests not allowed! Only admins and users are!", page.body
  end

  test "/users_and_admins renders its body for users with user right" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:user))
    visit "/users_and_admins"
    assert_equal "Welcome users and admins!", page.body
  end
  
  test "/users_and_admins renders its body for users with admin right" do
    ProtectedController.any_instance.expects(:current_user).returns(User.new(:admin))
    visit "/users_and_admins"
    assert_equal "Welcome users and admins!", page.body
  end
end

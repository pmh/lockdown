require 'test_helper'

class ViewHelper ; include Lockdown::ViewExtensions ; end

class ViewExtensionsTest < ActiveSupport::TestCase

  def setup
    @view_helper = ViewHelper.new
  end
  
  test "it doesn't execute the passed in block for non-registred users" do
    @view_helper.expects(:current_user).twice.returns(nil)
    assert_equal nil, @view_helper.visible_to(:admin, :user) { "foo" }
  end

  test "it doesn't execute the passed in block for users with the wrong role" do
    @view_helper.expects(:current_user).twice.returns(User.new(:foobaz))
    assert_equal nil, @view_helper.visible_to(:admin, :user) { "foo" }
  end

  test "it executes the passed in block for users with the right role" do
    @view_helper.expects(:current_user).twice.returns(User.new(:admin))
    assert_equal "foo", @view_helper.visible_to(:admin, :user) { "foo" }
  end
end

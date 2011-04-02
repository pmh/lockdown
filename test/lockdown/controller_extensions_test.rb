require 'test_helper'

class User
  include Lockdown::ModelExtensions
  roles :admin, :user
  
  attr_accessor :role_type

  def initialize(role_type)
    self.role_type = role_type
  end
end

class Controller
  include Lockdown::ControllerExtensions

  def login_required ; "login required" ; end 
      
  def lockdown(role_type, *roles)
    "lockdown: #{role_type} -- #{roles.join(", ")}"
  end
end

class ControllerExtensionsTest < ActiveSupport::TestCase

  test "the controller responds to ensure_role" do
    assert Controller.respond_to?(:ensure_role)
  end

  test "ensure_role delegates to before_filter" do
    Controller.expects(:before_filter).times(2)
    Controller.expects(:before_filter).with(:only   => [:index])
    Controller.expects(:before_filter).with(:except => [:index])
    
    Controller.ensure_role :admin
    Controller.ensure_role :admin, :user
    Controller.ensure_role :admin, :user, :only   => [:index]
    Controller.ensure_role :admin, :user, :except => [:index]
  end

  test "auhtorize! calls login_required when there is no user" do
    controller = Controller.new

    assert_equal "login required", controller._authorize!(nil, :admin, :user)
  end

  test "auhtorize! calls lockdown when there is a user with invalid role" do
    controller = Controller.new
    user       = User.new(:foobaz)
    
    assert_equal "lockdown: foobaz -- admin, user",
                 controller._authorize!(user, :admin, :user)
  end

  
  test "auhtorize! returns nil when there is a user with a valid role" do
    controller = Controller.new
    user       = User.new(:admin)
    
    assert_equal nil, controller._authorize!(user, :admin, :user)
  end
end

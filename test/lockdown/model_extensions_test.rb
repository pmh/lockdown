require 'test_helper'

class ModelExtensionsTest < ActiveSupport::TestCase
  def setup
    @ModelClass = Class.new do
      include Lockdown::ModelExtensions

      attr_accessor :role_type
    end
  end
  
  test "it adds a roles class method" do
    assert @ModelClass.respond_to?(:roles)
  end

  test "roles generates a predicate method for each of it's arguments" do
    @ModelClass.roles :admin, :user, :guest
    @model = @ModelClass.new

    assert @model.respond_to?( :admin? )
    assert @model.respond_to?( :user?  )
    assert @model.respond_to?( :guest? )
  end

  
  test "roles accepts strings as well as symbols" do
    @ModelClass.roles "admin", "user", "guest"
    @model = @ModelClass.new

    assert @model.respond_to?( :admin? )
    assert @model.respond_to?( :user?  )
    assert @model.respond_to?( :guest? )
  end

  
  test "the predicate methods returns true or false based on the models role method" do
    @ModelClass.roles :admin, :user, :guest
    @model = @ModelClass.new

    @model.role_type = :admin

    assert_equal true,  @model.admin?
    assert_equal false, @model.user?
    assert_equal false, @model.guest?

    @model.role_type = :user

    assert_equal false, @model.admin?
    assert_equal true,  @model.user?
    assert_equal false, @model.guest?
  end
  
  test "in_role?" do
    @ModelClass.roles :admin, :user, :guest
    @model = @ModelClass.new
    
    @model.role_type = :admin
    assert_equal true, @model.in_role?(:admin, :user)

    @model.role_type = :user
    assert_equal true, @model.in_role?(:admin, :user)

    @model.role_type = :foobaz
    assert_equal false, @model.in_role?(:admin, :user)
  end
  
  def teardown
    @ModelClass = nil
  end
end

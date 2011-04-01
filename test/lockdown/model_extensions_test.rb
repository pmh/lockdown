require 'test_helper'

class ModelExtensionsTest < ActiveSupport::TestCase
  def setup
    @ModelClass = Class.new do
      include Lockdown::ModelExtensions

      attr_accessor :role
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

    @model.role = :admin

    assert_equal @model.admin?, true
    assert_equal @model.user?,  false
    assert_equal @model.guest?, false

    @model.role = :user

    assert_equal @model.admin?, false
    assert_equal @model.user?,  true
    assert_equal @model.guest?, false
  end
  
  def teardown
    @ModelClass = nil
  end
end

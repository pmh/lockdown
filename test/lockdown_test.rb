require 'test_helper'

class LockdownTest < ActiveSupport::TestCase
  test "it defines model extensions" do
    assert_kind_of Module, Lockdown::ModelExtensions
  end

  test "it defines controller extensions" do
    assert_kind_of Module, Lockdown::ControllerExtensions
  end
end

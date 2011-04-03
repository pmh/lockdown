class FakeUser
  include Lockdown::ModelExtensions
  roles :admin, :user
  
  attr_reader :role_type
  
  def initialize(role_type)
    @role_type = role_type
  end
end

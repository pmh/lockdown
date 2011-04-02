class User
  include Lockdown::ModelExtensions

  roles :admin, :user, :guest
  
  attr_accessor :role_type

  def initialize(role_type = nil)
    self.role_type = role_type
  end
end

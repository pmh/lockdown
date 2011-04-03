class User < ActiveRecord::Base
  roles :admin, :user, :guest
  
  attr_accessor :role_type

  def initialize(role_type = nil)
    self.role_type = role_type
  end
end

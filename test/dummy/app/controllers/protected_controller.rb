class ProtectedController < ApplicationController
  include Lockdown::ControllerExtensions

  ensure_role :admin,        :only => [ :admins           ]
  ensure_role :user,         :only => [ :users            ]
  ensure_role :admin, :user, :only => [ :users_and_admins ]

  def wide_open
    render :text => "Welcome everyone!"
  end

  def users
    render :text => "Welcome user!"
  end

  def admins
    render :text => "Welcome admin!"
  end
  
  def users_and_admins
    render :text => "Welcome users and admins!"
  end
end

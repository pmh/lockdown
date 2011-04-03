class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_required
    render :text => "You must login to view this page!"
  end

  def lockdown(role, *roles)
    render :text => "#{role.pluralize} not allowed! Only #{roles.map(&:pluralize).join(" and ")} are!"
  end
end

module ApplicationHelper
  def current_user
    User.new(:admin)
  end
end

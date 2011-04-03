$:.unshift File.join(File.dirname(__FILE__), "lockdown")

require "model_extensions"
require "controller_extensions"
require "view_extensions"

ActiveRecord::Base.send     :include, Lockdown::ModelExtensions
ActionController::Base.send :include, Lockdown::ControllerExtensions
ActionView::Base.send       :include, Lockdown::ViewExtensions

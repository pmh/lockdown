module Lockdown
  module ControllerExtensions
    def self.included(controller)
      controller.extend ClassMethods
    end

    def _authorize!(user, *roles)
      if user
        role_type = user.role_type.to_s
        lockdown(role_type, *roles) unless user.in_role?(*roles)
      else
        login_required
      end
    end

    module ClassMethods
      def ensure_role(*args)
        actions, roles = args.extract_options!, args.map(&:to_s)
        before_filter(actions) { |c| c._authorize! current_user, *roles }
      end
    end
  end
end

module Lockdown
  module ViewExtensions
    def visible_to(*roles)
      if current_user && current_user.in_role?(*roles)
        yield
      end
    end
  end
end

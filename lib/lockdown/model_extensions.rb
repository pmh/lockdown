module Lockdown
  module ModelExtensions
    def self.included(klass)
      klass.extend ClassMethods
    end
    
    module ClassMethods
      def roles(*roles)
        roles.each do |role_type|
          define_method "#{role_type}?" do
            role.to_s == role_type.to_s
          end
        end
      end
    end
  end
end

module Lockdown
  module ModelExtensions
    def self.included(klass)
      klass.extend ClassMethods
    end
    
    def in_role?(*roles)
      roles.any? { |role_type| self.send("#{role_type}?") }
    end
    
    module ClassMethods
      def roles(*roles)
        roles.each do |role|
          define_method "#{role}?" do
            role_type.to_s == role.to_s
          end
        end
      end
    end
  end
end

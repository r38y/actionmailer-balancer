require "rubygems"
require "action_mailer"

module ActionMailer
  class Base
    @@smtp_users = []
    cattr_accessor :smtp_users
        
    def self.new(method_name=nil, *parameters)
      if smtp_users.size > 0
        smtp_user = smtp_users[rand(smtp_users.size)]        
        smtp_settings[:user_name] = smtp_user[:user_name]
        smtp_settings[:password] = smtp_user[:password]
      end
      super(method_name, *parameters)
    end
  end
end
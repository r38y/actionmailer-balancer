require "rubygems"
require 'test/unit'
require "actionpack"
require "actionmailer"
require "init"

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain
}

ActionMailer::Base.smtp_users = [
  { 
    :user_name => "no-reply1@test.com",
    :password => "password"
  }
]

class Emailer < ActionMailer::Base
  def self.template_root
    {}
  end
  def email(h)
    recipients h[:recipients]
    subject    h[:subject]
    from       h[:from]
    part :content_type => "text/plain", :body => h[:body]
  end
end

class BalancerTest < Test::Unit::TestCase
  def test_send_mail
    Emailer.create_email(
      {:recipients => 'somebody@test.com',
      :subject => "Balancer test",
      :from => 'no-reply@test.com',
      :body => "This email was sent at #{Time.now.inspect}"}
    )
    assert_equal 'no-reply1@test.com', ActionMailer::Base.smtp_settings[:user_name]
    assert_equal 'password', ActionMailer::Base.smtp_settings[:password]
  end
end

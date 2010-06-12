# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# Turn on caching so that you can test it
# config.action_controller.perform_caching = true

IMAP_SERVER = {
  :host => '',
  :port => 993,
  :use_ssl => true,
  :username => '',
  :password => ''
}.freeze

# First, specify the Host that we will be using later for user_notifier.rb
HOST = 'http://enotify.zorched.net'
# Third, add your SMTP settings
ActionMailer::Base.smtp_settings = {
  :address => "",
  :port => 25,
  :domain => "",
  :user_name => "",
  :password => "",
  :authentication => :login
}
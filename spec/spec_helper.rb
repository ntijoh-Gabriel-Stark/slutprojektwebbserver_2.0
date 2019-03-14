# Configuration for acceptance tests

# Set the environment to 'test' to use correct settings in config/environment
ENV['RACK_ENV'] = 'test'

# Use bundler to load gems
require 'bundler'

# Load gems from Gemfile
Bundler.require

# Load the environment
require_relative '../models/database_object'
require_relative '../models/groups'
require_relative '../models/user_group'
require_relative '../models/users'
require_relative '../models/subject'
require_relative '../models/teacher_subject'
require_relative '../models/grading'
require_relative '../app'
require 'capybara/rspec'

Capybara.app = App
Capybara.server = :webrick
#Capybara.app_host = 'http://localhost:'

Capybara.default_driver = :selenium_chrome #:selenium_chrome_headless are also registered

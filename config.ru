#used by rackup

#Use bundler to select gems
require 'bundler'

# load all gems in Gemfile
Bundler.require

require_relative 'models/database_object'
require_relative 'models/groups'
require_relative 'models/user_group'
require_relative 'models/users'
require_relative 'models/subject'
require_relative 'models/teacher_subject'
require_relative 'models/grading'
require_relative 'app'

run App
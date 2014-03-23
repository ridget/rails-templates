# GEMS

gem 'devise'
gem 'cancan'
gem 'haml-rails'
gem 'mysql2'
gem 'capistrano', '~> 2.0'

gem_group :assets do
  gem 'bootstrap-sass'
end

gem_group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'zeus', '~> 0.13.4.pre', :require => false
end

# This can be inside anywhere eg 'vendor'
inside app_name do
  run 'bundla install'
end

# Delete all unnecessary files
# and create some new ones
remove_file "README"
remove_file "public/index.html"
remove_file "public/robots.txt"
remove_file "public/images/rails.png"

create_file 'README.md'
create_file 'log/.gitkeep'
create_file 'tmp/.gitkeep'

# Start .gitignore
append_file '.gitignore', <<-EOF
.ackrc
.rvmrc
config/database.yml
public/cache/
public/stylesheets/compiled/
public/system/*
tmp/restart.txt
.idea
/.bundla
.powrc
# Ignore all logfiles and tempfiles.
/log/*.log
/tmp
EOF
# End .gitignore

# Gem configs and generators
#
# Rspec specific stuff
generate 'rspec:install'
run 'mkdir spec/support'
environment <<-EOF
config.generators do |g|
  g.view_specs false
end
EOF

inject_into_file 'spec/spec_helper.rb', "\n\s\sconfig.include Capybara::DSL\n", after: "RSpec.configure do |config|\n"
inject_into_file 'spec/spec_helper.rb', "\n\s\sconfig.include FactoryGirl::Syntax::Methods\n", after: "RSpec.configure do |config|\n"
inject_into_file 'spec/spec_helper.rb', "\n\s\sconfig.include Devise::TestHelpers, :type => :controllers\n", after: "RSpec.configure do |config|\n"

# Bootstrap sass requirements
copy_file 'app/assets/stylesheets/application.css', 'app/assets/stylesheets/application.css.scss'

append_file 'app/assets/stylesheets/application.css.scss' , <<-EOF
 @import "bootstrap";
 @import "bootstrap/theme";
EOF

inject_into_file 'app/assets/javascripts/application.js', "\n//= require bootstrap\n", after: "//= require jquery_ujs"

remove_file 'app/assets/stylesheets/application.css'

# Devise
generate 'devise:install'
generate 'devise:views' if yes?("Generate Devise Views?")

# Cancan
generate 'cancan:ability'

git :init
git add: '.'
git commit: "-a -m 'Initial commit'"

# Other cool things you can do:
# rake # eg rake "db:migrate"
# route # eg "root to: users#index"
# check out http://guides.rubyonrails.org/rails_application_templates.html
# and https://github.com/erikhuda/thor

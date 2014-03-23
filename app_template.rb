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

inside app_name do
  run 'bundle install'
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
  /.bundle
  .powrc
  # Ignore all logfiles and tempfiles.
  /log/*.log
  /tmp
EOF
# End .gitignore

load 'deploy/assets'

require 'bundler/capistrano'
require 'rvm/capistrano'

default_run_options[:pty] = true

set :application, "kittenbomb"
set :repository,  "git@github.com:squil/kittenbomb.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/home/#{application}/apps/#{application}"
set :user, application
set :use_sudo, false

set :ssh_options, { :forward_agent => true }

server "178.79.166.22", :app, :web, :db, :primary => true

set :rvm_ruby_string, '2.0.0'
set :rvm_type, :system

after 'deploy:setup', 'deploy:set_rvm_version'
after 'deploy:finalize_update', 'symlink_config'
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :stop, :roles => :app do
    run "sudo stop #{application} || exit 0"
  end

  task :start, :roles => :app do
    run "sudo start #{application}"
  end

  task :restart, :roles => :app do
    stop
    start
  end
end

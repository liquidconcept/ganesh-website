# encoding: utf-8
set :application, 'website'
set :domain,      'institutganesh.ch'
set :server_name, 'ruby-rack-2.liquid-concept.ch'

set :scm,         :git
set :repository,  'git@github.com:liquidconcept/ganesh-website.git'
set :branch,      'production'

ssh_options[:forward_agent] = true

default_run_options[:pty] = true
default_environment['LC_CTYPE'] = 'en_US.UTF-8'

set :user,        'webpublisher'
set :deploy_via,  :remote_cache
set :deploy_to,   "/var/www/#{domain}/#{application}"
set :use_sudo,    false

role :web, server_name                          # Your HTTP server, Apache/etc
role :app, server_name                          # This may be the same as your `Web` server
role :db,  server_name, :primary => true        # This is where Rails migrations will run

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before 'deploy:create_symlink' do
  run "cd #{release_path} && RACK_ENV=\"production\" bundle exec nanoc compile > /dev/null"
end

after 'deploy:update', 'deploy:restart'
after 'deploy:update', 'deploy:cleanup'

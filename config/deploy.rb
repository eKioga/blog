
lock "3.9.0"

set :application, "blog"
set :repo_url, "git@example.com:eKioga/blog.git"

set :rbenv_path, '/home/deploy/.rbenv/'

set :deploy_to, '/home/deploy/blog'

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{}

namespace :deploy do

  desc 'Upload .env'
  task :upload_env do
    on roles(:app) do |host|
      upload! #{dir.pwd}/.env.#{fetch(rails_env)} , #{shared_path}/.env
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "ln -nfs #{shared_path}/config/.env #{current_path}/.env"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
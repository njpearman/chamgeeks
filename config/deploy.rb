# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, "my_app_name"
set :repo_url, "git@example.com:me/my_repo.git"

set :application, "chamgeeks"
set :repo_url, "git@github.com:njpearman/chamgeeks.git"

set :puma_threads,    [4, 16]
set :puma_workers,    0

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/rails/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord


set :linked_files, %w(.env config/database.yml)
set :linked_dirs, %w(log uploads)

namespace :assets do
  desc 'Run the precompile task locally and rsync with shared'
  task :precompile do
    
    run_locally do
			with rails_env: :production do
				execute 'rm', '-rf public/assets/*'
				rake 'assets:precompile'
				execute 'touch', 'assets.tgz'
				execute 'rm', 'assets.tgz'
				execute 'tar', 'zcvf assets.tgz public/assets/'
				execute 'mv', 'assets.tgz public/assets/'
			end
    end
  end

  desc 'Upload precompiled assets'
  task :upload_assets do
    on roles(:app) do
      upload! "public/assets/assets.tgz", "#{release_path}/assets.tgz"
      within release_path do
        execute 'tar', 'zxvf assets.tgz'
        execute  'rm', 'assets.tgz'
      end
    end
  end
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

before 'deploy:migrate', 'assets:precompile'
before 'deploy:published', 'assets:upload_assets'

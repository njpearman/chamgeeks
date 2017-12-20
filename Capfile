require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require "capistrano/rbenv"
require "capistrano/bundler"
require "capistrano/rails"
require "capistrano/puma"

install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Workers  # if you want to control the workers (in cluster mode)

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }


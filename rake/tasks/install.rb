# frozen_string_literal: true

# install ------------------------------------------------------------

desc 'Install theme'
task :install, [:path] => [:caches, :uninstall] do |_, args|
  Setup.new(args[:path]).call(:install)
end

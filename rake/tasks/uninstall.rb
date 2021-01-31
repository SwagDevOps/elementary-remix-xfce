# frozen_string_literal: true

# uninstall ----------------------------------------------------------

desc 'Uninstall theme'
task :uninstall, [:path] do |_, args|
  Setup.new(args[:path]).call(:uninstall)
end

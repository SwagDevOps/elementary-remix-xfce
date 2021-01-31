# frozen_string_literal: true

# install ------------------------------------------------------------

ENV['icons_path'].tap do |icons_path|
  desc 'Install theme'
  task(:install => [:caches, :uninstall]) { Setup.new(icons_path).call(:install) }
end

# frozen_string_literal: true

# uninstall ----------------------------------------------------------

ENV['icons_path'].tap do |icons_path|
  desc 'Uninstall theme'
  task(:uninstall) { Setup.new(icons_path).call(:uninstall) }
end

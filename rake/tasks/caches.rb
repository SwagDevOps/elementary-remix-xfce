# frozen_string_literal: true

# caches ------------------------------------------------------------
task :caches do
  Setup.new.call(:caches)
end

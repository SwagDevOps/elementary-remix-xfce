# frozen_string_literal: true

require 'rake/clean'

%w[lib tasks].each do |dir|
  Dir.glob("#{__dir__}/rake/#{dir}/*.rb").sort.each { |fp| require fp }
end

# default ------------------------------------------------------------
task default: [:caches]

# clobber ------------------------------------------------------------
CLOBBER << FileList['./*/icon-theme.cache']


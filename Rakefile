# frozen_string_literal: true

require 'pp'
require 'open3'
require 'pathname'

default_path = '/usr/local/share/icons'
theme        = 'elementary-remix-xfce'
installables = {
  'apps/' => nil,
  'devices/' => nil,
  'index.theme' => nil,
  'panel/' => nil,
  'places/' => nil,
}

# install ------------------------------------------------------------

desc 'Install theme'
task :install, [:path] => [:uninstall] do |task, args|
  path = Pathname.new(args[:path] || default_path)
  installables
    .keys
    .each { |k| installables[k] = Pathname.new(path).join(theme, k) }

  mkdir_p(Pathname.new(path).join(theme))
  installables.sort.to_h.each { |k, v| cp_r(k, v) }

  Rake::Task['install:cache'].execute(path: path)
end

task :'install:cache', [:path] do |task, args|
  path = Pathname.new(args[:path] || default_path)
  tdir = Pathname.new(path).join(theme)

  nbin = 'gtk-update-icon-cache'
  xupd = Open3.capture3('which', nbin)[0].lines.map(&:chomp)[0]

  (sh(xupd, tdir.to_s) if xupd) unless Dir.glob("#{tdir}/*").empty?
end

# uninstall ----------------------------------------------------------

desc 'Uninstall theme'
task :uninstall, [:path] do |task, args|
  path = Pathname.new(args[:path] || default_path)

  rm_r(Pathname.new(path).join(theme), force: true)
end

task default: [:install]

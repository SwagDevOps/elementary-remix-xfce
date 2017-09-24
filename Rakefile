# frozen_string_literal: true

require 'pp'
require 'open3'
require 'pathname'

default_path = '/usr/local/share/icons'
themes       = ['elementary-remix-xfce']
installables = {
  'elementary-remix-xfce/apps/' => nil,
  'elementary-remix-xfce/devices/' => nil,
  'elementary-remix-xfce/index.theme' => nil,
  'elementary-remix-xfce/panel/' => nil,
  'elementary-remix-xfce/places/' => nil,
}

# install ------------------------------------------------------------

desc 'Install theme'
task :install, [:path] => [:uninstall] do |task, args|
  path = Pathname.new(args[:path] || default_path)
  installables
    .keys
    .each { |k| installables[k] = Pathname.new(path).join(k) }

  themes.each { |theme| mkdir_p(Pathname.new(path).join(theme)) }
  installables.sort.to_h.each { |k, v| cp_r(k, v) }

  Rake::Task['install:cache'].execute(path: path)
end

task :'install:cache', [:path] do |task, args|
  path = Pathname.new(args[:path] || default_path)
  nbin = 'gtk-update-icon-cache'
  xupd = Open3.capture3('which', nbin)[0].lines.map(&:chomp)[0]

  themes.each do |theme|
    tdir = Pathname.new(path).join(theme)

    (sh(xupd, tdir.to_s) if xupd) unless Dir.glob("#{tdir}/*").empty?
  end
end

# uninstall ----------------------------------------------------------

desc 'Uninstall theme'
task :uninstall, [:path] do |task, args|
  path = Pathname.new(args[:path] || default_path)

  themes.each do |theme|
    rm_r(Pathname.new(path).join(theme), force: true)
  end
end

task default: [:install]

# frozen_string_literal: true

require 'pp'
require 'open3'
require 'pathname'
require 'yaml'

# setup --------------------------------------------------------------

class Setup
  def initialize(path = nil)
    override  = Pathname.new('manifest.override.yml')
    @manifest = YAML.load_file('manifest.yml')
    @manifest.merge!(YAML.load_file(override)) if override.file?

    @path     = path
  end

  def to_h
    @manifest.clone.to_h
  end

  def icons_path
    to_h.fetch('icons_path')
  end

  def path
    Pathname.new(@path || icons_path)
  end

  def themes
    to_h.fetch('themes')
  end

  def directories
    themes.map { |d| path.join(d) }
  end

  def installables
    items = to_h.fetch('installables')

    Hash[items.map { |x| [x, Pathname.new(path).join(x)] }]
  end
end

# install ------------------------------------------------------------

desc 'Install theme'
task :install, [:path] => [:uninstall] do |task, args|
  setup = Setup.new(args[:path])

  setup.directories.each { |d| mkdir_p(d) }
  setup.installables.each { |k, v| cp_r(k, v) }

  Rake::Task['install:cache'].execute(path: setup.path)
end

task :'install:cache', [:path] do |task, args|
  setup = Setup.new(args[:path])
  nbin  = 'gtk-update-icon-cache'
  xupd  = Open3.capture3('which', nbin)[0].lines.map(&:chomp)[0]

  if xupd
    setup.themes.each do |theme|
      tdir = Pathname.new(setup.path).join(theme)

      sh(xupd, tdir.to_s) unless Dir.glob("#{tdir}/*").empty?
    end
  end
end

# uninstall ----------------------------------------------------------

desc 'Uninstall theme'
task :uninstall, [:path] do |task, args|
  Setup.new(args[:path]).directories.each { |d| rm_r(d, force: true) }
end

task default: [:install]

# frozen_string_literal: true

require 'pp'
require 'open3'
require 'pathname'
require 'yaml'

# install ------------------------------------------------------------

desc 'Install theme'
task :install, [:path] => [:uninstall] do |task, args|
  setup = Setup.new(args[:path])

  setup.directories.each { |d| mkdir_p(d) }
  setup.installables.each { |k, v| cp_r(k, v) }

  Rake::Task['install:cache'].execute(path: setup.path)
end

task :'install:cache', [:path] do |task, args|
  nbin = 'gtk-update-icon-cache'
  xupd = Open3.capture3('which', nbin)[0].lines.map(&:chomp)[0]

  if xupd
    Setup.new(args[:path]).directories.each do |d|
      sh(xupd, d.to_s) unless Dir.glob("#{d}/*").empty?
    end
  end
end

# uninstall ----------------------------------------------------------

desc 'Uninstall theme'
task :uninstall, [:path] do |task, args|
  Setup.new(args[:path]).directories.each { |d| rm_r(d, force: true) }
end

# default ------------------------------------------------------------

task default: [:install]

# setup --------------------------------------------------------------

class Setup
  def initialize(path = nil)
    @conf = load_manifest
    @path = path
  end

  def icons_path
    conf.fetch('icons_path')
  end

  def path
    Pathname.new(@path || icons_path)
  end

  def themes
    conf.fetch('themes')
  end

  # Directories (for themes)
  #
  # @return [Array<Pathname>]
  def directories
    themes.map { |d| path.join(d) }
  end

  def installables
    items = conf.fetch('installables')

    Hash[items.map { |x| [x, Pathname.new(path).join(x)] }]
  end

  protected

  attr_reader :conf

  # @return [Hash]
  def load_manifest
    override = Pathname.new('manifest.override.yml')
    manifest = YAML.load_file('manifest.yml')
    manifest.merge!(YAML.load_file(override)) if override.file?

    manifest
  end
end

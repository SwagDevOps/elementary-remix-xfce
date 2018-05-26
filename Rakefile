# frozen_string_literal: true

require 'pp'
require 'open3'
require 'pathname'
require 'yaml'
require 'rake/clean'

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
    conf.fetch('themes').keys
  end

  # Directories (for themes)
  #
  # @return [Array<Pathname>]
  def directories
    themes.map { |d| path.join(d) }
  end

  # Installables (as from => dest)
  #
  # @return [Hash]
  def installables
    items = {}
    conf.fetch('themes').each do |k, v|
      v.each do |item|
        items[Pathname.new(k).join(item)] = path.join(k, item)
      end
    end

    items
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

module FileUtils
  # @param [String|Pathname|Object] path
  #
  # @see http://manpages.ubuntu.com/manpages/bionic/man8/update-icon-caches.8.html
  # @see https://github.com/ruby/rake/blob/c963dc0e96b4454665fa5be2ead04181426fd220/lib/rake/file_utils.rb#L43
  # @see http://manpages.ubuntu.com/manpages/bionic/man8/update-icon-caches.8.html
  def update_icon_cache(path, &block)
    cmd = ['gtk-update-icon-cache', '--force', '--quiet', path.to_s]

    sh(*cmd, &block)
  end
end

# default ------------------------------------------------------------

task default: [:caches]

# clobber ------------------------------------------------------------

CLOBBER << FileList['./*/icon-theme.cache']

# cache --------------------------------------------------------------

task :caches do
  fstt = File.stat(Dir.pwd)
  Setup.new.themes.each do |theme|
    update_icon_cache(theme)
    chown(fstt.uid, fstt.gid, "#{theme}/icon-theme.cache")
  end
end

# install ------------------------------------------------------------

desc 'Install theme'
task :install, [:path] => [:uninstall] do |task, args|
  setup = Setup.new(args[:path])

  setup.installables.keys.map { |v| v.realpath } # Errno::ENOENT
  setup.directories.each { |d| mkdir_p(d) }
  setup.installables.each { |k, v| cp_r(k, v) }
  setup.directories.each { |d| update_icon_cache(d) }
end

# uninstall ----------------------------------------------------------

desc 'Uninstall theme'
task :uninstall, [:path] do |task, args|
  Setup.new(args[:path]).directories.each { |d| rm_rf(d) }
end

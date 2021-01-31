# frozen_string_literal: true

# Describe setup
class Setup
  autoload(:Pathname, 'pathname')
  autoload(:YAML, 'yaml')
  autoload(:FileUtils, 'fileutils')

  # @return [Pathname]
  attr_reader :basedir

  # @return [Pathname]
  attr_reader :path

  # @return [Hash{String => Object}]
  attr_reader :config

  # @param path [String, Pathname, nil]
  # @param basedir [String]
  def initialize(path = nil, basedir: nil, fs: FileUtils::Verbose)
    self.tap do
      @basedir = Pathname.new(basedir || Dir.pwd).realpath.freeze
      @fs = fs

      @config = load_manifest.transform_values(&:freeze).freeze
      @path = Pathname.new(path || icons_path).expand_path.freeze
    end.freeze
  end

  # @return [Pathname]
  def icons_path
    config.fetch('icons_path').yield_self { |s| Pathname.new(s) }
  end

  # @return [Array<String>]
  def themes
    config.fetch('themes').keys
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
    {}.tap do |items|
      config.fetch('themes').each do |k, v|
        v.each do |item|
          items[basedir.join(k, item)] = path.join(k, item)
        end
      end
    end
  end

  # Call task.
  #
  # @param task_name [String, Symbol]
  def call(task_name, *args, **kwargs, &block)
    tasks.fetch(task_name.to_sym).call(*args, **kwargs, &block)
  end

  protected

  # @return [Module<FileUtils>]
  attr_reader :fs

  # @return [Hash]
  def load_manifest
    YAML.load_file(basedir.join('manifest.yml')).tap do |manifest|
      basedir.join('manifest.override.yml').tap do |override|
        manifest.merge!(YAML.load_file(override)) if override.file?
      end
    end
  end

  # @return [Hash{Symbol => Proc}]
  def tasks
    {
      install: lambda do
        installables.keys.map { |v| v.realpath } # Errno::ENOENT
        directories.each { |d| fs.mkdir_p(d) }
        installables.each { |k, v| fs.cp_r(k, v) }
      end,
      uninstall: lambda do
        directories.each { |d| fs.rm_rf(d) }
      end,
      caches: lambda do
        File.stat(basedir).tap do |fstt|
          themes.map { |theme| basedir.join(theme, 'icon-theme.cache') }.each do |fp|
            fs.update_icon_cache(fp.dirname)
            fs.chown(fstt.uid, fstt.gid, fp)
          end
        end
      end,
    }
  end
end

# frozen_string_literal: true

require 'rake/file_utils'

# @see https://rubydoc.info/gems/rake/FileUtils
module FileUtils
  # @param path [String|Pathname|Object]
  #
  # @see http://manpages.ubuntu.com/manpages/bionic/man8/update-icon-caches.8.html
  # @see https://github.com/ruby/rake/blob/c963dc0e96b4454665fa5be2ead04181426fd220/lib/rake/file_utils.rb#L43
  # @see http://manpages.ubuntu.com/manpages/bionic/man8/update-icon-caches.8.html
  def update_icon_cache(path, &block)
    ['gtk-update-icon-cache', '--force', '--quiet', path.to_s].yield_self do |cmd|
      sh(*cmd, &block)
    end
  end
end

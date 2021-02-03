# frozen_string_literal: true

require 'rake/clean'

module Rake::Cleaner
  autoload(:Pathname, 'pathname')

  module_function

  # @see https://github.com/ruby/rake/blob/c2eeae2fe2b67170472a1441ebf84d3a238c3361/lib/rake/clean.rb#L31
  #
  # @param file_name [Array<string>]
  # @return [Array<String>]
  def cleanup(file_name, **opts)
    (file_name.is_a?(Array) ? file_name : [file_name])
      .sort
      .map { |s| Pathname.new(s) }
      .map { |fp| self.__send__(fp.directory? ? :rm_r : :rm, fp, **{ verbose: true }.merge(opts)) }
      .flatten
  end
end

require 'language_sniffer/blob_helper'
require 'language_sniffer/file_blob'
require 'language_sniffer/language'
require 'language_sniffer/pathname'

module LanguageSniffer
  def self.detect(options)
    raise "I need :path" if not options[:path]
    FileBlob.new(options[:path], options[:pwd], options[:content])
  end
end

require 'language_sniffer/blob_helper'
require 'language_sniffer/file_blob'
require 'language_sniffer/language'
require 'language_sniffer/pathname'

module LanguageSniffer
  def self.detect(path, options={})
    FileBlob.new(path, options[:pwd], options[:content])
  end
end

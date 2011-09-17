require 'language_sniffer/blob_helper'

module LanguageSniffer
  # A FileBlob is a wrapper around a File object to make it quack
  # like a Grit::Blob. It provides the basic interface: `name`,
  # `data`, and `size`.
  class FileBlob
    include BlobHelper

    # Public: Initialize a new FileBlob from a path
    #
    # path      - A path String that exists on the file system.
    # base_path - Optional base to relativize the path
    #
    # Returns a FileBlob.
    def initialize(path, base_path = nil, data=nil)
      @path = path
      @name = base_path ? path.sub("#{base_path}/", '') : path
      @data = data
    end

    # Public: Filename
    #
    # Examples
    #
    #   FileBlob.new("/path/to/language_sniffer/lib/language_sniffer.rb").name
    #   # =>  "/path/to/language_sniffer/lib/language_sniffer.rb"
    #
    #   FileBlob.new("/path/to/language_sniffer/lib/language_sniffer.rb",
    #                "/path/to/language_sniffer").name
    #   # =>  "lib/language_sniffer.rb"
    #
    # Returns a String
    attr_reader :name

    # Public: Read file contents.
    #
    # Returns a String.
    def data
      @data ||= File.read(@path)
    end
  end
end

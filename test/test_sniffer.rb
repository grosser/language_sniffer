require 'language_sniffer'

require 'test/unit'
class TestSniffer < Test::Unit::TestCase
  def test_sniffer
    # path and content given -> does not read file
    assert_equal 'Ruby', LanguageSniffer.detect(:path => 'foo/bar', :content => '#!/usr/bin/env ruby').language.name

    # pure un-descriptive path -> reads file
    assert_equal 'Ruby', LanguageSniffer.detect(:path => 'bin/language_sniffer').language.name

    # pure descriptive path -> does not need to read file
    assert_equal 'Ruby', LanguageSniffer.detect(:path => 'foo/bar.rb').language.name

    # empty
    assert_equal nil, LanguageSniffer.detect(:path => 'test/fixtures/blank').language
  end
end

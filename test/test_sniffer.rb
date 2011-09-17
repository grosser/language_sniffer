require 'language_sniffer'

require 'test/unit'
class TestSniffer < Test::Unit::TestCase
  def test_sniffer
    # path and content given -> does not read file
    assert_equal 'Ruby', LanguageSniffer.detect('foo/bar', :content => '#!/usr/bin/env ruby').language.name

    # pure un-descriptive path -> reads file
    assert_equal 'Ruby', LanguageSniffer.detect('bin/language_sniffer').language.name

    # pure descriptive path -> does not need to read file
    assert_equal 'Ruby', LanguageSniffer.detect('foo/bar.rb').language.name

    # empty
    assert_equal nil, LanguageSniffer.detect('test/fixtures/blank').language
  end
end

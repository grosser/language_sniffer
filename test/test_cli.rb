require 'test/unit'

class TestCLI < Test::Unit::TestCase
  def test_cli
    assert_equal "test/fixtures/bar.h: 11 lines (7 sloc)\n  extension: .h\n  language:  C++\n", `bundle exec ruby bin/language_sniffer test/fixtures/bar.h`
    assert_equal "usage: language_sniffer <file>\n", `bundle exec ruby bin/language_sniffer 2>&1`
    assert_equal "Cannot parse a whole directory\n", `bundle exec ruby bin/language_sniffer lib 2>&1`
  end
end

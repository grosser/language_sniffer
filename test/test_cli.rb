require 'test/unit'

class TestBlob < Test::Unit::TestCase
  def test_cli
    assert_equal "test/fixtures/bar.h: 11 lines (7 sloc)\n  extension: .h\n  language:  C++\n", `bundle exec ruby bin/language_sniffer test/fixtures/bar.h`
  end
end

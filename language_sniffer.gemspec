$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "language_sniffer/version"

Gem::Specification.new do |s|
  s.name    = 'language_sniffer'
  s.version = LanguageSniffer::Version::STRING
  s.summary = "Language detection"
  s.email = %q{grosser.michael@gmail.com}
  s.homepage = %q{http://github.com/grosser/language_sniffer}
  s.authors = ["GitHub, Inc.","Michael Grosser"]

  s.files = Dir['lib/**/*']
  s.executables << 'language_sniffer'

  s.add_development_dependency 'rake'
end

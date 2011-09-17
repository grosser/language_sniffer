# LanguageSniffer

Find out what language a given file is.<br/>
This is a stripped down version of [linguist](https://github.com/github/linguist)

 - pure language detection, nothing else ...
 - no dependencies
 - no Github business logic

### Language detection

Most languages are detected by their file extension. This is the fastest and most common situation. For script files, which are usually extensionless, we do "deep content inspection"™ and check the shebang of the file. Checking the file's contents may also be used for disambiguating languages. C, C++ and Obj-C all use `.h` files. Looking for common keywords, we are usually able to guess the correct language.

    LanguageSniffer.detect("lib/language_sniffer.rb").language.name #=> "Ruby"

    LanguageSniffer.detect("bin/language_sniffer").language.name #=> "Ruby"

See [lib/language_sniffer/language.rb](https://github.com/grosser/language_sniffer/blob/master/lib/language_sniffer/language.rb) and [lib/language_sniffer/languages.yml](https://github.com/github/language_sniffer/blob/master/lib/language_sniffer/languages.yml).

## Installation

To get it, clone the repo and run [Bundler](http://gembundler.com/) to install its dependencies.

    git clone https://github.com/grosser/language_sniffer.git
    cd language_sniffer/
    bundle install

To run the tests:

    bundle exec rake test

## Contributing

1. Fork it.
2. Create a branch (`git checkout -b detect-foo-language`)
3. Make your changes
4. Run the tests (`bundle install` then `bundle exec rake`)
5. Commit your changes (`git commit -am "Added detection for the new Foo language"`)
6. Push to the branch (`git push origin detect-foo-language`)
7. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch.
8. Promote it. Get others to drop in and +1 it.

## Author
Original work by [Github](http://github.com),<br/>
stripping and simplification by [Michael Grosser](http://grosser.it)

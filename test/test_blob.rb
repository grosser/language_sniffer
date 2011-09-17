require 'language_sniffer/file_blob'

require 'test/unit'

class TestBlob < Test::Unit::TestCase
  include LanguageSniffer

  def fixtures_path
    File.expand_path("../fixtures", __FILE__)
  end

  def blob(name)
    FileBlob.new(File.join(fixtures_path, name), fixtures_path)
  end

  def test_name
    assert_equal "foo.rb", blob("foo.rb").name
  end

  def test_pathname
    assert_equal Pathname.new("foo.rb"), blob("foo.rb").pathname
  end

  def test_data
    assert_equal "module Foo\nend\n", blob("foo.rb").data
  end

  def test_lines
    assert_equal ["module Foo", "end", ""], blob("foo.rb").lines
  end

  def test_size
    assert_equal 15, blob("foo.rb").size
  end

  def test_loc
    assert_equal 3, blob("foo.rb").loc
  end

  def test_sloc
    assert_equal 2, blob("foo.rb").sloc
  end

  def test_generated
    assert !blob("README").generated?
    assert blob("MainMenu.xib").generated?
    assert blob("MainMenu.nib").generated?
    assert blob("project.pbxproj").generated?

    # Visual Studio Files
    assert blob("project.csproj").generated?
    assert blob("project.dbproj").generated?
    assert blob("project.isproj").generated?
    assert blob("project.pyproj").generated?
    assert blob("project.rbproj").generated?
    assert blob("project.vbproj").generated?
    assert blob("project.vdproj").generated?
    assert blob("project.vcxproj").generated?
    assert blob("project.wixproj").generated?
    assert blob("project.resx").generated?
    assert blob("project.sln").generated?

    # Generated .NET Docfiles
    assert blob("net_docfile.xml").generated?

    # Long line
    assert !blob("uglify.js").generated?

    # Inlined JS, but mostly code
    assert !blob("json2_backbone.js").generated?

    # Minified JS
    assert !blob("jquery-1.6.1.js").generated?
    assert blob("jquery-1.6.1.min.js").generated?
    assert blob("jquery-1.4.2.min.js").generated?

    # CoffeScript JS

    # These examples are to basic to tell
    assert !blob("coffee/empty.js").generated?
    assert !blob("coffee/hello.js").generated?

    assert blob("coffee/intro.js").generated?
    assert blob("coffee/classes.js").generated?
  end

  def test_language
    assert_equal Language['C'],           blob("hello.c").language
    assert_equal Language['C'],           blob("hello.h").language
    assert_equal Language['C++'],         blob("bar.h").language
    assert_equal Language['C++'],         blob("bar.hpp").language
    assert_equal Language['C++'],         blob("hello.cpp").language
    assert_equal Language['C++'],         blob("cuda.cu").language
    assert_equal Language['GAS'],         blob("hello.s").language
    assert_equal Language['Objective-C'], blob("Foo.h").language
    assert_equal Language['Objective-C'], blob("Foo.m").language
    assert_equal Language['Objective-C'], blob("FooAppDelegate.h").language
    assert_equal Language['Objective-C'], blob("FooAppDelegate.m").language
    assert_equal Language['Objective-C'], blob("hello.m").language
    assert_equal Language['OpenCL'],      blob("fft.cl").language
    assert_equal Language['Ruby'],        blob("foo.rb").language
    assert_equal Language['Ruby'],        blob("script.rb").language
    assert_equal Language['Ruby'],        blob("wrong_shebang.rb").language
    assert_nil blob("octocat.png").language

    # .pl disambiguation
    assert_equal Language['Prolog'],      blob("test-prolog.pl").language
    assert_equal Language['Perl'],        blob("test-perl.pl").language
    assert_equal Language['Perl'],        blob("test-perl2.pl").language

    # .m disambiguation
    assert_equal Language['Objective-C'], blob("Foo.m").language
    assert_equal Language['Objective-C'], blob("hello.m").language
    assert_equal Language['Matlab'], blob("matlab_function.m").language
    assert_equal Language['Matlab'], blob("matlab_script.m").language

    # .r disambiguation
    assert_equal Language['R'],           blob("hello-r.R").language
    assert_equal Language['Rebol'],       blob("hello-rebol.r").language

    # ML
    assert_equal Language['OCaml'],       blob("Foo.ml").language
    assert_equal Language['Standard ML'], blob("Foo.sig").language
    assert_equal Language['Standard ML'], blob("Foo.sml").language

    # Config files
    assert_equal Language['INI'],   blob(".gitconfig").language
    assert_equal Language['Shell'], blob(".bash_profile").language
    assert_equal Language['Shell'], blob(".bashrc").language
    assert_equal Language['Shell'], blob(".profile").language
    assert_equal Language['Shell'], blob(".zlogin").language
    assert_equal Language['Shell'], blob(".zshrc").language
    assert_equal Language['VimL'],  blob(".gvimrc").language
    assert_equal Language['VimL'],  blob(".vimrc").language
    assert_equal Language['YAML'],  blob(".gemrc").language

    assert_nil blob("blank").language
    assert_nil blob("README").language

    # https://github.com/xquery/xprocxq/blob/master/src/xquery/xproc.xqm
    assert_equal Language['XQuery'], blob("xproc.xqm").language

    # https://github.com/wycats/osx-window-sizing/blob/master/center.applescript
    assert_equal Language['AppleScript'], blob("center.scpt").language
    assert_equal Language['AppleScript'], blob("center.applescript").language

    # https://github.com/Araq/Nimrod/tree/master/examples
    assert_equal Language['Nimrod'], blob("foo.nim").language

    # http://supercollider.sourceforge.net/
    # https://github.com/drichert/BCR2000.sc/blob/master/BCR2000.sc
    assert_equal Language['SuperCollider'], blob("BCR2000.sc").language

    # https://github.com/harrah/xsbt/wiki/Quick-Configuration-Examples
    assert_equal Language['Scala'], blob('build.sbt').language

    # https://github.com/gradleware/oreilly-gradle-book-examples/blob/master/ant-antbuilder/build.gradle
    assert_equal Language['Groovy'], blob("build.gradle").language

    # http://docs.racket-lang.org/scribble/
    assert_equal Language['Racket'], blob("scribble.scrbl").language

    # https://github.com/drupal/drupal/blob/7.x/modules/php/php.module
    assert_equal Language['PHP'], blob("drupal.module").language

    # https://github.com/googleapi/googleapi/blob/master/demos/gmail_demo/gmail.dpr
    assert_equal Language['Delphi'], blob("program.dpr").language

    # https://github.com/philiplaureano/Nemerle.FizzBuzz/blob/master/FizzBuzz/FizzBuzzer.n
    assert_equal Language['Nemerle'], blob("hello.n").language

    # https://github.com/dharmatech/agave/blob/master/demos/asteroids.sps
    assert_equal Language['Scheme'], blob("asteroids.sps").language

    # https://github.com/graydon/rust
    assert_equal Language['Rust'], blob("hello.rs").language

    # https://github.com/olabini/ioke
    assert_equal Language['Ioke'], blob("hello.ik").language

    # https://github.com/parrot/parrot
    assert_equal Language['Parrot Internal Representation'], blob("hello.pir").language
    assert_equal Language['Parrot Assembly'], blob("hello.pasm").language

    # http://gosu-lang.org
    assert_equal Language['Gosu'], blob("Hello.gsx").language
    assert_equal Language['Gosu'], blob("hello.gsp").language
    assert_equal Language['Gosu'], blob("Hello.gst").language
    assert_equal Language['Gosu'], blob("hello.vark").language

    # Groovy Server Pages
    assert_equal Language['Groovy Server Pages'], blob("bar.gsp").language
    assert_equal Language['Groovy Server Pages'], blob("hello-resources.gsp").language
    assert_equal Language['Groovy Server Pages'], blob("hello-pagedirective.gsp").language
    assert_equal Language['Groovy Server Pages'], blob("hello-var.gsp").language

    # https://github.com/Lexikos/AutoHotkey_L
    assert_equal Language['AutoHotkey'], blob("hello.ahk").language

    # Haml
    assert_equal Language['Haml'], blob("hello.haml").language
    assert_equal Language['HTML'], blob("hello.haml").language.group

    # Sass
    assert_equal Language['Sass'], blob("screen.sass").language
    assert_equal Language['CSS'], blob("screen.sass").language.group
    assert_equal Language['SCSS'], blob("screen.scss").language
    assert_equal Language['CSS'], blob("screen.scss").language.group
  end

  def test_shebang_script
    assert_equal 'sh', blob("script.sh").shebang_script
    assert_equal 'bash', blob("script.bash").shebang_script
    assert_equal 'zsh', blob("script.zsh").shebang_script
    assert_equal 'perl', blob("script.pl").shebang_script
    assert_equal 'ruby', blob("script.rb").shebang_script
    assert_equal 'ruby', blob("script2.rb").shebang_script
    assert_equal 'python', blob("script.py").shebang_script
    assert_equal 'node', blob("script.js").shebang_script
    assert_equal 'groovy', blob("script.groovy").shebang_script
    assert_equal 'macruby', blob("script.mrb").shebang_script
    assert_equal 'rake', blob("script.rake").shebang_script
    assert_equal 'foo', blob("script.foo").shebang_script
    assert_equal 'nush', blob("script.nu").shebang_script
    assert_equal 'scala', blob("script.scala").shebang_script
    assert_equal 'racket', blob("script.rkt").shebang_script
    assert_equal nil, blob("foo.rb").shebang_script
  end

  def test_shebang_language
    assert_equal Language['Shell'], blob("script.sh").shebang_language
    assert_equal Language['Shell'], blob("script.bash").shebang_language
    assert_equal Language['Shell'], blob("script.zsh").shebang_language
    assert_equal Language['Perl'], blob("script.pl").shebang_language
    assert_equal Language['Ruby'], blob("script.rb").shebang_language
    assert_equal Language['Python'], blob("script.py").shebang_language
    assert_equal Language['JavaScript'], blob("script.js").shebang_language
    assert_equal Language['Groovy'], blob("script.groovy").shebang_language
    assert_equal Language['Ruby'], blob("script.mrb").shebang_language
    assert_equal Language['Ruby'], blob("script.rake").shebang_language
    assert_equal Language['Nu'], blob("script.nu").shebang_language
    assert_equal Language['Scala'], blob("script.scala").shebang_language
    assert_equal Language['Racket'], blob("script.rkt").shebang_language
    assert_equal nil, blob("script.foo").shebang_language
    assert_equal nil, blob("foo.rb").shebang_language
  end
end

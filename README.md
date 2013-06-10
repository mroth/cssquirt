# CSSquirt

[![Gem Version](https://badge.fury.io/rb/cssquirt.png)](http://badge.fury.io/rb/cssquirt)
[![Build Status](https://travis-ci.org/mroth/cssquirt.png?branch=master)](https://travis-ci.org/mroth/cssquirt)

Embeds images (or directories of images) directly into CSS via the Data URI scheme.

This technique is commonly used to reduce HTTP requests as an easier alternative to CSS sprite sheets.

Some notes/caveats for using this technique:
 - Be sure your web server is configured to gzip your HTML/CSS content, and any size overhead should disapear.
 - The maximum size supported is 32KB per image.

For more information see [this article](#).

## Installation

Add this line to your application's Gemfile:

    gem 'cssquirt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cssquirt

## Usage

### As a library
Just `require 'cssquirt'` and you should be good to go.

#### Working on individual files
Example from an IRB session:

    >> myImg = CSSquirt::ImageFile.new 'spec/samples/example.gif'
    => #<CSSquirt::ImageFile:0x007fbffb3af580 @file_path="spec/samples/example.gif">

    >> myImg.as_img_tag
    => "<img src='data:image/gif;base64,R0lGODlhNQAmAKL/AP///wC1/wghSsDAwAAAAAAAAAAAAAAAACH5BAEAAAMALAAAAAA1ACYAAAP4OLrc/jDKSau9lRDMOwlbJ1IfOJ6QFphoqwgl657wumozg1vxre2tDzDSs4F8QVuIaFQah50aaOlQNa3K3e8ikE6rxduVAPgBztRJNwbEjp/kcxmdVnun4edVXo5DKXdNgmJPfBpydSSDi4RZhj8CHoyLYYd9BF2RHGx5V4M/QpginJ1OkzcDfxMlmDClU5SgrBhCmWuTlbJXF7Uvt43AP7g8IJoLv0WkjBrGq60Oa26wR8vPFZkQv57UgpDNdhKBpt3MXTkLnbmt5ucKpLKytu06N7Zstuzz6MX4tfL69Kz5YgaQSL5jBwsywPYgocJjDyNKnEiRQQIAO3x6ChocsO0CwoUUFEKcSLGiRQ8RAAA7' />"

    >> myImg.as_css_background
    => "background: url(data:image/gif;base64,R0lGODlhNQAmAKL/AP///wC1/wghSsDAwAAAAAAAAAAAAAAAACH5BAEAAAMALAAAAAA1ACYAAAP4OLrc/jDKSau9lRDMOwlbJ1IfOJ6QFphoqwgl657wumozg1vxre2tDzDSs4F8QVuIaFQah50aaOlQNa3K3e8ikE6rxduVAPgBztRJNwbEjp/kcxmdVnun4edVXo5DKXdNgmJPfBpydSSDi4RZhj8CHoyLYYd9BF2RHGx5V4M/QpginJ1OkzcDfxMlmDClU5SgrBhCmWuTlbJXF7Uvt43AP7g8IJoLv0WkjBrGq60Oa26wR8vPFZkQv57UgpDNdhKBpt3MXTkLnbmt5ucKpLKytu06N7Zstuzz6MX4tfL69Kz5YgaQSL5jBwsywPYgocJjDyNKnEiRQQIAO3x6ChocsO0CwoUUFEKcSLGiRQ8RAAA7) no-repeat;"

    >> puts myImg.as_css_background_with_class
      .example_gif {
        background: url(data:image/gif;base64,R0lGODlhNQAmAKL/AP///wC1/wghSsDAwAAAAAAAAAAAAAAAACH5BAEAAAMALAAAAAA1ACYAAAP4OLrc/jDKSau9lRDMOwlbJ1IfOJ6QFphoqwgl657wumozg1vxre2tDzDSs4F8QVuIaFQah50aaOlQNa3K3e8ikE6rxduVAPgBztRJNwbEjp/kcxmdVnun4edVXo5DKXdNgmJPfBpydSSDi4RZhj8CHoyLYYd9BF2RHGx5V4M/QpginJ1OkzcDfxMlmDClU5SgrBhCmWuTlbJXF7Uvt43AP7g8IJoLv0WkjBrGq60Oa26wR8vPFZkQv57UgpDNdhKBpt3MXTkLnbmt5ucKpLKytu06N7Zstuzz6MX4tfL69Kz5YgaQSL5jBwsywPYgocJjDyNKnEiRQQIAO3x6ChocsO0CwoUUFEKcSLGiRQ8RAAA7) no-repeat;
      }
    => nil

    >> puts myImg.as_css_background_with_class('funkytown')
      .funkytown {
        background: url(data:image/gif;base64,R0lGODlhNQAmAKL/AP///wC1/wghSsDAwAAAAAAAAAAAAAAAACH5BAEAAAMALAAAAAA1ACYAAAP4OLrc/jDKSau9lRDMOwlbJ1IfOJ6QFphoqwgl657wumozg1vxre2tDzDSs4F8QVuIaFQah50aaOlQNa3K3e8ikE6rxduVAPgBztRJNwbEjp/kcxmdVnun4edVXo5DKXdNgmJPfBpydSSDi4RZhj8CHoyLYYd9BF2RHGx5V4M/QpginJ1OkzcDfxMlmDClU5SgrBhCmWuTlbJXF7Uvt43AP7g8IJoLv0WkjBrGq60Oa26wR8vPFZkQv57UgpDNdhKBpt3MXTkLnbmt5ucKpLKytu06N7Zstuzz6MX4tfL69Kz5YgaQSL5jBwsywPYgocJjDyNKnEiRQQIAO3x6ChocsO0CwoUUFEKcSLGiRQ8RAAA7) no-repeat;
      }
    => nil

#### Working on groups of files
Use `CSSquirt::ImageFileList` which just extends the goodness of a [`Rake::FileList`](http://rake.rubyforge.org/classes/Rake/FileList.html) and adds some batch processing.  The batch processing is smart enough to report errors to you on specific files via `STDERR` but will just omit those files from the final output.

    >> filez=CSSquirt::ImageFileList.new('samples/*')
    => ["samples/16px_rocket.png", "samples/64px_bomb.png", "samples/example.gif", "samples/example.jpg", "samples/example.mp3", "samples/example.svg", "samples/toobig.gif"]

    >> filez.exclude('samples/*.png')
    => ["samples/example.gif", "samples/example.jpg", "samples/example.mp3", "samples/example.svg", "samples/toobig.gif"]

    >> doc = filez.to_css
    WARNING: skipped file - File samples/example.mp3 reports type application/octet-stream which is not a supported image format.
    WARNING: skipped file - File samples/toobig.gif is too big - 104710 greater than 32768.

    >> puts doc
    /* Generated with CSSquirt! (http://github.com/mroth/cssquirt/) */
    .example_gif {
      background: url(data:image/gif;base64,R0lGODlhN[snip...]) no-repeat;
    }
    .example_jpg {
      background: url(data:image/jpeg;base64,/9j/4AAQS[snip...]) no-repeat;
    }
    .example_svg {
      background: url(data:image/svg+xml;base64,PD94bWwgdmV[snip...]) no-repeat;
    }
    => nil

### From the command line
Coming soon!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Middleman Dragonfly Thumbnailer

Middleman Dragonfly Thumbnailer is a Middleman extension that lets you easily create thumbnails using Dragonfly's fantastic thumb processor.

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-dragonfly_thumbnailer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-dragonfly_thumbnailer

## Usage

    <%= thumb_tag 'image.png', '100x100#', class: 'thumbnail' %>

The second argument is a geometry string which specifies the dimensions and options such as aspect ratio and cropping. Have a look at http://markevans.github.io/dragonfly/imagemagick/ for examples of what you can do.

When running Middleman in development, thumbnails will be generated on the fly and encoded in data URLs.

During a build, the thumbnails will be saved next to original image in a sub directory named from the geometry string, so the thumbnail for `images/image.png` will be saved as `images/100x100/image.png`.

## Contributing

1. Fork it ( https://github.com/scarypine/middleman-dragonfly_thumbnailer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Copyright (c) 2014 Andrew White. MIT Licensed, see LICENSE.txt for details.

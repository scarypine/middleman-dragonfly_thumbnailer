module Middleman
  module DragonflyThumbnailer
    class Extension < Middleman::Extension
      attr_accessor :images

      def initialize(app, options_hash = {}, &block)
        super
        @images = []
        configure_dragonfly
      end

      def absolute_source_path(path)
        File.join(app.config[:source], app.config[:images_dir], path)
      end

      def build_path(image)
        dir = File.dirname(image.meta['original_path'])
        subdir = image.meta['geometry'].gsub(/[^a-zA-Z0-9\-]/, '')
        File.join(dir, subdir, image.name)
      end

      def absolute_build_path(image)
        File.join(app.config[:build_dir], app.config[:images_dir],
                  build_path(image))
      end

      def thumb(path, geometry)
        image = ::Dragonfly.app.fetch_file(absolute_source_path(path))
        image.meta['original_path'] = path
        image.meta['geometry'] = geometry
        image = image.thumb(geometry)
        images << image
        image
      end

      def after_build(builder)
        images.each do |image|
          builder.say_status :create, build_path(image)
          path = absolute_build_path(image)
          image.to_file(path).close
        end
      end

      helpers do
        def thumb_tag(path, geometry, options = {})
          image = extensions[:dragonfly_thumbnailer].thumb(path, geometry)

          if environment == :development
            url = image.b64_data
          else
            url = extensions[:dragonfly_thumbnailer].build_path(image)
          end

          image_tag(url, options)
        end
      end

      private

      def configure_dragonfly
        ::Dragonfly.app.configure do
          datastore :memory
          plugin :imagemagick
        end
      end
    end
  end
end

::Middleman::Extensions.register(
  :dragonfly_thumbnailer,
  Middleman::DragonflyThumbnailer::Extension
)

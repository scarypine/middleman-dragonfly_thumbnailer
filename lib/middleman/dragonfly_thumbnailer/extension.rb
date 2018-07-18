require 'middleman-core/logger'
require 'dragonfly'

module Middleman
  module DragonflyThumbnailer
    class Extension < Middleman::Extension
      def initialize(app, options_hash = {}, &block)
        super
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

      def thumb(path, geometry, image_options = {})
        absolute_path = absolute_source_path path
        return unless File.exist?(absolute_path)

        image = ::Dragonfly.app.fetch_file(absolute_path)
        image.meta['original_path'] = path
        image.meta['geometry'] = geometry
        image = image.thumb(geometry, image_options)

        if app.build?
          persist_file(image)
          build_path(image)
        else
          image.b64_data
        end
      end

      def extract_image_options(options)
        image_options = {
          'format' => options.delete(:format),
          'frame'  => options.delete(:frame)
        }.delete_if { |_k, v| v.nil? }

        return options, image_options
      end

      def persist_file(image)
        path = absolute_build_path(image)
        image.to_file(path).close
      end

      helpers do
        def thumb_tag(path, geometry, options = {})
          extension = extensions[:dragonfly_thumbnailer]

          options, image_options = extension.extract_image_options(options)
          url = extension.thumb(path, geometry, image_options)

          image_tag(url, options) if url
        end

        def thumb_path(path, geometry, options = {})
          extension = extensions[:dragonfly_thumbnailer]

          _options, image_options = extension.extract_image_options(options)
          url = extension.thumb(path, geometry, image_options)

          image_path(url) if url
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

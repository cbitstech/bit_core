# frozen_string_literal: true
module BitCore
  module ContentProviders
    # Defines presentation logic for a Slideshow.
    class SlideshowProvider < BitCore::ContentProvider
      def slideshow
        source_content || Slideshow.new
      end

      def render_current(options)
        options.view_context.render(
          template: "slides/show",
          locals: {
            slide: slide(options.position)
          }
        )
      end

      def slide(position)
        slideshow.slides.find_by(position: position) ||
          BitCore::Slide.new(body: "no slides")
      end

      def exists?(position)
        slideshow.slides.exists?(position: position)
      end

      def show_nav_link?
        true
      end

      def add_or_update_slideshow(title, arm_id = nil)
        if source_content
          source_content.update(title: title)
        else
          slideshow = BitCore::Slideshow.create(arm_id: arm_id, title: title)
          update(source_content: slideshow)
        end

        source_content
      end
    end
  end
end

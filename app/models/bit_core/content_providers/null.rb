# frozen_string_literal: true
module BitCore
  module ContentProviders
    # The default provider.
    class Null
      attr_reader :position

      def initialize(content_module, position)
        @content_module = content_module
        @position = position
      end

      def render_current(_options)
        "Content Module #{@content_module.title}: Oops, did you expect a
        content provider here?"
      end

      def show_nav_link?
        false
      end

      def exists?(_position)
        false
      end
    end
  end
end

# frozen_string_literal: true
module BitCore
  # A logical unit of content, possibly containing mixed provider types.
  class ContentModule < ActiveRecord::Base
    belongs_to :tool,
               class_name: "BitCore::Tool",
               foreign_key: :bit_core_tool_id
    has_many :content_providers,
             class_name: "BitCore::ContentProvider",
             foreign_key: :bit_core_content_module_id,
             inverse_of: :content_module,
             dependent: :destroy

    validates :title, :tool, :position, presence: true
    validates :position,
              numericality: { greater_than_or_equal_to: 1 },
              uniqueness: { scope: :bit_core_tool_id }

    # Returns the `ContentProvider` at the given position, or a `Null`
    # `ContentProvider` if none exists.
    def provider(position)
      content_providers.find_by(position: position) ||
        ContentProviders::Null.new(self, position)
    end

    def provider_exists?(position)
      content_providers.exists?(position: position)
    end

    def add_content_provider(type)
      content_providers.build(
        type: type,
        position: next_position,
        show_next_nav: true
      )
    end

    def last_position
      content_providers.order(:position).last.try(:position) || 0
    end

    private

    def next_position
      last_position + 1
    end
  end
end

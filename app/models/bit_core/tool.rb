# frozen_string_literal: true
module BitCore
  # A section of an application.
  class Tool < ActiveRecord::Base
    belongs_to :arm

    has_many :content_modules,
             class_name: "BitCore::ContentModule",
             foreign_key: :bit_core_tool_id,
             inverse_of: :tool,
             dependent: :destroy

    validates :arm, :position, :title, presence: true
    validates :position,
              numericality: { greater_than_or_equal_to: 0 },
              uniqueness: { scope: :arm_id }

    def add_module(title_or_module)
      if title_or_module.class == String
        content_modules.build(title: title_or_module, position: next_position)
      else
        title_or_module.tap do |m|
          m.tool = self
          m.position = next_position
        end
      end
    end

    def last_position
      content_modules.order(:position).last.try(:position) || 0
    end

    private

    def next_position
      last_position + 1
    end
  end
end

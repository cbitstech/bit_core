# frozen_string_literal: true
require "redcarpet"

module BitCore
  # A page of "static" or presentational content (as opposed to data capture).
  class Slide < ActiveRecord::Base
    belongs_to :slideshow,
               class_name: "BitCore::Slideshow",
               foreign_key: :bit_core_slideshow_id,
               inverse_of: :slides

    validates :title, :position, presence: true
    validates :position, numericality: { greater_than_or_equal_to: 1 }
    validates :position, uniqueness: { scope: :bit_core_slideshow_id }

    after_destroy :update_slide_positions

    def render_body
      return "" if body.nil?

      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(
          filter_html: true,
          safe_links_only: true
        ),
        space_after_headers: true
      ).render(body).html_safe
    end

    private

    def update_slide_positions
      slideshow.reload
               .sort(slideshow.slide_ids)
    end
  end
end

# frozen_string_literal: true
require "spec_helper"

module BitCore
  module ContentProviders
    describe SlideshowProvider do
      subject(:provider) { SlideshowProvider.new }

      it "returns new objects when there is no source content" do
        expect(provider.slideshow).to be_a Slideshow
        expect(provider.slide(1)).to be_a Slide
      end
    end
  end
end

# frozen_string_literal: true
require "spec_helper"

module BitCore
  describe Slide do
    fixtures :"bit_core/slideshows", :"bit_core/slides"

    describe "#render_body" do
      it "should render a nil body" do
        expect(subject.render_body).to eq("")
      end

      it "should render markdown as html" do
        subject.body = "# header"

        expect(subject.render_body).to match(%r{<h1>header<\/h1>})
      end

      it "should escape html" do
        subject.body = "<div>my content</div>"

        expect(subject.render_body).to match(%r{<p>my content<\/p>})
      end
    end

    describe "when destroyed" do
      let(:slideshow) { bit_core_slideshows(:slideshow1) }
      let(:slide) { bit_core_slides(:slide2) }

      it "updates the positions of remaining slides" do
        expect(slideshow.slides.map(&:position)).to eq [1, 2, 3]
        expect(slide.position).to eq 2

        slide.destroy

        expect(slideshow.reload.slides.map(&:position))
          .to eq [1, 2]
      end
    end
  end
end

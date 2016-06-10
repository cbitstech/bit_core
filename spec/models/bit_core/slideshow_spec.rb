# frozen_string_literal: true
require "spec_helper"

module BitCore
  describe Slideshow do
    fixtures :"bit_core/slideshows", :"bit_core/slides"

    let(:slideshow) { bit_core_slideshows(:slideshow1) }

    describe "#add" do
      it "should return a slide with its position set to the end" do
        new_slide = slideshow.add(title: "New", body: "Slide")

        expect(new_slide.valid?).to be_truthy
        expect(new_slide.position).to eq 4
      end
    end

    describe "#remove" do
      it "should update remaining slide positions" do
        result = slideshow.remove(bit_core_slides(:slide2))

        expect(result).to be_truthy
        expect(slideshow.slides.count).to eq 2
        expect(slideshow.slides.first.id).to eq bit_core_slides(:slide1).id
        expect(slideshow.slides.first.position).to eq 1
        expect(slideshow.slides.second.id).to eq bit_core_slides(:slide3).id
        expect(slideshow.slides.second.position).to eq 2
      end
    end

    describe "#sort" do
      it "should update slide positions to match the order of the ids" do
        slide1 = bit_core_slides(:slide1)
        slide2 = bit_core_slides(:slide2)
        slide3 = bit_core_slides(:slide3)
        slideshow.sort([slide3.id, slide1.id, slide2.id])

        expect(slideshow.slides.find(slide1.id).position).to eq(2)
        expect(slideshow.slides.find(slide2.id).position).to eq(3)
        expect(slideshow.slides.find(slide3.id).position).to eq(1)
      end
    end

    describe "when a slideshow has many slides" do
      before do
        expect(slideshow.slides.count).to be > 0
      end

      it "can be deleted" do
        expect do
          slideshow.destroy
        end.to change { BitCore::Slideshow.count }.by(-1)
      end
    end
  end
end

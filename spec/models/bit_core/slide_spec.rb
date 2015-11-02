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
  end
end

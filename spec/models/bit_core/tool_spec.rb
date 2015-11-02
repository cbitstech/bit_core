require "spec_helper"

module BitCore
  describe Slide do
    describe "#slug" do
      let(:tool) { BitCore::Tool.create(title: "I'm a tool") }

      describe "when the slug field is nil" do
        it "should reference the title" do
          expect(tool.slug_title)
            .to eq "I'm a tool"
        end
      end

      describe "when the slug field is not nil" do
        it "should reference the slug" do
          tool.update(slug: "I'm a slug")

          expect(tool.slug_title)
            .to eq "I'm a slug"
        end
      end
    end
  end
end

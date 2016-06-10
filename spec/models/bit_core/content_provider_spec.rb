# frozen_string_literal: true
require "spec_helper"

module BitCore
  describe ContentProvider do
    describe "validations" do
      it "should validate the existence of the template path" do
        p = ContentProvider.new(template_path: "foobaz")
        p.valid?

        expect(p.errors[:template_path].length).to eq 1

        p.template_path = "layouts"
        p.valid?

        expect(p.errors[:template_path].length).to eq 0
      end

      it "should validate the existence of the data class" do
        p = ContentProvider.new(data_class_name: "foobaz")
        p.valid?

        expect(p.errors[:data_class_name].length).to eq 1

        p.data_class_name = "BitCore::ContentProvider"
        p.valid?

        expect(p.errors[:data_class_name].length).to eq 0
      end

      it "should validate the existence of the data attributes" do
        p = ContentProvider.new(
          data_class_name: "BitCore::Tool",
          data_attributes: %w(baz)
        )
        p.valid?

        expect(p.errors[:data_attributes].length).to eq 1

        p.data_attributes = %w(id title)
        p.valid?

        expect(p.errors[:data_attributes].length).to eq 0
      end
    end
  end
end

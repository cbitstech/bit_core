# frozen_string_literal: true
require "spec_helper"

module BitCore
  describe ContentModule do
    fixtures :"bit_core/tools", :"bit_core/content_modules",
             :"bit_core/content_providers"

    describe "#provider" do
      it "should return the Null Provider when one is not found" do
        provider = bit_core_content_modules(:home_landing).provider(8)
        expect(provider.position).to eq(8)
        expect(provider.class).to eq(ContentProviders::Null)
      end

      it "should return the associated provider at the position" do
        provider = bit_core_content_modules(:home_landing).provider(1)
        expect(provider.position).to eq(1)
        expect(provider.class).not_to eq(ContentProviders::Null)
      end
    end
  end
end

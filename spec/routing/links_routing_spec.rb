require "rails_helper"

RSpec.describe LinksController, type: :routing do
  describe "routing" do
    it "routes to #top" do
      expect(get: "/top").to route_to("links#top_links")
    end

    it "routes to #create" do
      expect(post: "/shorten").to route_to("links#create")
    end
    
    it "routes to #show" do
      expect(get: "/get/a").to route_to({
        controller: "links",
        action: "show",
        short_code: "a"
      })
    end
    
  end
end

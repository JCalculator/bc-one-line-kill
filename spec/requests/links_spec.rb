require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/links", type: :request do
  
  let(:create_url) { "/shorten" }

  let(:valid_attributes) {
    { url: "https://www.google.com" }
  }

  let(:existing_attributes) {
    { url: "https://www.existing.com" }
  }

  let(:invalid_attributes) {
    { random: "random"}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # LinksController, or in your router and rack
  # middleware. Be sure to keep this valid_attributesupdated too.
  let(:valid_headers) {
    {}
  }


  describe "GET /top" do
    it "renders a successful response" do
      get '/top', as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /get/:short_code" do
    it "renders a successful response" do
      link = Link.create! { url: "https://www.google.com", short_code: "a" }
      get "/get/#{link.short_code}", as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Link" do
        expect {
          post create_url,
               params: { link: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Link, :count).by(1)
      end
      
      it "does not a new Link if it exists" do
        link = Link.create! existing_attributes
        expect {
          post create_url,
               params: { link: existing_attributes }, headers: valid_headers, as: :json
      }.not_to change(Link, :count)
      end

      it "renders a JSON response with the new link" do
        post create_url,
             params: { link: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Link" do
        expect {
          post create_url,
               params: { link: invalid_attributes }, as: :json
        }.to change(Link, :count).by(0)
      end

      it "renders a JSON response with errors for the new link" do
        post create_url,
             params: { link: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

end
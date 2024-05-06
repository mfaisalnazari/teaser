require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  let(:customer) do
    Customer.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      address: "123 Main St, City, Country"
    )
  end

  let(:tea1) do
    Tea.create!(
      title: "Green Tea",
      description: "Light and refreshing tea with a grassy flavor.",
      temperature: 75,
      brew_time: 2
    )
  end

  let(:tea2) do
    Tea.create!(
      title: "Black Tea",
      description: "Full-bodied tea with a bold flavor and rich aroma.",
      temperature: 95,
      brew_time: 4
    )
  end

  let(:subscription1) do
    Subscription.create!(
      title: "Subscription 1",
      price: 9.99,
      status: "active",
      frequency: "monthly",
      customer: customer,
      tea: tea1
    )
  end

  let(:subscription2) do
    Subscription.create!(
      title: "Subscription 2",
      price: 14.99,
      status: "cancelled",
      frequency: "monthly",
      customer: customer,
      tea: tea2
    )
  end

  describe "GET /customers/:customer_id/subscriptions" do
    it "returns a list of subscriptions for the specified customer" do
      subscription1
      subscription2

      get "/customers/#{customer.id}/subscriptions"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to start_with('application/json')

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)
      expect(json_response.map { |subscription| subscription['id'] }).to match_array([subscription1.id, subscription2.id])
    end
  end

  describe "POST /subscriptions" do
    context "with valid parameters" do
      it "creates a new subscription" do
        post_params = {
          subscription: {
            title: "Subscription 1",
            price: 9.99,
            status: "active",
            frequency: "monthly",
            customer_id: customer.id,
            tea_id: tea1.id
          }
        }

        post "/subscriptions", params: post_params

        expect(response).to have_http_status(:created)
        expect(response.content_type).to start_with('application/json')

        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('Subscription 1')
      end
    end

    context "with invalid parameters" do
      it "returns an error message" do
        post_params = {
          subscription: {
            title: nil,
            price: 9.99,
            status: "active",
            frequency: "monthly"
          }
        }

        post "/subscriptions", params: post_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to start_with('application/json')

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe "DELETE /subscriptions/:id" do
    it "cancels the subscription" do
      subscription_to_delete = subscription1

      delete "/subscriptions/#{subscription_to_delete.id}"
      expect(response).to have_http_status(:no_content)
      subscription_to_delete.reload
      expect(subscription_to_delete.status).to eq('cancelled')
    end
  end
end

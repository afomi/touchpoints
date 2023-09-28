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

RSpec.describe "/admin/cx_action_plans", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # CxActionPlan. As you add validations to CxActionPlan, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      CxActionPlan.create! valid_attributes
      get admin_cx_action_plans_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      cx_action_plan = CxActionPlan.create! valid_attributes
      get admin_cx_action_plan_url(cx_action_plan)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    let(:user) { FactoryBot.create(:user, :admin) }

    before do
      sign_in(user)
    end

    it "renders a successful response" do
      get new_admin_cx_action_plan_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      cx_action_plan = CxActionPlan.create! valid_attributes
      get edit_admin_cx_action_plan_url(cx_action_plan)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new CxActionPlan" do
        expect {
          post admin_cx_action_plans_url, params: { cx_action_plan: valid_attributes }
        }.to change(CxActionPlan, :count).by(1)
      end

      it "redirects to the created cx_action_plan" do
        post admin_cx_action_plans_url, params: { cx_action_plan: valid_attributes }
        expect(response).to redirect_to(cx_action_plan_url(CxActionPlan.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new CxActionPlan" do
        expect {
          post admin_cx_action_plans_url, params: { cx_action_plan: invalid_attributes }
        }.to change(CxActionPlan, :count).by(0)
      end


      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post admin_cx_action_plans_url, params: { cx_action_plan: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested cx_action_plan" do
        cx_action_plan = CxActionPlan.create! valid_attributes
        patch admin_cx_action_plan_url(cx_action_plan), params: { cx_action_plan: new_attributes }
        cx_action_plan.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the cx_action_plan" do
        cx_action_plan = CxActionPlan.create! valid_attributes
        patch admin_cx_action_plan_url(cx_action_plan), params: { cx_action_plan: new_attributes }
        cx_action_plan.reload
        expect(response).to redirect_to(cx_action_plan_url(cx_action_plan))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        cx_action_plan = CxActionPlan.create! valid_attributes
        patch cx_action_plan_url(cx_action_plan), params: { cx_action_plan: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested cx_action_plan" do
      cx_action_plan = CxActionPlan.create! valid_attributes
      expect {
        delete cx_action_plan_url(cx_action_plan)
      }.to change(CxActionPlan, :count).by(-1)
    end

    it "redirects to the cx_action_plans list" do
      cx_action_plan = CxActionPlan.create! valid_attributes
      delete cx_action_plan_url(cx_action_plan)
      expect(response).to redirect_to(cx_action_plans_url)
    end
  end
end

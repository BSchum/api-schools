require 'test_helper'

feature "Authentication" do
  before do
    User.destroy_all
  end

  describe "#create" do
    it "logs_in user with valid email+password" do
      user = User.create!(
        email: "user_2@domain.com",
        password: "password123",
        password_confirmation: "password123"
      )

      post api_v1_user_session_path, {
        email: user.email,
        password: user.password
        # password: "bad password"
      }

      assert_equal 200, last_response.status
      # puts json_response['auth_token']
      # assert_equal false, json_response['auth_token'].blank?
    end
  end
end

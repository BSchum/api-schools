require 'test_helper'

feature "Schools" do
  describe "#index" do
    it "return 401 when user is not authenticated" do
      get api_v1_schools_path, nil
      assert_equal 401, last_response.status
    end

    it "return 401 when auth_token is unknow" do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => '12345AZERTY'}
      assert_equal 401, last_response.status
    end

    it "return 200 when auth_token is valid" do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => 'valid_token'}
      assert_equal 2, json_response['schools'].count
      assert_equal 200, last_response.status
    end
  end

  describe "#create" do
    it "return 200 when school is successfully created" do
      assert_difference "School.all.count" do
        post api_v1_schools_path, {
          school: {name: "new school"}},{'HTTP_AUTHORIZATION' => 'valid_token'}
          assert_equal 200, last_response.status
          assert_equal "new school", json_response['school']['name']
      end
    end
    it "return 400 when school is unsuccessfully created" do
      assert_no_difference "School.all.count" do
        post api_v1_schools_path, {
          school: {name: ""}},{'HTTP_AUTHORIZATION' => 'valid_token'}
          assert_equal 422, last_response.status
      end
    end
  end

  describe "#update" do
    it "return 200 when school is successfully updated" do
        post api_v1_schools_path(1), {school:{name: "Mon école update"}}, {'HTTP_AUTHORIZATION' => 'valid_token'}
        assert_equal 200, last_response.status
        assert_equal "Mon école update",  json_response['school']['name']
    end
    it "return 422 when trying to update with a invalid name" do
        post api_v1_schools_path(1), {school:{name: ""}}, {'HTTP_AUTHORIZATION' => 'valid_token'}
        assert_equal 422, last_response.status
    end
  end

  describe "#destroy" do
    it "return 200 when school is successfully deleted" do
      assert_difference "School.all.count", -1 do
        delete api_v1_school_path(1), nil, {'HTTP_AUTHORIZATION' => 'valid_token'}
        assert_equal 200, last_response.status
      end
    end
  end
end

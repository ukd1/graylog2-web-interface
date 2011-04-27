require 'test_helper'

class HealthControllerTest < ActionController::TestCase
  should "get index" do
    2.times { ServerValue.make }
    get :index
  end
end

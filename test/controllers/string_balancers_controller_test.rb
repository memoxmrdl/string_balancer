require "test_helper"

class StringBalancersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = {
      string_balancer: {
        prompt: "no voy (:()"
      }
    }
  end

  def test_it_responds_accepted_when_string_is_balanced
    post string_balancers_path, params: @params

    assert_response :accepted
  end

  def test_it_responds_unprocessable_entity_when_string_is_desbalanced
    @params[:string_balancer][:prompt] = "(()"

    post string_balancers_path, params: @params

    assert_response :unprocessable_entity
  end
end

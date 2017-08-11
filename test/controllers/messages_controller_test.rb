require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  test 'GET new' do
    get root_url

    assert_response :success

    assert_select 'form' do
      assert_select 'input[type=text]'
      assert_select 'input[type=email]'
      assert_select 'textarea'
      assert_select 'button[type=submit]'
    end
  end

  test 'POST create' do
    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
      post create_message_url, params: {
          message: {
              name:   'myfriend',
              email:  'myfriend@justkidding.com',
              body:   'hello there'
          }
      }
    end

    assert_redirected_to root_url

    follow_redirect!

    assert_match /We have received your message and will be in contact with you soon!/, response.body
  end

  test 'invalid POST create' do
    post create_message_url, params: {
        message: { name: '', email: '', body: '' }
    }

    assert_match /Name .* blank/, response.body
    assert_match /Email .* blank/, response.body
    assert_match /Body .* blank/, response.body
  end

end
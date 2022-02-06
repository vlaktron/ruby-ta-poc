# frozen_string_literal: true

require 'airborne'
require 'spec_helper'

Airborne.configure do |config|
  config.base_url = 'https://restful-booker.herokuapp.com'
end

RSpec.describe 'auth spec' do
  it 'should return a token with valid credentials' do
    post '/auth', { username: 'admin', password: 'password123' }, { content_type: 'application/json' }
    expect_status '200'
    expect_json_types(token: :string)
  end
end

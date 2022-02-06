# frozen_string_literal: true

require 'airborne'
require 'spec_helper'

Airborne.configure do |config|
  config.base_url = 'https://restful-booker.herokuapp.com'
end

RSpec.describe 'Get Booking Ids' do
  it 'should return all booking ids' do
    get '/booking'
    expect_status '200'
    expect_json_types(:array)
  end

  it 'should return booking id by name' do
    get '/booking', { params: { firstname: 'Sally', lastname: 'brown' } }
    expect_status '200'
    expect_json_sizes(1)
  end
end

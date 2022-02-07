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
    # arrange
    checkin_date = Time.new.strftime('%Y-%m-%d')
    checkout_date = Time.now.strftime('%Y-%m-%d')
    body = { firstname: 'test',
             lastname: 'automation',
             totalprice: 500,
             depositpaid: true,
             bookingdates: { checkin: checkin_date, checkout: checkout_date },
             additionalneeds: 'Breakfast' }

    post '/booking', body, { content_type: 'application/json', accept: 'application/json' }
    @booking_id = json_body[:bookingid]

    # act
    get '/booking', { params: { firstname: 'test', lastname: 'automation' } }

    # assert
    expect_status '200'
    expect_json_sizes(1)
  end
end

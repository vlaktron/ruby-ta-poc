# frozen_string_literal: true

require 'airborne'
require 'spec_helper'

Airborne.configure do |config|
  config.base_url = 'https://restful-booker.herokuapp.com'
end

RSpec.describe 'delete a booking' do
  before do
    post '/auth', { username: 'admin', password: 'password123' }, { content_type: 'application/json' }
    @token = json_body[:token]
  end

  before(:each) do
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
  end

  it 'should delete the booking with valid token' do
    delete "/booking/#{@booking_id}", {}, { Cookie: "token=#{@token}" }
    expect_status '201'
  end

  it 'should fail with invalid token' do
    delete "/booking/#{@booking_id}", {}, { Cookie: 'token=blah' }
    expect_status '403'
  end
end

# frozen_string_literal: true

require 'json'

checkin_date = Time.new.strftime('%Y-%m-%d')
checkout_date = Time.now.strftime('%Y-%m-%d')
body = { firstname: 'test',
         lastname: 'automation',
         totalprice: 500,
         depositpaid: true,
         bookingdates: { checkin: checkin_date, checkout: checkout_date },
         additionalneeds: 'Breakfast' }

puts JSON.generate(body).to_s

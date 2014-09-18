require 'bunny'
require 'multi_json'

#------------------------------------------------------------------------------
# Overview
#
# This script will:
# 1.) set host to localhost unless ENV[MB_HOST] is not nil
# 2.) set port to 5672      unless ENV[MB_PORT] is not nil
# 3.) use a prefetch of 1
# 4.) use acknowledgements
# 5.) use durable exchanges
# 6.) use persistent messages
# 7.) use publisher confirms
# 8.) investigate the need for/use of correlation identifiers
#     especially as they can apply to job identifiers and
#     PREMIS event identifiers
# 9.) use JSON for the payload
# 10.) set the content type and content encoding headers
#
# references:
#  http://www.rabbitmq.com/tutorials/amqp-concepts.html
#  http://rubybunny.info/articles/getting_started.html
#  http://www.rabbitmq.com/blog/2011/02/10/introducing-publisher-confirms/
#
#
# further concepts to explore:
#  - vhosts
#  - authentication
#  - TLS
#------------------------------------------------------------------------------
require "bunny"

host  = (ENV['MB_HOST']  || 'localhost')
port  = (ENV['MB_PORT']  || 5672)
queue = (ENV['MB_QUEUE'] || 'test_queue')

conn = Bunny.new(host: host, port: port )
conn.start

ch = conn.create_channel

q = ch.queue(queue, durable: true)

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

q.publish(msg, :persistent => true)
puts " [x] Published #{msg}"

conn.close

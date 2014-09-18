require 'bunny'
require 'multi_json'

# Overview
#
# This script will:
# 1.) set host to localhost unless ENV[AMQP_HOST] is not nil
# 2.) set port to 5672      unless ENV[AMQP_PORT] is not nil
# 3.) use a prefetch of 1
# 4.) use acknowledgements
# 5.) use durable exchanges
# 6.) use persistent messages
# 7.) investigate the need for/use of correlation identifiers
#     especially as they can apply to job identifiers and
#     PREMIS event identifiers
# 8.) use JSON for the payload
# 9.) set the content type and content encoding headers

# references:
#  http://www.rabbitmq.com/tutorials/amqp-concepts.html
#  http://rubybunny.info/articles/getting_started.html
#
#
# further concepts to explore:
#  - vhosts
#  - authentication
#  - TLS
#


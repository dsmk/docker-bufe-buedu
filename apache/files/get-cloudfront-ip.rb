#!/usr/bin/ruby
#
#
#require 'open-uri'
require 'json'

#url = 'https://ip-ranges.amazonaws.com/ip-ranges.json'
fname = "/tmp/ip-ranges.json"
buffer = open(fname).read
result = JSON.parse(buffer)

print "# CloudFront IP addresses\n"
result['prefixes'].each do |elem|
  #print "#{elem}\n"
  if elem['service'] == 'CLOUDFRONT'
    #print "set_real_ip_from #{elem['ip_prefix']} ;\n"
    print "#{elem['ip_prefix']}\n"
  end
end

# At the end print our standard footer
#
#print "\n# Set VPC subnet as trusted\n10.0.0.0/8\n"
#print "\n# Set VPC subnet as trusted\nset_real_ip_from 0.0.0.0/0;\n"
#print "\n# Set the header we are looking at\nreal_ip_header X-Forwarded-For ;\n"
#print "\n# Ignore all trusted IPs\nreal_ip_recursive on ;\n"


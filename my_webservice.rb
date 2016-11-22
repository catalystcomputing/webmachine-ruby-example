#!/usr/bin/ruby

require 'webmachine'

# Define a resource which we will bind to an endpoint
class PersonResource < Webmachine::Resource
  def resource_exists?
    case request.path_info[:person_name]    # Extract person_name from URI
    when 'peter', 'rob'                     # The people in the organisation
      true                                  # Resource exists - continue processing
    else
      false                                 # Resource doesn't exist - return 404 to client
    end
  end

  def to_html
   '<html><head></head><body>Hello, person!</body></html>'
  end
end

my_webservice = Webmachine::Application.new do |ws|
  ws.routes do
    add ['people', :person_name], PersonResource  # Bind /people/{person_name} to Person resource
  end
  ws.configure do |config|
    config.ip = '0.0.0.0'     # Bind web service to any adapter
    config.port = 8008        # and port 8008
  end
end

my_webservice.run

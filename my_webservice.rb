#!/usr/bin/ruby

require 'webmachine'
require 'cgi'
require 'active_support'
require 'active_support/core_ext/hash/conversions'
require 'json'

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

  def content_types_provided
    [
      ['text/html', :to_html],
      ['application/json', :to_json],
      ['application/xml', :to_xml]
      
    ]
  end

  def to_html
    escaped_person_name = CGI.escapeHTML(request.path_info[:person_name])
   "<html><head></head><body>Hello, #{escaped_person_name}!</body></html>"
  end

  def to_json
    { :name => request.path_info[:person_name] }.to_json
  end

  def to_xml
    { :name => request.path_info[:person_name] }.to_xml(:root => 'person')
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

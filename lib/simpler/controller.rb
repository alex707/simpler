require_relative 'view'

module Simpler
  class Controller

    CONTENT_TYPES = { xml: 'text/xml', plain: 'text/plain', html: 'text/html' }.freeze

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new

      save_input_params(env)
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      send(action)
      write_response

      set_default_headers
      @response.finish
    end

    def params
      @request.params
    end

    def headers
      @response.headers
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers(format = :html)
      content_type = CONTENT_TYPES[format]
      @response.headers['Content-Type'] ||= content_type if content_type
    end

    def save_input_params(env)
      if env['simpler.params']
        @request.params.merge!(env['simpler.params'])
      end
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(template)
      if template.is_a?(Hash)
        template.each do |k, v|
          @request.env['simpler.format'] = k
          @request.env['simpler.content'] = v
        end
      else
        @request.env['simpler.template'] = template
      end

      set_default_headers(@request.env['simpler.format'])
    end

    def status(code)
      @response.status = code
    end
  end
end

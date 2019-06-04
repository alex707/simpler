require 'erb'
require_relative 'view/text_html'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = nil
      if content
        template = content
      else
        view = content_type.split('/').map(&:capitalize).join.to_sym
        type = View.constants.include?(view) ? View.const_get(view) : TextHtml
        template = type.new(controller.name, action, template()).render()
      end

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def content_type
      @env['simpler.controller'].response.header['Content-Type']
    end

    def content
      @env['simpler.content']
    end

    def format
      @env['simpler.format']
    end

  end
end

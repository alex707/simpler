require 'erb'
require_relative 'view/html_rendering'
require_relative 'view/xml_rendering'
require_relative 'view/plain_rendering'

module Simpler
  class View

    RENDERING_CLASSES = { xml: XMLRendering, plain: PlainRendering, html: HTMLRendering }.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      rendering_class.new(@env).render(binding)
    end

    private

    def rendering_class
      RENDERING_CLASSES[format || :html]
    end

    def format
      @env['simpler.format']
    end

  end
end

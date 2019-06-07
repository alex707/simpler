module Simpler
  class View
    class HTMLRendering

      VIEW_BASE_PATH = 'app/views'.freeze

      def initialize(env)
        @env = env
      end

      def render(binding)
        template = nil
        if content
          template = content
        else
          path = template() || [controller.name, action].join('/')
          template_path = Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
          template = File.read(template_path)
        end

        ERB.new(template).result(binding)
      end

      private

      def content
        @env['simpler.content']
      end

      def controller
        @env['simpler.controller']
      end

      def action
        @env['simpler.action']
      end

      def template
        @env["simpler.template"]
      end

    end
  end
end

module Simpler
  class View
    class TextHtml

      def initialize(controller, action, template)
        @controller = controller
        @action = action
        @template = template
      end

      def render
        path = @template || [@controller, @action].join('/')
        template_path = Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
        File.read(template_path)
      end

    end
  end
end

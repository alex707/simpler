module Simpler
  class View
    class TextPlain

      def initialize(_controller, _action, template)
        @controller = _controller
        @action = _action
        @template = template
      end

      def render
        File.read(@template)
      end

    end
  end
end

module Simpler
  class View
    class PlainRendering

      def initialize(env)
        @env = env
      end

      def render(binding)
        ERB.new(content).result(binding)
      end

      private

      def content
        @env['simpler.content']
      end

    end
  end
end

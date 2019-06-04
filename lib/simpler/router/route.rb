module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        rule = @path.gsub(/\/:.+?(\/|\z)/, '\/(.+)\/').chomp('\/') + '$'
        rule = Regexp.new(rule)
        parsed = rule.match(path)

        if parsed && parsed.to_a[1..-1].any?
          keys = rule.match(@path).to_a[1..-1]
          keys = keys.map { |k| k.tr(':', '') }
          keys.zip(parsed.to_a[1..-1]) { |k, v| @params[k] = v }
        end

        @method == method && parsed
      end

    end
  end
end

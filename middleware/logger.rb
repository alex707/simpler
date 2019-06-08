require 'logger'

# logging
class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    response = @app.call(env)
    @logger.info(message(env))
    response
  end

  def message(env)
    controller = env['simpler.controller']
    if controller
      <<~LOG

        Request:    #{env['REQUEST_METHOD']} #{env['PATH_INFO']}
        Handler:    #{controller&.name}##{env['simpler.action']}
        Parameters: #{controller&.params}
        Response:   #{env['simpler.template']}
                    #{controller&.response&.status}
                    #{controller&.response&.content_type}
      LOG
    else
      <<~LOG

        Request:    #{env['REQUEST_METHOD']} #{env['PATH_INFO']}
        Response:   #{}
      LOG
    end
  end
end

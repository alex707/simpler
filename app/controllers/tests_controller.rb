class TestsController < Simpler::Controller

  def index
    # render 'tests/list'

    # render plain: "Plain text response\n"

    # headers['Content-Type'] = 'text/html'
    # render plain: "Plain text response!\n"
    # status 201


    xml = <<~XML_STR
      <note>
        <to>Tove</to>
        <from>Jani</from>
        <heading>Reminder</heading>
        <body>Don't forget me this weekend!</body>
      </note>
    XML_STR
    render xml: xml
  end

  def create

  end

  def show
    puts "params:#{params}"
    @test = Test.where(id: params[:id]).first.inspect
  end

end

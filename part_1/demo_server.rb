require 'sinatra/base'

require 'status_observer'
require 'my_backend_process'

class DemoServer < Sinatra::Base

  set :observer, StatusObserver.new(self)
  set :backend_process, MyBackendProcess.new
  set :connections, []

  get '/stream', :provides => 'text/event-stream' do
    stream :keep_open do |out|
      settings.connections << out
      out.callback { settings.connections.delete(out) }
    end
  end

  post '/run' do
    settings.backend_process.async.run
    204 #response without body
  end

  get '/' do
    content = <<-EOC.gsub(/^ {6}/, '')
      <html>
        <head>
          <title>Part 1: Status to Web</title>
        </head>
        <body>
          <input type="button" id="btn_run" value="Run Backend Process"> 
          <pre id='status_messages'></pre>

          <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
          <script type="text/javascript">
            $('#btn_run').click(function () {
              $.post('/run');
            });

            var es = new EventSource('/stream');
            es.addEventListener('status_event', function(e) {
              $('#status_messages').append(e.data + '\\n')
            }, false);
          </script>
        </body>
      <html>
    EOC
  end

end
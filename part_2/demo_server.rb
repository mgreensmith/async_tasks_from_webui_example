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
    erb :index
  end

end
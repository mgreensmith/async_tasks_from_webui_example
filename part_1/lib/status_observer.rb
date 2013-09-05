require 'celluloid/autostart'

class StatusObserver
  include Celluloid
  include Celluloid::Notifications

  def initialize(server)
    @server = server
    subscribe "status_event", :status_event
  end

  def status_event(*args)
    stream_event(*args)
  end

  private
    def stream_event(*args)
      @server.settings.connections.each { |out| out << "event: #{args[0].to_s}\ndata: #{args[1]}\n\n" }
    end
end

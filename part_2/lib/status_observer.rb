require 'celluloid/autostart'

class StatusObserver
  include Celluloid
  include Celluloid::Notifications

  def initialize(server)
    @server = server
    subscribe "status_event", :status_event
  end

  def status_event(*args)
    puts "StatusObserver received status_event message: #{args[1]}"
    @server.settings.status_messages << args[1]
    @server.settings.connections.each { |out| out << "event: #{args[0].to_s}\ndata: #{args[1]}\n\n" }
  end
end

require 'celluloid/autostart'

class StatusObserver
  include Celluloid
  include Celluloid::Notifications

  def initialize(server)
    @server = server
    subscribe "status_event", :status_event
    subscribe "state_change_event", :state_change_event
    subscribe "completion_percent_event", :completion_percent_event
  end

  def status_event(*args)
    puts "StatusObserver received status_event message: #{args[1]}"
    @server.settings.status_messages << args[1]
    broadcast_event_to_connected_clients(*args)
  end

  def state_change_event(*args)
    puts "StatusObserver received state_change_event: #{args[1]}"
    @server.settings.backend_process_state = args[1]
    broadcast_event_to_connected_clients(*args)
  end

  def completion_percent_event(*args)
    puts "StatusObserver received completion_percent_event: #{args[1]}"
    @server.settings.backend_process_completion_percent = args[1]
    broadcast_event_to_connected_clients(*args)
  end

  def broadcast_event_to_connected_clients(*args)
    @server.settings.connections.each { |out| out << "event: #{args[0].to_s}\ndata: #{args[1]}\n\n" }
  end
end

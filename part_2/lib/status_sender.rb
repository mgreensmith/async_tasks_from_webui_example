require 'celluloid/autostart'

class StatusSender
  include Celluloid
  include Celluloid::Notifications

  def initialize(klass)
    @class = klass
  end

  def send_status(message)
    puts "StatusSender publishing message from #{@class.class.name}: #{message}"
    publish("status_event", "#{Time.now} #{@class.class.name}: #{message}")
  end

  def send_state_change(message)
    puts "StatusSender publishing message from #{@class.class.name}: #{message}"
    publish("state_change_event", "#{message}")
  end
end

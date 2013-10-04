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
end

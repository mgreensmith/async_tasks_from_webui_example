require 'celluloid/autostart'
require 'status_sender'

class MyBackendProcess
  include Celluloid

  attr_reader :status

  def initialize
    @status = 'idle'
    @sender = StatusSender.new(self)
  end

  def run
    change_status('run method invoked, initializing')
    sleep 1
    change_status('doing a thing')
    sleep 5
    change_status('doing a second thing')
    sleep 5
    change_status('completed ALL THE THINGS!')
    sleep 1
    change_status('idle')
  end

  private

    def change_status(new_status)
      @status = new_status
      @sender.send_status(@status)
    end
end
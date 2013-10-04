require 'celluloid/autostart'
require 'status_sender'

class MyBackendProcess
  include Celluloid

  attr_reader :status

  def initialize
    @state = 'idle'
    @sender = StatusSender.new(self)
  end

  def run
    change_state('running')
    report_status('run method invoked')
    sleep 1
    report_status('doing a thing')
    sleep 1
    report_status('doing a second thing')
    sleep 1
    report_status('completed ALL THE THINGS!')
    change_state('idle')
  end

  private

    def change_state(new_state)
      @state = new_state
      @sender.send_state_change(@state)
    end

    def report_status(new_status)
      @sender.send_status(new_status)
    end
end
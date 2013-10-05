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
    report_completion_percent 0
    report_status('run method invoked')
    sleep 1
    report_status('doing a thing')
    report_completion_percent 33
    sleep 1
    report_status('doing a second thing')
    report_completion_percent 66
    sleep 1
    report_status('completed ALL THE THINGS!')
    report_completion_percent 100
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

    def report_completion_percent(new_percent)
      @sender.send_completion_percent(new_percent)
    end
end
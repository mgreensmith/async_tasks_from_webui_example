# bundle exec rackup -s thin

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'demo_server'
run DemoServer
# bundle exec rackup -s thin

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/server')

require 'demo_server'
run DemoServer
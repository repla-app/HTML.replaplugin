#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require_relative 'bundle/bundler/setup'
require 'repla'
require 'listen'

require_relative 'lib/controller'

file = ARGF.file unless ARGV.empty?

file_path = File.expand_path(file)
path = File.expand_path(File.dirname(file))

window = Repla::Window.new
window.root_access_directory_path = path
controller = Repla::HTML::Controller.new(window, file_path)

listener = Listen.to(path, only: /(\.html$)|(\.css$)|(\.js$)/) do |_modified, _added, _removed|
  File.open(file) do |_f|
    controller.file = file
  end
end

listener.start

trap('SIGINT') do
  exit
end

sleep

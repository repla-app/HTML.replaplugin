#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby --disable-gems

require_relative 'bundle/bundler/setup'
require 'repla'
# One of the dependencies of `listen` assumes gems is available, so we re-add
# it here
require 'rubygems'
require 'listen'

require_relative 'lib/controller'

file = ARGF.file unless ARGV.empty?

file_path = File.expand_path(file)
path = File.expand_path(File.dirname(file))

window = Repla::Window.new
window.root_access_directory_path = path
controller = Repla::HTML::Controller.new(file_path, window)

globs = /(\.html$)|(\.css$)|(\.js$)/
listener = Listen.to(path, only: globs) do |_modified, _added, _removed|
  File.open(file) do |_f|
    controller.file = file
  end
end

listener.start

trap('SIGINT') do
  exit
end

sleep

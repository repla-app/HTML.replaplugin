#!/usr/bin/env ruby

require 'minitest/autorun'
require 'Shellwords'

require_relative '../bundle/bundler/setup'
require 'repla'

require_relative 'lib/test_constants'
require_relative '../lib/controller'

# Test controller
class TestController < Minitest::Test
  def test_controller
    window = Repla::Window.new
    controller = Repla::HTML::Controller.new(TEST_HTML_FILE, window)

    title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
    assert_equal(TEST_HTML_TITLE, title)

    # Change the title
    new_title = 'Changed'
    refute_equal(title, new_title)
    window.do_javascript("document.title = '#{new_title}'")
    title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
    assert_equal(new_title, title)

    # Confirm refresh changes it back
    controller.reload
    title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
    assert_equal(TEST_HTML_TITLE, title)
    window.close
  end
end

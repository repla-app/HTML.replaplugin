#!/usr/bin/env ruby

require "test/unit"
require 'Shellwords'

require_relative '../bundle/bundler/setup'
require 'repla'

require_relative "lib/test_constants"
require_relative "../lib/controller"

class TestController < Test::Unit::TestCase

  def test_controller
    window = Repla::Window.new
    controller = Repla::HTML::Controller.new(window, TEST_HTML_FILE)

    title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
    assert_equal(title, TEST_HTML_TITLE, "The title should equal the test html title.")

    controller.file = TEST_HTML_FILE_TWO
    title_two = window.do_javascript(TEST_TITLE_JAVASCRIPT)    
    assert_equal(title_two, TEST_HTML_TITLE_TWO, "The second title should equal the second test html title.")

    window.close
  end

end

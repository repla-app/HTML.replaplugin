#!/usr/bin/env ruby

require "test/unit"

require_relative "lib/test_constants"
require_relative '../bundle/bundler/setup'
require 'repla/test'
require Repla::Tests::REPLA_FILE
require Repla::Tests::TEST_HELPER_FILE

class TestPlugin < Test::Unit::TestCase

  def setup
    Repla::load_plugin(TEST_HTML_PLUGIN_PATH)
  end

  def teardown
    # window.close
    Repla::Tests::Helper::quit
    Repla::Tests::Helper::confirm_dialog
    assert(!Repla::Tests::Helper::is_running, "The application should not be running.")
  end

  def test_load_html_file
    Repla::load_plugin(TEST_HTML_PLUGIN_PATH)
    Repla::run_plugin(TEST_PLUGIN_NAME, TEST_HTML_PLUGIN_PATH, [TEST_HTML_FILE])

    sleep Repla::Tests::TEST_PAUSE_TIME # Give the plugin time to finish running

    window_id = Repla::window_id_for_plugin(TEST_PLUGIN_NAME)
    window = Repla::Window.new(window_id)

    title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
    assert_equal(title, TEST_HTML_TITLE, "The title should equal the test html title.")
  end

  # TODO Pass to stdin of plugin and test its title
  # def test_load_html_from_stdin
  #   Repla::plugin_read_from_standard_input(TEST_PLUGIN_NAME, TEST_HTML_FILE)
  # end

  # TODO Test changes to the HTML files are updated

end



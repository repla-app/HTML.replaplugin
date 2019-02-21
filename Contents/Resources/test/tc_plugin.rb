#!/usr/bin/env ruby

require 'test/unit'

require_relative 'lib/test_constants'
require_relative '../bundle/bundler/setup'
require 'repla/test'
require Repla::Test::REPLA_FILE
require Repla::Test::HELPER_FILE

# Test plugin
class TestPlugin < Test::Unit::TestCase
  def setup
    Repla.load_plugin(TEST_HTML_PLUGIN_PATH)
  end

  def teardown
    # window.close
    Repla::Test::Helper.quit
    assert(!Repla::Test::Helper.app_running?)
  end

  def test_load_html_file
    Repla.load_plugin(TEST_HTML_PLUGIN_PATH)
    Repla.run_plugin(TEST_PLUGIN_NAME, TEST_HTML_PLUGIN_PATH, [TEST_HTML_FILE])

    sleep Repla::Test::TEST_PAUSE_TIME # Give the plugin time to finish running

    window_id = Repla.window_id_for_plugin(TEST_PLUGIN_NAME)
    window = Repla::Window.new(window_id)

    title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
    assert_equal(TEST_HTML_TITLE, title)
  end

  # TODO: Pass to stdin of plugin and test its title
  # def test_load_html_from_stdin
  #   Repla::plugin_read_from_standard_input(TEST_PLUGIN_NAME, TEST_HTML_FILE)
  # end

  # TODO: Test changes to the HTML files are updated
end

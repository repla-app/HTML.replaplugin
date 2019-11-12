#!usr/bin/env ruby

require 'minitest/autorun'

require_relative 'lib/test_constants'
require_relative '../bundle/bundler/setup'
require 'repla/test'
require Repla::Test::REPLA_FILE
require Repla::Test::HELPER_FILE

# Test plugin
class TestPlugin < Minitest::Test
  def setup
    Repla.load_plugin(TEST_HTML_PLUGIN_PATH)
  end

  def test_load_html_file
    Repla.load_plugin(TEST_HTML_PLUGIN_PATH)
    Repla.run_plugin(TEST_PLUGIN_NAME, TEST_HTML_PLUGIN_PATH, [TEST_HTML_FILE])

    window_id = nil
    Repla::Test.block_until do
      window_id = Repla.window_id_for_plugin(TEST_PLUGIN_NAME)
      !window_id.nil?
    end
    window = Repla::Window.new(window_id)

    title = nil
    Repla::Test.block_until do
      title = window.do_javascript(TEST_TITLE_JAVASCRIPT)
      title == TEST_HTML_TITLE
    end
    assert_equal(TEST_HTML_TITLE, title)
    window.close
  end

  # TODO: Pass to stdin of plugin and test its title
  # def test_load_html_from_stdin
  #   Repla::plugin_read_from_standard_input(TEST_PLUGIN_NAME, TEST_HTML_FILE)
  # end

  # TODO: Test changes to the HTML files are updated
end

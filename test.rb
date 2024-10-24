#!/usr/bin/env ruby

require "fileutils"

require './hedeby.rb'

def assert(condition)
  fail if not condition
end

state_dir = '/tmp/hedeby'
FileUtils.rm_rf state_dir
FileUtils.mkdir_p state_dir

unison(state: state_dir, command: 'echo asdf')

log_file = "#{state_dir}/unison.log"
assert File.exist? log_file
log_content = File.read log_file
assert log_content =~ /Started at/
assert log_content =~ /asdf/
assert log_content =~ /code 0/
assert log_content =~ /Finished/


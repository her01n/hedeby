require 'time'
require 'xdg'

xdg = XDG.new

$default_state = xdg.state_home + "hedeby"
$default_command = "unison heroin -batch"

def unison(state: $default_state, command: $default_command)
  FileUtils.mkdir_p state
  log_file = Pathname.new(state) + "unison.log"
  File.open(log_file, "w") do |file|
    file.write "Started at #{Time.now}\n"
    file.write "\n"
    IO.popen(command, "r") do |pipe|
      while line = pipe.gets do
        puts line
        file.puts line
      end
    end
    status = $?
    file.write "\n"
    if status.exited? then
      file.write "Process exited with code #{status.exitstatus}.\n"
    else
      file.write "Process terminated.\n"
    end
    file.write "Finished at #{Time.now}\n"
  end
end

def hedeby()
  while true
    begin
      unison()
    rescue => e
      puts e
    end
    sleep(30 * 60)
  end  
end


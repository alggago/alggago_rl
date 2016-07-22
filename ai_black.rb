require "xmlrpc/server"
require "xmlrpc/client"
require "socket"
require 'slave'

s = XMLRPC::Server.new(ARGV[0])
MAX_NUMBER = 16000

def is_port_open?(port)
  begin
    s = TCPServer.new("127.0.0.1", port)
  rescue Errno::EADDRINUSE
    return false
  end
  s.close
  return true
end

def is_windows?
  case RbConfig::CONFIG['host_os']
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    return true
  else
    return false
  end
end


ais = Dir.entries(".").map {|x| x if /^ai_[[:alnum:]]+.py$/.match(x)}.compact #null값 지운 배열 반환
    
    xml_port = 8000
    slaves = Array.new
    ais.each do |x|
      (xml_port..8080).to_a.each do |p|
        if is_port_open?(p)
          xml_port = p
          puts p
          break
        end
      end
      if is_windows?
        slaves << ChildProcess.build("python", x, xml_port.to_s).start
      else
        slaves << Slave.object(:async => true){ `python #{x} #{xml_port}` }
      end
      s2 = XMLRPC::Client.new("localhost", "/", xml_port)
    end

class MyAlggago
  def calculate(positions)

    #Codes here
    my_position = positions[0]
    your_position = positions[1]

    current_stone_number = 0
    index = 0
    min_length = MAX_NUMBER
    x_length = MAX_NUMBER
    y_length = MAX_NUMBER

    my_position.each do |my|
      your_position.each do |your|

        x_distance = (my[0] - your[0]).abs
        y_distance = (my[1] - your[1]).abs
        
        current_distance = Math.sqrt(x_distance * x_distance + y_distance * y_distance)

        if min_length > current_distance
          current_stone_number = index
          min_length = current_distance
          x_length = your[0] - my[0]
          y_length = your[1] - my[1]
        end
      end
      index = index + 1
    end

    #Return values
    message = positions.size
    stone_number = current_stone_number
    stone_x_strength = x_length * 5
    stone_y_strength = y_length * 5
    return [stone_number, stone_x_strength, stone_y_strength, message]

    #Codes end
  end

  def get_name
    "MY AI!!!"
  end
end

puts 'Im in here!!!!!!!!!!!!!!!!!!!!!!!!!!!'
s.add_handler("alggago", MyAlggago.new)
s.serve

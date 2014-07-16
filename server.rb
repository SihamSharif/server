#!/usr/bin/ruby
require 'socket'
require 'net/http'


puts "Starting up server..."


server = TCPServer.new(2000)
counter = 0

while (session = server.accept)

 Thread.start do

	 counter += 1

	 puts "Connection No : #{counter}"
   puts "log: Connection from #{session.peeraddr[2]} at #{session.peeraddr[3]}"
   puts "log: got input from client"

	request = session

	STDERR.puts request


	response =  "Server: Welcome #{session.peeraddr[2]}\n"

   while line = session.gets   # Read lines from the socket
	  puts line

		if line.include? "GET"
			break
		elsif line.include? "POST"
			break
		end

   end

	 session.print "HTTP/1.1 200 OK\r\n" +
			              "Content-Type: text/plain\r\n" +
			              "Content-Length: #{response.bytesize}\r\n" +
			              "Connection: close\r\n"

	 # Print a blank line to separate the header from the response body,
	 # as required by the protocol.
	 session.print "\r\n"

	 session.print response

	# session.puts "<html><head><title>JMeter</title></head><body>"
	# session.puts "Server: Welcome #{session.peeraddr[2]}\n"
	#
    puts "log: sending goodbye"
    session.puts "Server: Goodbye"
	#
	#
	#  session.puts "</body></html>"
	 session.close
 end  #end thread conversation
end   #end loop
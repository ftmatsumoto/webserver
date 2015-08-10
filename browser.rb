require 'socket'
require 'json'

host = 'localhost'
port = 2000

# This is the HTTP request we send to fetch a file
loop do
	print "Digite GET ou POST:"
	@method = gets.chomp
	break if @method == 'GET' || @method == 'POST'
end

if @method == 'GET'
	request = "GET /index.html HTTP/1.0\r\n\r\n"	
elsif @method == 'POST'
	print "\rPlease enter a name: "
	name = gets.chomp
	print "\rPlease enter an email address: "
	email = gets.chomp
	hash = {:user => {:name => name, :email => email} }
	json_hash = hash.to_json
	request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{json_hash.size}" \
			"\r\n\r\n#{json_hash}"
end

socket = TCPSocket.open(host,port)
socket.print(request)
response = socket.read
headers,body = response.split("\r\n\r\n", 2) 
print body
socket.close
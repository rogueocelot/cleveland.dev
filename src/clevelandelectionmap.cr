require "http"
require "ecr"
require "base64"
require "json"

# load the data for the 2025 primary election
# primaryinput2025 = File.read_lines("data/2025primary.txt")
#
# primary2025 = Hash(String, Hash(String, Int32)).new
#
# linecounter = 0
# truecounter = 0
# name = ""
# temp = Hash(String, Int32).new
# names = [] of String
# votes = [] of Int32
# primaryinput2025.each do |line|
#  if line.starts_with?("Precinct")
#    if truecounter != 0
#      (0..names.size - 1).each do |n|
#        temp[names[n]] = votes[n]
#      end
#    end

# reset
#    primary2025[name] = temp
#    temp = Hash(String, Int32).new
#    names = [] of String
#    votes = [] of Int32
# temp = Hash(String, Int32).new
#    linecounter = 0
#    name = line[-4..]
# convert name to format used in data
#    name = name.delete('-')
#    if name[0] == '0'
#      name = name.delete_at(0)
#    end
#  elsif linecounter == 1 || linecounter == 2 || line.starts_with?("Total") || line.starts_with?("Overvotes") || line.starts_with?("Undervotes") || line[-1] == '%'
#    linecounter += 1
#    next
#  elsif line[0].number?
#    votes << line.to_i
#  else
#    names << line
#  end
#
#  truecounter += 1
#  linecounter += 1
# end

# puts primary2025
# primary2025json = primary2025.to_json
primary2025json = File.read("data/primary2025.json")
# puts primary2025json

server = HTTP::Server.new do |context|
  case context.request.path
  when "/"
    context.response.redirect("/electionmap/2025primary")
  when "/electionmap/2025primary"
    io = IO::Memory.new
    render_page = ECR.embed "pages/primary2025.html.ecr", io
    context.response.content_type = "text/html"
    context.response.print(io)
  end
end

address = server.bind_tcp("0.0.0.0", 8080)
puts "listening on http://#{address}"
server.listen

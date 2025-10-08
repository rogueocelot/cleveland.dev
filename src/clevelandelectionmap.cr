require "http"
require "ecr"
require "base64"
require "json"

primary2025json = File.read("data/primary2025.json")
# puts primary2025json

server = HTTP::Server.new do |context|
  case context.request.path
  when "/"
    context.response.redirect("/electionmap/2025primary")
  when "/electionmap/"
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

require "http"
require "ecr"
require "base64"
require "json"

#prerender page for 2025 primary
primary2025json = File.read("data/primary2025.json")
p2025io = IO::Memory.new
p2025render_page = ECR.embed "pages/primary2025.html.ecr", p2025io

server = HTTP::Server.new do |context|
  case context.request.path
  when "/"
    context.response.redirect("/electionmap/2025primary")
  when "/electionmap/"
    context.response.redirect("/electionmap/2025primary")
  when "/electionmap/2025primary"
    context.response.content_type = "text/html"
    context.response.print(p2025io)
  end
end

address = server.bind_tcp("0.0.0.0", 8080)
puts "listening on http://#{address}"
server.listen

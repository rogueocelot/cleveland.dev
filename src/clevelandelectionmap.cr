require "http"
require "ecr"
require "base64"
require "json"

#prerender page for 2025 council primary
primary2025json = File.read("data/councilprimary2025.json")
councilprimary2025io = IO::Memory.new
render_page = ECR.embed "pages/councilprimary2025.html.ecr", councilprimary2025io

#prerender page for 2025 council general
councilgeneral2025json = File.read("data/councilgeneral2025.json")
councilgeneral2025io = IO::Memory.new
render_page = ECR.embed "pages/councilgeneral2025.html.ecr", councilgeneral2025io

server = HTTP::Server.new do |context|
  case context.request.path
  when "/"
    context.response.redirect("/electionmap/council/primary/2025")
  when "/electionmap/"
    context.response.redirect("/electionmap/council/primary/2025")
  when "/electionmap/council/"
    context.response.redirect("/electionmap/council/primary/2025")
  when "/electionmap/council/primary/2025"
    context.response.content_type = "text/html"
    context.response.print(councilprimary2025io)
  when "/electionmap/council/general/2025"
    context.response.content_type = "text/html"
    context.response.print(councilgeneral2025io)
  end
end

address = server.bind_tcp("0.0.0.0", 8080)
puts "listening on http://#{address}"
server.listen

class Application

  @@items = Item.all

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      item = Item.all.find{|item|
        item.name == req.path.split("/items/").last}
      if item.nil?
        resp.status = 400
        resp.write "Item not found"
      else
      resp.write "#{item.price}"
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end

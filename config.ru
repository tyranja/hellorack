class ToUpper
  # Our class will be initialize with another Rack app
  def initialize(app)
    @app = app
  end
 
  def call(env)
    # First, call `@app`
    status, headers, body  = @app.call(env)
 
    # Iterate through the body, upcasing each chunk
    upcased_body = body.map { |chunk| chunk.upcase }
 
    # Pass our new body on through
    [status, headers, upcased_body]
  end
end

class Hello
  def self.call(env)
    [ 200,                              # 200 indicates success
      {"Content-Type" => "text/plain"}, # the hash of headers
      ["Hello from Rack!"]              # we wrap the body in an Array so
                                        # that it responds to `each`
    ]
  end
end

use ToUpper   # Tell Rack to use our newly-minted middleware 
run Hello     # Tell Rack what to run our app

mix phx.new snipper
mix ecto.create
mix phx.gen.html Core User users name:string email:string token:string
mix ecto.migrate

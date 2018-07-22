FROM elixir:slim

RUN mkdir app
WORKDIR /app

# Configure required environment
ENV MIX_ENV prod

# Set and expose PORT environmental variable
ENV PORT ${PORT:-4000}
EXPOSE $PORT

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

# Copy all application files
COPY . .

# Generate secret key 
ENV SECRET_KEY_BASE="$(mix phx.gen.secret)"
# Compile the entire project
RUN mix phx.digest
RUN mix compile

# Run Ecto migrations and Phoenix server as an initial command
CMD mix do ecto.migrate, phx.server

# RUN mix local.rebar --force && mix local.hex --force
# ENV MIX_ENV=prod REPLACE_OS_VARS=true TERM=xterm
# RUN MIX_ENV=prod mix release --env=prod --executable
# 
# CMD ["mix", "release", "--env=prod", "--executable", "--verbose"]


FROM bitwalker/alpine-elixir-phoenix:latest

# Set exposed ports
ENV PORT=4000 

# Phx ENVs
ENV MIX_ENV=prod
ENV SECRET_KEY_BASE=s2r+3lWWZ2ATaTGhHJD5Adh43Ocf0I4kz1ET5ytnSi6uj70K1LkOonpTpIYyM7BU


# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN npm install --prefix ./assets

ADD . .

# Run frontend build, compile, and digest assets
RUN npm run deploy --prefix ./assets
RUN mix do compile, phx.digest

RUN mix release

CMD ["./_build/prod/rel/bingo_hall/bin/bingo_hall", "start"]
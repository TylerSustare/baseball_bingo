# syntax = docker/dockerfile:1.2

FROM bitwalker/alpine-elixir-phoenix:latest

# Set exposed ports
ENV PORT=4000 

# Phx ENVs
ENV MIX_ENV=prod

# secrets
RUN --mount=type=secret,id=_secret,dst=/etc/secrets/.secret cp /etc/secrets/.secret .secret
ADD .secret ./
RUN --mount=type=secret,id=_db_url,dst=/etc/secrets/.db_url cp /etc/secrets/.db_url .db_url
ADD .db_url ./

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN npm install --prefix ./assets

ADD . .

# Run frontend build, compile, and digest assets
RUN npm run deploy --prefix ./assets
RUN SECRET_KEY_BASE=$(cat .secret) mix do compile, phx.digest

RUN SECRET_KEY_BASE=$(cat .secret) mix release
RUN export SECRET_KEY_BASE=$(cat .secret)

# CMD ["./_build/prod/rel/bingo_hall/bin/bingo_hall", "start"]
RUN chmod +x ./entry.sh
ENTRYPOINT ["./entry.sh"]
FROM elixir:latest

RUN mix local.hex --force

RUN mix local.rebar --force

COPY mix.exs mix.lock config/ ./
COPY apps/calculator_core/mix.exs ./apps/calculator_core/
COPY apps/traveler/mix.exs ./apps/traveler/

RUN mix deps.get

RUN mix deps.compile

COPY . .

RUN mix compile

RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

RUN cd apps/traveler/assets && npm install
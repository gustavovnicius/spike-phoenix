FROM elixir:latest

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mix local.hex --force && mix local.rebar --force
RUN mkdir /opt/spike-phoenix
WORKDIR /opt/spike-phoenix
ADD . /opt/spike-phoenix
RUN mix do deps.get, deps.compile

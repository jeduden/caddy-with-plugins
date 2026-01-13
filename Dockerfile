FROM caddy:builder AS builder
RUN xcaddy build \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http \
  --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2
FROM caddy:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

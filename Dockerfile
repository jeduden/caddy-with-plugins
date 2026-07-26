# Pinned builder image so a given tag's contents are reproducible rather than
# resolved from whatever "latest" happened to be on the build date.
FROM caddy:2.11.4-builder AS builder

# Build Caddy at a pinned version with pinned plugin versions. Bump these
# deliberately; do not rely on build-time "latest" resolution.
RUN xcaddy build v2.11.4 \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http@v0.13.1 \
  --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@v0.13.1 \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2@v2.13.1

FROM caddy:2.11.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Record embedded versions as OCI image labels so consumers can tell what a tag
# contains without strings-ing the binary.
LABEL org.opencontainers.image.source="https://github.com/jeduden/caddy-with-plugins" \
      org.opencontainers.image.description="Caddy 2.11.4 with the crowdsec-bouncer and docker-proxy plugins" \
      io.caddy.version="v2.11.4" \
      io.caddy.plugin.caddy-crowdsec-bouncer="v0.13.1" \
      io.caddy.plugin.caddy-docker-proxy="v2.13.1"

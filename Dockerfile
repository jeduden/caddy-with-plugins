# Pin the builder image so builds use an explicit Caddy version instead of
# whatever "latest" happened to resolve to on the build date. This image sets
# CADDY_VERSION (v2.11.4), which xcaddy builds by default, so the base-image
# tag is the single source of truth for the Caddy version.
FROM caddy:2.11.4-builder AS builder

# Pin plugin versions explicitly; do not rely on build-time "latest" resolution.
RUN xcaddy build \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http@v0.13.1 \
  --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@v0.13.1 \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2@v2.13.1

FROM caddy:2.11.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Record the embedded plugin versions as OCI image labels so consumers can tell
# what an image contains via `docker inspect` without strings-ing the binary.
# The org.opencontainers.image.* labels are set by the CI publish workflow
# (docker/metadata-action), which would otherwise override any set here.
LABEL io.caddy.version="v2.11.4" \
      io.caddy.plugin.caddy-crowdsec-bouncer="v0.13.1" \
      io.caddy.plugin.caddy-docker-proxy="v2.13.1"

# caddy-with-plugins

Prebuilt [Caddy](https://caddyserver.com/) images with helpful plugins,
published to `ghcr.io/jeduden/caddy-with-plugins`.

## Embedded versions

Every tag is built from a [`Dockerfile`](./Dockerfile) with explicit Caddy,
plugin, and base-image versions, so the contents are determined by the pinned
versions below rather than by whatever `xcaddy` happened to resolve on the
build date. (The base images are pinned by version tag, not by digest, so this
is not bit-for-bit reproducibility — a Docker Hub tag re-push can change the
underlying layers.)

| Component | Version |
| --- | --- |
| Caddy | `v2.11.4` |
| [`hslatman/caddy-crowdsec-bouncer`](https://github.com/hslatman/caddy-crowdsec-bouncer) (`http` + `appsec`) | `v0.13.1` |
| [`lucaslorentz/caddy-docker-proxy/v2`](https://github.com/lucaslorentz/caddy-docker-proxy) | `v2.13.1` |

The same versions are recorded as OCI image labels, so you can tell what an
image contains without `strings`-ing the binary:

```console
$ docker inspect --format '{{json .Config.Labels}}' ghcr.io/jeduden/caddy-with-plugins:latest
```

Look for the `io.caddy.version`, `io.caddy.plugin.caddy-crowdsec-bouncer` and
`io.caddy.plugin.caddy-docker-proxy` labels.

## Bumping versions

Edit the pinned versions in [`Dockerfile`](./Dockerfile) — the two
`FROM caddy:...` tags (which also set the Caddy version `xcaddy` builds), the
three `--with` plugin refs, and the `io.caddy.*` `LABEL` values — then update
the table above. Publishing a new release tag builds and pushes the image via
[`.github/workflows/build.yml`](./.github/workflows/build.yml).

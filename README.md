# caddy-with-plugins

Prebuilt [Caddy](https://caddyserver.com/) images with helpful plugins,
published to `ghcr.io/jeduden/caddy-with-plugins`.

## Embedded versions

Every tag is built from a fully pinned [`Dockerfile`](./Dockerfile), so a
given tag's contents are reproducible rather than dependent on whatever
`xcaddy` happened to resolve on the build date.

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

Edit the pinned versions in [`Dockerfile`](./Dockerfile) (the `xcaddy build`
argument, both `--with` plugin refs, the two `FROM caddy:...` tags, and the
`LABEL` block) and update the table above. Publishing a new release tag builds
and pushes the image via [`.github/workflows/build.yml`](./.github/workflows/build.yml).

# .devcontainer

Non-root devcontainer for the Astro portfolio site. Runs as the `node` user (UID 1000).

## Verifying the build

Always use the devcontainer CLI to confirm the image builds and starts before opening a PR that touches this directory. Run both commands from the **repository root** (`/workspace` or wherever you cloned the repo), not from inside `.devcontainer/`. The CLI locates `devcontainer.json` automatically.

```bash
devcontainer build --workspace-folder .
devcontainer up --workspace-folder .
```

A successful build ends with `{"outcome":"success",...}`. A successful `up` ends with `{"outcome":"success",...,"description":"Dev container started successfully."}`. Any earlier exit is a failure.

## Files

| File                | Purpose                                                                     |
| ------------------- | --------------------------------------------------------------------------- |
| `Dockerfile`        | Base image (`node:lts`) + pnpm + Claude Code global install                 |
| `devcontainer.json` | Feature wiring, mounts, VS Code settings, firewall hook                     |
| `init-firewall.sh`  | Runs at container start (as root via sudoers) to lock down outbound traffic |

## Podman quirks

This project uses **Podman**, not Docker. Key differences:

- **`--userns=keep-id`** is in `runArgs`. This maps the Podman VM's UID 1000 to UID 1000 inside the container so the `node` user can write to the workspace bind mount. **Remove this flag if you switch to Docker** — Docker does not support `--userns=keep-id` and will reject it.

- **`PODMAN_USERNS`** is a _host-side_ Podman env var. Setting it inside `remoteEnv` (which sets vars inside the container) has no effect. If you ever need to pass it, export it in your shell before running `devcontainer up`.

- **`--cap-add=NET_ADMIN` and `--cap-add=NET_RAW`** are required for `init-firewall.sh` to configure iptables inside the container. Podman on macOS (via Podman Machine) supports these.

## pnpm setup

`pnpm setup` is intentionally **not** called in the Dockerfile. During the image build, `$SHELL` is not yet set (zsh is installed later by the `common-utils` feature), so `pnpm setup` fails with `ERR_PNPM_UNKNOWN_SHELL`. The equivalent effect is achieved via `ENV PNPM_HOME` and `ENV PATH` in the Dockerfile.

## Known non-issues

- The `IS_SANDBOX=1` env var is set even though the container runs as a non-root user. It is harmless and may be required by Claude Code's permission bypass mode.
- `POWERLEVEL9K_DISABLE_GITSTATUS=true` suppresses a slow git status check in the Oh My Zsh theme when the workspace is large.

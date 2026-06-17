# Agent Instructions — .devcontainer

Any agent that modifies files in this directory **must** verify that the dev container builds and starts successfully before considering the task complete.

## Required verification step

After making changes to any file in `.devcontainer/`, run:

```bash
devcontainer up --workspace-folder .. --remove-existing-container 2>&1
```

This command must exit without error. If it fails, fix the issue before finishing.

After a successful `devcontainer up`, verify that the `vscode` user has read/write access to all named volume mount points:

```bash
devcontainer exec --workspace-folder . bash -c "
  touch /home/vscode/.claude/.writetest && rm /home/vscode/.claude/.writetest && echo '.claude OK' || echo '.claude FAILED';
"
```

Both lines must print `OK`. 

## Common files and what to watch for

- **Dockerfile** — any change to base image, `RUN` steps, or `COPY` instructions can break the build. Verify layer by layer if needed.
- **devcontainer.json** — invalid JSON or unknown feature identifiers will cause `devcontainer up` to fail immediately.
- **devcontainer-lock.json** — this is auto-generated; do not edit it by hand. If it becomes stale after a `devcontainer.json` change, delete it and let `devcontainer up` regenerate it.

## Binary installation

Install binaries to `$HOME/.local/bin` (or another user-writable directory) and add it to `$PATH` in `.bashrc`. Do **not** write to `/usr/local/bin` or other root-owned paths — `postCreateCommand` runs as the `vscode` user and will fail with a permission error.

## Dockerfile

Be very reluctant to modify the Dockerfile. Prefer `post-install.sh` for tooling that changes over time (versioned CLIs, language runtimes, etc.). Only touch the Dockerfile if a dependency genuinely must be baked into the image layer (e.g., a system library that cannot be installed as a non-root user at runtime).

## Do not skip verification

Do not mark a task done based on a syntax check or linter alone. Only a successful `devcontainer up` confirms the container actually works.

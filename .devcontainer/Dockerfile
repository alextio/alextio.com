FROM ghcr.io/pnpm/pnpm:11
RUN pnpm runtime set node 22 -g

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    jq \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=dev
RUN useradd -m -s /bin/bash $USERNAME

WORKDIR /workspace
USER $USERNAME
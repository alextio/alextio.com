FROM node:lts

ARG TZ
ENV TZ="$TZ"

# Network/firewall tools, fzf, and git-delta — not covered by features
RUN apt-get update && apt-get install -y --no-install-recommends \
  man-db \
  fzf \
  delta \
  iptables \
  ipset \
  iproute2 \
  dnsutils \
  aggregate \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure node user has access to pnpm global dir
RUN mkdir -p /usr/local/share/pnpm/bin && \
  chown -R node:node /usr/local/share/pnpm

# Enable pnpm via corepack (bundled with Node.js).
# Do NOT run `pnpm setup` here — SHELL is not set during the Dockerfile build
# phase (it's defined by a later ENV instruction after features run), so pnpm
# setup would fail with ERR_PNPM_UNKNOWN_SHELL. PNPM_HOME and PATH are set via
# ENV below instead, which is equivalent.
RUN corepack enable pnpm

ARG USERNAME=node

# Persist shell history to mounted volume
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
  && mkdir /commandhistory \
  && touch /commandhistory/.bash_history \
  && chown -R $USERNAME /commandhistory \
  && echo "$SNIPPET" >> "/home/$USERNAME/.bashrc"

ENV DEVCONTAINER=true

RUN mkdir -p /workspace /home/node/.claude && \
  chown -R node:node /workspace /home/node/.claude

WORKDIR /workspace

USER node

ENV PNPM_HOME=/usr/local/share/pnpm
ENV PATH=$PATH:/usr/local/share/pnpm/bin:/home/node/.local/bin
ENV SHELL=/bin/zsh
ENV EDITOR=vi
ENV VISUAL=vi

RUN curl -fsSL https://claude.ai/install.sh | bash

COPY init-firewall.sh /usr/local/bin/
USER root
RUN chmod +x /usr/local/bin/init-firewall.sh && \
  mkdir -p /etc/sudoers.d && \
  echo "node ALL=(root) NOPASSWD: /usr/local/bin/init-firewall.sh" > /etc/sudoers.d/node-firewall && \
  chmod 0440 /etc/sudoers.d/node-firewall
USER node

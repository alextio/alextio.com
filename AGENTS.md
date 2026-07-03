This is an Astro personal portfolio site deployed to GitHub Pages.

@docs/common_instructions/commit-messages.md

---

## Workflow: Quick Changes

For typo fixes, style tweaks, or single-file edits:

1. **Make the change** in the appropriate files.
2. **Test it** — run `pnpm build` and confirm no type errors or build failures. For UI changes, run `pnpm dev` and manually verify the affected pages in a browser.
3. **Update documentation** — if the change affects how the codebase works, update the relevant `AGENTS.md` in the affected directory.
4. **Open a PR** — commit your changes and open a pull request against `main`.

---

## Workflow: Multi-Agent Feature Development

**REQUIRED for any task that adds or changes a page, component, or feature: you MUST NOT implement it directly. You MUST spawn the agents below using the Agent tool with `isolation: "worktree"`. Do not write implementation code yourself.**

Use this decision rule:

- Typo fix, single CSS tweak, one-line config change → Quick Changes workflow above
- Everything else (new page, new component, changed behavior, new route) → Multi-Agent workflow below, no exceptions

### How to invoke

Spawn each agent by calling the Agent tool with `isolation: "worktree"` and the contents of the corresponding prompt file. Pass the feature spec and the branch name from the previous agent as context.

**Agent 1 — Test Writer**

```
subagent_type: claude
isolation: worktree
prompt: <contents of docs/agent_instructions/test-writer.md> + feature spec from the user
```

Wait for Agent 1 to complete and report the branch name and which tests are failing.

**Agent 2 — Implementer**

```
subagent_type: claude
isolation: worktree
prompt: <contents of docs/agent_instructions/implementer.md> + branch name from Agent 1 + feature spec
```

Wait for Agent 2 to complete and confirm all tests pass.

**Agent 3 — Docs + PR**

```
subagent_type: claude
isolation: worktree
prompt: <contents of docs/agent_instructions/docs-pr.md> + branch name from Agent 2
```

Report the PR URL to the user when Agent 3 completes.

### Agent role summaries

| Agent           | File                                     | Responsibility                              |
| --------------- | ---------------------------------------- | -------------------------------------------- |
| 1 — Test Writer | `docs/agent_instructions/test-writer.md` | Write failing tests only, no implementation |
| 2 — Implementer | `docs/agent_instructions/implementer.md` | Make tests pass, no test modifications      |
| 3 — Docs + PR   | `docs/agent_instructions/docs-pr.md`     | Update docs, open the pull request          |
</content>

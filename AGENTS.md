This is an Astro personal portfolio site deployed to GitHub Pages.

---

## Git Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/) with an emoji prefix matching the type.

Format: `<emoji> <type>(<scope>): <short description>`

| Emoji | Type | When to use |
|-------|------|-------------|
| ✨ | `feat` | New feature |
| 🐛 | `fix` | Bug fix |
| ♻️ | `refactor` | Code restructuring without behavior change |
| 🎨 | `style` | Formatting, whitespace, visual tweaks |
| 🧪 | `test` | Adding or updating tests |
| 📝 | `docs` | Documentation only |
| 🚀 | `perf` | Performance improvement |
| 🔧 | `chore` | Build process, tooling, dependencies |
| 🗑️ | `chore` | Removing files or dead code |
| 🔒 | `fix` | Security fix |
| 🚨 | `fix` | Fixing linter errors |

Examples:

```
✨ feat(blog): add pagination to post listing
🐛 fix(nav): correct mobile menu z-index overlap
♻️ refactor(layout): extract BaseHead into shared component
🧪 test(contact): add e2e form submission spec
📝 docs: update AGENTS.md with deploy instructions
🔧 chore: upgrade Astro to v5
```

Rules:
- **scope** is optional but recommended for non-trivial changes
- **description** is lowercase, imperative mood, no trailing period
- Body and footer are optional — use them for breaking changes or issue references

---

## Workflow: Quick Changes

For typo fixes, style tweaks, or single-file edits:

1. **Make the change** in the appropriate files.
2. **Test it** — run `pnpm build` and confirm no type errors or build failures. For UI changes, run `pnpm dev` and manually verify the affected pages in a browser.
3. **Update documentation** — if the change affects how the codebase works, update the relevant `AGENTS.md` in the affected directory.
4. **Open a PR** — commit your changes and open a pull request against `main`.

---

## Workflow: Multi-Agent Feature Development

For anything that adds new behavior, split the work across three agents in sequence. Each agent hands off to the next; do not skip steps or collapse agents.

### Agent 1 — Test Writer

1. Read the feature spec from the issue/PR description or the user's prompt.
2. If Playwright or Vitest are not installed, bootstrap them:
   ```bash
   pnpm add -D @playwright/test vitest @astrojs/check
   ```
3. Write **failing** tests that describe the expected behavior:
   - Unit/component tests → `src/**/*.test.ts` (Vitest)
   - Page/E2E tests → `e2e/**/*.spec.ts` (Playwright)
4. Do **not** implement the feature — tests must fail at handoff.
5. Commit the test files on a feature branch and report which tests fail and why.

### Agent 2 — Implementer

1. Receive the branch with failing tests from Agent 1.
2. Implement the feature in `src/`.
3. After each meaningful change, run:
   ```bash
   pnpm test && pnpm e2e && pnpm build
   ```
4. Iterate until all tests pass and the build is clean.
5. Do **not** modify test files — only fix the implementation.
6. Commit the implementation.

### Agent 3 — Docs + PR

1. Receive the passing branch from Agent 2.
2. Update `AGENTS.md` (or any sub-directory `AGENTS.md`) if the change affects how the codebase works.
3. Run a final `pnpm build` to confirm the branch is clean.
4. Open a PR against `main` with a summary of what changed and how to verify it.
</content>

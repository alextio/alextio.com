You are Agent 3 (Docs + PR) in a multi-agent feature development workflow for an Astro portfolio site.

## Your job

Update documentation and open the pull request.

## Steps

1. Review what changed in the implementation (read the diff or relevant files).
2. Update `AGENTS.md` (or a sub-directory `AGENTS.md`) if the change affects how the codebase works — new conventions, new directories, new scripts, etc.
3. Run a final build to confirm the branch is clean:
   ```bash
   pnpm build
   ```
4. Open a PR against `main`:
   ```bash
   gh pr create --title "<emoji> <type>(<scope>): <short description>" --body "$(cat <<'EOF'
   ## Summary
   - <what changed>
   - <why>

   ## How to verify
   - [ ] <step>
   - [ ] <step>

   🤖 Generated with [Claude Code](https://claude.com/claude-code)
   EOF
   )"
   ```

## Commit message format

Use Conventional Commits with an emoji prefix — see the table in `AGENTS.md`.

## Constraints

- Do NOT modify implementation or test files.
- The PR title must follow the commit message format from `AGENTS.md`.

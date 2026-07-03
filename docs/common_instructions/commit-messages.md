## Git Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/) with an emoji prefix matching the type.

Format: `<emoji> <type>(<scope>): <short description>`

| Emoji | Type       | When to use                                |
| ----- | ---------- | ------------------------------------------ |
| ✨    | `feat`     | New feature                                |
| 🐛    | `fix`      | Bug fix                                    |
| ♻️    | `refactor` | Code restructuring without behavior change |
| 🎨    | `style`    | Formatting, whitespace, visual tweaks      |
| 🧪    | `test`     | Adding or updating tests                   |
| 📝    | `docs`     | Documentation only                         |
| 🚀    | `perf`     | Performance improvement                    |
| 🔧    | `chore`    | Build process, tooling, dependencies       |
| 🗑️    | `chore`    | Removing files or dead code                |
| 🔒    | `fix`      | Security fix                               |
| 🚨    | `fix`      | Fixing linter errors                       |

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

# Cursor Rules

This is my collection of rules for Cursor Agentic Coding. Its a mix of my own rules and some copied from [Awesome Cursor Rules](https://github.com/PatrickJS/awesome-cursorrules/tree/main). If you don't know what the rules are, learn more [here](https://docs.cursor.com/context/rules-for-ai).

## Installation

Requires [gum](https://github.com/charmbracelet/gum) and [jq](https://jqlang.org/). Will auto install these if you have Homebrew installed.

Simply run the following command in your project root.
  
```bash
curl -sL https://raw.githubusercontent.com/chand1012/cursorrules/refs/heads/main/install.sh -o /tmp/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh
```

## Rules

| Rule | Description |
|------|-------------|
| [clean_code.mdc](practice/clean_code.mdc) | Provides comprehensive guidelines for writing clean, maintainable, and well-structured code across any programming language. |
| [code_quality.mdc](practice/code_quality.mdc) | Defines specific guidelines for maintaining code quality, including rules about file changes, code preservation, and interaction patterns. |
| [database.mdc](practice/database.mdc) | Outlines best practices for database management, focusing on Prisma and Supabase integration patterns. |
| [gitflow.mdc](practice/gitflow.mdc) | Provides guidelines for using Git for managing code changes. |
| [repo.mdc](practice/repo.mdc) | Defines the project structure and setup instructions for a given project. **Should be adjusted per project.** |
| [go.mdc](languages/go.mdc) | Provides Go-specific coding standards and best practices for modern Go development. |
| [javascript.mdc](languages/javascript.mdc) | Details JavaScript best practices and patterns for modern web development. |
| [python.mdc](languages/python.mdc) | Specifies Python coding standards with focus on Flask and SQLite integration. |
| [rust.mdc](languages/rust.mdc) | Contains Rust programming guidelines and best practices. |
| [solidity.mdc](languages/solidity.mdc) | Provides Solidity-specific coding standards using Foundry and best practices for Ethereum smart contracts. |
| [godot.mdc](languages/godot.mdc) | Provides Godot-specific coding standards and best practices for modern Godot game development. |
| [typescript.mdc](languages/typescript.mdc) | Outlines TypeScript-specific coding standards and type system best practices. |
| [ecmascript.mdc](frameworks/ecmascript.mdc) | Provides guidelines for modern ECMAScript features and best practices. |
| [express.mdc](frameworks/express.mdc) | Details Express.js framework-specific patterns and best practices for Node.js web applications. |
| [fastapi.mdc](frameworks/fastapi.mdc) | Outlines FastAPI framework conventions and best practices for Python web APIs. |
| [htmx.mdc](frameworks/htmx.mdc) | Provides guidelines for using HTMX to create dynamic web applications with minimal JavaScript. |
| [nextjs.mdc](frameworks/nextjs.mdc) | Specifies Next.js framework conventions and best practices for React applications. |
| [react.mdc](frameworks/react.mdc) | Details React framework patterns and component design best practices. |
| [svelte.mdc](frameworks/svelte.mdc) | Outlines Svelte framework-specific patterns and reactive programming practices. |
| [tailwind.mdc](frameworks/tailwind.mdc) | Provides guidelines for using Tailwind CSS utility classes and design patterns. |
| [vue.mdc](frameworks/vue.mdc) | Details Vue.js framework conventions and component architecture best practices. |

## How I Wrote New Rules

Some of the rules I needed (mainly Go and Rust) were missing, so I had to make some new ones. My process was:

1. Ask [Grok](https://grok.com/) to do research on best practices for the language or framework.
2. Give it an example of a good rules file and tell it to use the research to make a new rules file.
3. Copy the rules into a new file.

And that's it! See the [prompts.md](prompts.md) file for the exact prompts I used.

## What Makes a Good Rules File?

The rules files should be a clear guideline. While you don't have to include as much detail as you would for a human developer, you should still be clear and verbose enough that an LLM can follow the instructions. For example "write good code" is not enough, and you should instead tell the LLM what makes code good.

## The Repo Rules

This is a special rules file (`repo.mdc`) that should be a source of truth for the entire repo. It should contain information about the project, including file structure, any non-standard coding practices, and an explanation of what the project does.

Here's an example.

```markdown
# Database Management Template

This is a template monorepo for managing database migrations and edge functions using Supabase and Deno. In a real project you should add a lot of detail to this file, as if you were explaining what the project is and what it does to a new developer.

## Directory Structure

- **docs/**: Documentation for the repository and development process.
- **supabase/**: Contains all Supabase-related configurations, migrations, and edge functions.
  - **supabase/migrations/**: Database migration scripts. Migration files should be named with a timestamp and description, e.g., `20240821194157_example_migration.sql`.
  - **supabase/functions/**: Deno edge functions.
    - **supabase/functions/example_function/index.ts**: Main entrypoint for the edge function.
    - **supabase/functions/_shared/**: Shared code used by multiple functions.
  - **supabase/seed.sql**: Seed data for local development and testing.
  - **supabase/config.toml**: Configuration for the local Supabase instance.
- **scripts/**: Scripts for development and testing (e.g., Deno scripts).
- **Justfile**: Command runner for common tasks. Run commands with `just <command>`.

## Code Style

### General Guidelines

- Follow DRY (Don't Repeat Yourself).
- Use meaningful names for variables and functions.
- Ensure code is readable by humans and machines.

### SQL

- Use spaces, not tabs.
- Use `snake_case` for table and column names.
- Use `enum` for values limited to a specific set.
- Use domains for data validation when necessary.
- Prefer `CREATE TABLE IF NOT EXISTS` over `CREATE TABLE`.
- Use SQL syntax compatible with your database system (this template assumes PostgreSQL).
```

## Converting to OpenHands

[OpenHands](https://docs.all-hands.dev/) is another LLM Agentic Coding tool similar to Cursor, however it has the ability to be added to an existing [GitHub Repo as a GitHub Action](https://docs.all-hands.dev/modules/usage/how-to/github-action), meaning it can create PRs from Issues without ever having to clone the repo locally. This can especially be useful for repos that are either short on development staff, or fixing bugs in a repo that devs either don't have time for or don't want to deal with.

OpenHands uses "[microagents](https://docs.all-hands.dev/modules/usage/prompting/microagents-repo)", which are effectively rules files. There is a `repo.md` file, which is basically the rules for the entire repo, from code style to any information about the project. These are stored in `.openhands/microagents`. The installer script will prompt you and ask if you want to copy the Cursor rules files into the OpenHands microagents directory, and convert it to a `repo.md` file.

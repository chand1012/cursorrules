# Cursor Rules

This is my collection of rules for Cursor Agentic Coding. Its a mix of my own rules and some copied from [Awesome Cursor Rules](https://github.com/PatrickJS/awesome-cursorrules/tree/main). If you don't know what the rules are, learn more [here](https://docs.cursor.com/context/rules-for-ai).

## How I Wrote New Rules

Some of the rules I needed (mainly Go and Rust) were missing, so I had to make some new ones. My process was:

1. Ask Grok to do research on best practices for the language.
2. Give it an example of a good rules file and tell it to use the research to make a new rules file.
3. Copy the rules into a new file.

And that's it!

## The Repo Rules

This is a special rules file that should be a source of truth for the entire repo. It should contain information about the project, including file structure, any non-standard coding practices, and an explanation of what the project does.

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

OpenHands uses "[microagents](https://docs.all-hands.dev/modules/usage/prompting/microagents-repo)", which are effectively rules files. There is a `repo.md` file, which is basically the rules for the entire repo, from code style to any information about the project. These are stored in `.openhands/microagents`. We have a helper script for copying the Cursor rules files into the OpenHands microagents directory, and converting it to a `repo.md` file. To use it, simply copy all the rules you want to your Cursor rules directory, make sure you've edited `repo.mdc` to contain accurate information, and run the script.

```bash
./rules-to-openhands.sh
```

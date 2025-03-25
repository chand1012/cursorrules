---
name: repo
type: repo
agent: CodeActAgent
---

# Clean Code Guidelines

## Constants Over Magic Numbers
- Replace hard-coded values with named constants
- Use descriptive constant names that explain the value's purpose
- Keep constants at the top of the file or in a dedicated constants file

## Meaningful Names
- Variables, functions, and classes should reveal their purpose
- Names should explain why something exists and how it's used
- Avoid abbreviations unless they're universally understood

## Smart Comments
- Don't comment on what the code does - make the code self-documenting
- Use comments to explain why something is done a certain way
- Document APIs, complex algorithms, and non-obvious side effects

## Single Responsibility
- Each function should do exactly one thing
- Functions should be small and focused
- If a function needs a comment to explain what it does, it should be split

## DRY (Don't Repeat Yourself)
- Extract repeated code into reusable functions
- Share common logic through proper abstraction
- Maintain single sources of truth

## Clean Structure
- Keep related code together
- Organize code in a logical hierarchy
- Use consistent file and folder naming conventions

## Encapsulation
- Hide implementation details
- Expose clear interfaces
- Move nested conditionals into well-named functions

## Code Quality Maintenance
- Refactor continuously
- Fix technical debt early
- Leave code cleaner than you found it

## Testing
- Write tests before fixing bugs
- Keep tests readable and maintainable
- Test edge cases and error conditions

## Version Control
- Write clear commit messages
- Make small, focused commits
- Use meaningful branch names 

# Code Quality Guidelines

## Verify Information
Always verify information before presenting it. Do not make assumptions or speculate without clear evidence.

## File-by-File Changes
Make changes file by file and give me a chance to spot mistakes.

## No Apologies
Never use apologies.

## No Understanding Feedback
Avoid giving feedback about understanding in comments or documentation.

## No Whitespace Suggestions
Don't suggest whitespace changes.

## No Summaries
Don't summarize changes made.

## No Inventions
Don't invent changes other than what's explicitly requested.

## No Unnecessary Confirmations
Don't ask for confirmation of information already provided in the context.

## Preserve Existing Code
Don't remove unrelated code or functionalities. Pay attention to preserving existing structures.

## Single Chunk Edits
Provide all edits in a single chunk instead of multiple-step instructions or explanations for the same file.

## No Implementation Checks
Don't ask the user to verify implementations that are visible in the provided context.

## No Unnecessary Updates
Don't suggest updates or changes to files when there are no actual modifications needed.

## Provide Real File Links
Always provide links to the real files, not x.md.

## No Current Implementation
Don't show or discuss the current implementation unless specifically requested.


# Database Best Practices

## Prisma Setup
- Use proper schema design
- Implement proper migrations
- Use proper relation definitions
- Configure proper connection
- Implement proper seeding
- Use proper client setup

## Prisma Models
- Use proper model naming
- Implement proper relations
- Use proper field types
- Define proper indexes
- Implement proper constraints
- Use proper enums

## Prisma Queries
- Use proper query optimization
- Implement proper filtering
- Use proper relations loading
- Handle transactions properly
- Implement proper pagination
- Use proper aggregations

## Supabase Setup
- Configure proper project setup
- Implement proper authentication
- Use proper database setup
- Configure proper storage
- Implement proper policies
- Use proper client setup

## Supabase Security
- Implement proper RLS policies
- Use proper authentication
- Configure proper permissions
- Handle sensitive data properly
- Implement proper backups
- Use proper encryption

## Supabase Queries
- Use proper query optimization
- Implement proper filtering
- Use proper joins
- Handle real-time properly
- Implement proper pagination
- Use proper functions

## Database Design
- Use proper normalization
- Implement proper indexing
- Use proper constraints
- Define proper relations
- Implement proper cascades
- Use proper data types

## Performance
- Use proper connection pooling
- Implement proper caching
- Use proper query optimization
- Handle N+1 queries properly
- Implement proper batching
- Monitor performance metrics

## Security
- Use proper authentication
- Implement proper authorization
- Handle sensitive data properly
- Use proper encryption
- Implement proper backups
- Monitor security issues

## Best Practices
- Follow database conventions
- Use proper migrations
- Implement proper versioning
- Handle errors properly
- Document schema properly
- Monitor database health 


# Go Best Practices

## Package and Import Statements
- Use meaningful package names that reflect their purpose (e.g., `auth`, `config`).
- Group imports in this order: standard library, third-party, then local packages, separated by blank lines.
- Avoid import cycles to maintain clean dependency graphs.

## Type System
- Use `struct` types to define complex data structures.
- Define `interface` types to specify behavior and enable polymorphism.
- Use type aliases sparingly for clarity (e.g., `type ID string`).
- Leverage Go’s built-in types (e.g., `map`, `slice`) and composite types effectively.
- Avoid unnecessary type conversions to maintain type safety.
- Use struct embedding for composition instead of inheritance.

## Naming Conventions
- Use `camelCase` for variable and function names (e.g., `getUser`).
- Use `PascalCase` for type names and exported identifiers (e.g., `UserService`).
- Use `ALL_CAPS` for constants (e.g., `MAX_RETRIES`).
- Be descriptive yet concise in naming (e.g., `userCount` over `cnt`).

## Code Organization
- Follow the standard Go project layout (e.g., `cmd/`, `pkg/`, `internal/`).
- Keep related code within the same package for cohesion.
- Use subdirectories for larger packages to organize functionality (e.g., `api/handlers`).

## Functions and Methods
- Keep functions short and focused on a single responsibility.
- Use named return values for clarity in complex functions (e.g., `func getData() (data string, err error)`).
- Avoid side effects in functions to improve predictability.

## Best Practices
- Follow the Go proverb: "A little copying is better than a little dependency."
- Use interfaces to define behavior and decouple components.
- Prefer composition over inheritance using embedding.
- Avoid unnecessary abstractions; prioritize simplicity.
- Use the `init` function sparingly for package initialization.
- Avoid global variables; if unavoidable, ensure they are thread-safe (e.g., with `sync.Mutex`).
- Be mindful of memory allocations; use profiling tools (e.g., `pprof`) to optimize performance.
- Use `gofmt` for consistent formatting and `go vet` for static analysis.

## Error Handling
- Always check errors explicitly (e.g., `if err != nil`).
- Use descriptive error messages for debugging (e.g., `errors.New("failed to open file")`).
- Consider error wrapping with `fmt.Errorf` and `%w` for context (e.g., `fmt.Errorf("query failed: %w", err)`).
- Use `defer` with `recover` to handle panics in critical sections (e.g., HTTP handlers).

## Concurrency
- Use goroutines for concurrent tasks (e.g., `go processData()`).
- Use channels for safe communication between goroutines (e.g., `ch := make(chan int)`).
- Avoid shared state when possible; prefer message passing via channels.

## Testing
- Write tests for all public functions using the `testing` package.
- Use table-driven tests for multiple test cases (e.g., `tests := []struct{...}`).
- Aim for high test coverage with `go test -cover`.

## Documentation
- Write doc comments for all exported identifiers (e.g., `// UserService handles user operations`).
- Follow the standard Go doc format, starting with the identifier name (e.g., `// Package auth provides...`).
- Include examples in doc comments when possible (e.g., `// Example: ...`).

## Patterns
- Use interfaces for dependency injection to improve testability.
- Implement the Repository pattern for data access (e.g., `UserRepository` interface).
- Use the Factory pattern for object creation (e.g., `NewUserService()`).


# JavaScript Best Practices

## Modern JavaScript Features
- Use ES modules with `import` and `export` statements  
- Utilize modern features like optional chaining (`?.`) and nullish coalescing (`??`)  
- Use `const` and `let` over `var` for better scoping  
- Implement async/await for asynchronous operations  
- Use arrow functions for concise syntax and lexical `this`  
- Leverage template literals for string interpolation  
- Use destructuring for cleaner object/array handling  

## Naming Conventions
- Use camelCase for variables and functions  
- Use PascalCase for classes  
- Use UPPER_CASE for constants  
- Use descriptive names with auxiliary verbs (e.g., `isLoading`, `hasError`)  
- Use consistent naming across the codebase  

## Code Organization
- Keep files focused and single-purpose  
- Use a consistent directory structure  
- Group related functionality together  
- Use barrel exports (index.js) for clean imports  
- Use absolute imports over relative when appropriate  

## Functions and Methods
- Keep functions small and focused  
- Handle errors appropriately  
- Document complex functions  
- Use parameter destructuring for cleaner APIs  
- Implement proper error boundaries  

## Best Practices
- Write tests for critical functionality  
- Use ESLint and Prettier for code consistency  
- Implement proper error handling  
- Use proper logging and debugging  
- Follow security best practices  
- Keep dependencies up to date  

## Performance
- Implement proper code splitting  
- Use lazy loading where appropriate  
- Optimize bundle size  
- Use proper caching strategies  
- Implement proper memoization  
- Monitor and optimize render performance  

## Testing
- Write unit tests for business logic  
- Implement integration tests for complex flows  
- Use proper testing libraries (Jest, Testing Library)  
- Write meaningful test descriptions  
- Test error cases and edge conditions  
- Maintain good test coverage  

## Documentation
- Write clear documentation  
- Use JSDoc for function documentation  
- Document complex algorithms  
- Keep README files up to date  
- Document configuration options  
- Use meaningful commit messages  

## Frameworks
- Choose appropriate frameworks for your needs  
- Follow framework-specific best practices  
- Keep up with framework updates  
- Use proper state management  
- Implement proper routing  
- Follow component best practices  


# Python Best Practices

## Project Structure
- Use src-layout with `src/your_package_name/`
- Place tests in `tests/` directory parallel to `src/`
- Keep configuration in `config/` or as environment variables
- Store requirements in `requirements.txt` or `pyproject.toml`
- Place static files in `static/` directory
- Use `templates/` for Jinja2 templates

## Code Style
- Follow Black code formatting
- Use isort for import sorting
- Follow PEP 8 naming conventions:
  - snake_case for functions and variables
  - PascalCase for classes
  - UPPER_CASE for constants
- Maximum line length of 88 characters (Black default)
- Use absolute imports over relative imports

## Type Hints
- Use type hints for all function parameters and returns
- Import types from `typing` module
- Use `Optional[Type]` instead of `Type | None`
- Use `TypeVar` for generic types
- Define custom types in `types.py`
- Use `Protocol` for duck typing

## Flask Structure
- Use Flask factory pattern
- Organize routes using Blueprints
- Use Flask-SQLAlchemy for database
- Implement proper error handlers
- Use Flask-Login for authentication
- Structure views with proper separation of concerns

## Database
- Use SQLAlchemy ORM
- Implement database migrations with Alembic
- Use proper connection pooling
- Define models in separate modules
- Implement proper relationships
- Use proper indexing strategies

## Authentication
- Use Flask-Login for session management
- Implement Google OAuth using Flask-OAuth
- Hash passwords with bcrypt
- Use proper session security
- Implement CSRF protection
- Use proper role-based access control

## API Design
- Use Flask-RESTful for REST APIs
- Implement proper request validation
- Use proper HTTP status codes
- Handle errors consistently
- Use proper response formats
- Implement proper rate limiting

## Testing
- Use pytest for testing
- Write tests for all routes
- Use pytest-cov for coverage
- Implement proper fixtures
- Use proper mocking with pytest-mock
- Test all error scenarios

## Security
- Use HTTPS in production
- Implement proper CORS
- Sanitize all user inputs
- Use proper session configuration
- Implement proper logging
- Follow OWASP guidelines

## Performance
- Use proper caching with Flask-Caching
- Implement database query optimization
- Use proper connection pooling
- Implement proper pagination
- Use background tasks for heavy operations
- Monitor application performance

## Error Handling
- Create custom exception classes
- Use proper try-except blocks
- Implement proper logging
- Return proper error responses
- Handle edge cases properly
- Use proper error messages

## Documentation
- Use Google-style docstrings
- Document all public APIs
- Keep README.md updated
- Use proper inline comments
- Generate API documentation
- Document environment setup

## Development Workflow
- Use virtual environments (venv)
- Implement pre-commit hooks
- Use proper Git workflow
- Follow semantic versioning
- Use proper CI/CD practices
- Implement proper logging

## Dependencies
- Pin dependency versions
- Use requirements.txt for production
- Separate dev dependencies
- Use proper package versions
- Regularly update dependencies
- Check for security vulnerabilities

Repository: MyProject
Description: A web application for task management

Directory Structure:
- src/: Main application code
- tests/: Test files
- docs/: Documentation

Setup:
- Run `npm install` to install dependencies
- Use `npm run dev` for development
- Run `npm test` for testing

Guidelines:
- Follow ESLint configuration
- Write tests for all new features
- Use TypeScript for new code

If adding a new component in src/components, always add appropriate unit tests in tests/components/.



# TypeScript Best Practices

## Type System
- Prefer interfaces over types for object definitions
- Use type for unions, intersections, and mapped types
- Avoid using `any`, prefer `unknown` for unknown types
- Use strict TypeScript configuration
- Leverage TypeScript's built-in utility types
- Use generics for reusable type patterns

## Naming Conventions
- Use PascalCase for type names and interfaces
- Use camelCase for variables and functions
- Use UPPER_CASE for constants
- Use descriptive names with auxiliary verbs (e.g., isLoading, hasError)
- Prefix interfaces for React props with 'Props' (e.g., ButtonProps)

## Code Organization
- Keep type definitions close to where they're used
- Export types and interfaces from dedicated type files when shared
- Use barrel exports (index.ts) for organizing exports
- Place shared types in a `types` directory
- Co-locate component props with their components

## Functions
- Use explicit return types for public functions
- Use arrow functions for callbacks and methods
- Implement proper error handling with custom error types
- Use function overloads for complex type scenarios
- Prefer async/await over Promises

## Best Practices
- Enable strict mode in tsconfig.json
- Use readonly for immutable properties
- Leverage discriminated unions for type safety
- Use type guards for runtime type checking
- Implement proper null checking
- Avoid type assertions unless necessary

## Error Handling
- Create custom error types for domain-specific errors
- Use Result types for operations that can fail
- Implement proper error boundaries
- Use try-catch blocks with typed catch clauses
- Handle Promise rejections properly

## Patterns
- Use the Builder pattern for complex object creation
- Implement the Repository pattern for data access
- Use the Factory pattern for object creation
- Leverage dependency injection
- Use the Module pattern for encapsulation 


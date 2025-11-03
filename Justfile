# Linting and checks

# Run markdownlint on all markdown files
lint:
    markdownlint -c .markdownlint.yaml -i .markdownlintignore "**/*.md"

# Run markdownlint with auto-fix (if supported)
lint-fix:
    markdownlint -c .markdownlint.yaml -i .markdownlintignore --fix "**/*.md"

# Run markdownlint on staged markdown files only (for pre-commit)
lint-staged:
    @STAGED_FILES=$$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.md$$'); \
    if [ -n "$$STAGED_FILES" ]; then \
        echo "$$STAGED_FILES" | xargs markdownlint -c .markdownlint.yaml -i .markdownlintignore; \
    else \
        echo "No staged markdown files to lint"; \
    fi

# Check commit message format (requires commitlint)
# Usage: just commitlint COMMIT_MSG_FILE=/path/to/commit-msg-file
commitlint COMMIT_MSG_FILE:
    @if [ -f "{{COMMIT_MSG_FILE}}" ]; then commitlint --edit "{{COMMIT_MSG_FILE}}"; else echo "Commit message file not found"; fi

# Run all pre-commit checks (lint staged files)
pre-commit:
    @just lint-staged

# Run all checks
check:
    @just lint

# Default target
default:
    @just check

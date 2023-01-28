export GOBIN := $(PWD)/bin
# Exporting bin folder to the path for makefile
export PATH   := $(PWD)/bin:$(PATH)
# Default Shell
export SHELL  := bash
# Type of OS: Linux or Darwin.
export OSTYPE := $(shell uname -s)

BINARY_MIGRATION_TOOLS=jb-chat-migrate


# --- Tooling & Variables ----------------------------------------------------------------
include ./misc/make/tools.Makefile
include ./misc/make/help.Makefile

# ~~~ Development Environment ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
install-deps: sql-migrate jb-chat-migrate ## Install Development Dependencies (localy).
deps: $(SQL_MIGRATE, JB_CHAT_MIGRATE) ## Checks for Global Development Dependencies.
deps:
	@echo "Required Tools Are Available"

# ~~~ Database Migrations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: system-migration-up
system-migration-up: $(SQL_MIGRATE) ## Create a set of up/down migrations with a specified name.
	sql-migrate up --env="systemdb"

.PHONY: system-migration-down
system-migration-down: $(SQL_MIGRATE) ## Create a set of up/down migrations with a specified name.
	sql-migrate down --env="systemdb"

.PHONY: create-migration
create-migration: $(SQL_MIGRATE) ## Create a set of up/down migrations with a specified name.
	@read -p "Enter migration file name: " name; \
	read -p "Enter migration environment: " envname; \
	sql-migrate new --env="$${envname}" $${name}

migrate-specific-tenant: $(JB_CHAT_MIGRATE) ## Create a set of up/down migrations with a specified name.
	@read -p "Enter Tenant Schema name: " name; \
	read -p "Are you sure you want to run migrations for $${name}? (Y/N) " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		${BINARY_MIGRATION_TOOLS} tenant $${name}; \
	else \
		echo "Migrations for $${name} have been cancelled."; \
	fi

migrate-all-tenant: $(JB_CHAT_MIGRATE) ## Create a set of up/down migrations with a specified name.
	@read -p "Are you sure you want to run migrations for all tenants? (Y/N) " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		${BINARY_MIGRATION_TOOLS} all-tenant \
	else \
		echo "Migrations have been cancelled."; \
	fi


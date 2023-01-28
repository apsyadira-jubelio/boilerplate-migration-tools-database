# This makefile should be used to hold functions/variables

define github_url
    https://github.com/$(GITHUB)/releases/download/v$(VERSION)/$(ARCHIVE)
endef

# creates a directory bin.
bin:
	@ mkdir -p $@

# ~~~ Tools ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ~~ [sql-migrate] ~~~ https://github.com/rubenv/sql-migrate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SQL_MIGRATE := $(shell command -v sql-migrate || echo "bin/sql-migrate")
sql-migrate: bin/sql-migrate ## Install sql-migrate (database migration)

bin/sql-migrate: TOOL_NAME := sql-migrate
bin/sql-migrate: VERSION := 1.3.0
bin/sql-migrate: GITHUB  := rubenv/sql-migrate
bin/sql-migrate: RUBENV_GITHUB  := https://github.com/rubenv/sql-migrate/archive/refs/tags/v1.3.0.tar.gz
bin/sql-migrate: ARCHIVE := $(TOOL_NAME)-$(VERSION).tar.gz
bin/sql-migrate: bin
	@ printf "Install sql-migrate... "
	@ go install github.com/rubenv/$(TOOL_NAME)/...@latest
	@ echo "done."


# ~~ [jb-chat-migrate] ~~~ https://github.com/apsyadira-jubelio/migration-tools-database ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

JB_CHAT_MIGRATE := $(shell command -v jb-chat-migrate || echo "bin/jb-chat-migrate")
jb-chat-migrate: bin/jb-chat-migrate ## Install jb-chat-migrate (database migration)

bin/jb-chat-migrate: TOOL_NAME := jb-chat-migrate
bin/jb-chat-migrate: VERSION := 1.0.0
bin/jb-chat-migrate: GITHUB  := apsyadira-jubelio/migration-tools-database
bin/jb-chat-migrate: CHAT_GITHUB  := https://github.com/apsyadira-jubelio/migration-tools-database
bin/jb-chat-migrate: ARCHIVE := $(TOOL_NAME)-$(VERSION).tar.gz
bin/jb-chat-migrate: bin
	@ printf "Install jb-chat-migrate... "
	@ go get -v github.com/apsyadira-jubelio/migration-tools-database
	@ go build -o bin/jb-chat-migrate github.com/apsyadira-jubelio/migration-tools-database
	@ echo "done."
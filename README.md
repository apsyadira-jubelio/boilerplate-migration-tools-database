# Migration Database Tools

This is a tool for running the migration of the database. This tool was created with the aim of keeping all migration files centralized to prevent the loss of migration files like in jubelio core-API.

## Features

- Usable as a CLI tool or as a library
- Supports PostgreSQL
- Migrations are defined with SQL for full flexibility
- Atomic migrations
- Create Schema & run migration for all Tenant or specific tenant
- Run migration for database system
- Create migration file for Database System or Database tenant

## Installation

clone this repositsory and put to your workspace and copy `.env.example` to `.env`. Changes all values in .env file and adjust with your database

## Usage

This tool use `Makefile` to run all command.

### Create Migration File

```bash
make create-migration
```

follow step by step on your terminal to create file migration.
In this project there is 2 environment `systemdb` or `tenantdb`. If you enter `systemdb` file will generated into folder `migrations/system` but if you enter `tenantdb` file will generated into `migrations/tenants`

```bash
Output for Tenants

❯ make create-migration
Enter migration file name: user
Enter migration environment: tenantdb
Created migration migrations/tenants/20230128224426-user.sql
```

```bash
Output for System

❯ make create-migration
Enter migration file name: user
Enter migration environment: systemdb
Created migration migrations/system/20230128224426-user.sql
```

### Run Migration for Specific Tenants

This command will running migration file for specific schema.

```bash
make migrate-specific-tenant
```

```bash
Output

Enter Tenant Schema name: tbngb2liirsoobzqmj73egg
Are you sure you want to run migrations for tbngb2liirsoobzqmj73egg? (Y/N) y
2023/01/28 22:46:53 Run migrations & create schema
2023/01/28 22:46:53 Schema tbngb2liirsoobzqmj73egg created successfully
2023/01/28 22:46:53 prepare to migrate
2023/01/28 22:46:53 Run migrations & create schema
2023/01/28 22:46:53 Run migrations & create schema
2023/01/28 22:46:53 Schema tbngb2liirsoobzqmj73egg created successfully
2023/01/28 22:46:53 Applied 2 migrations!
```

### Run Migration for All Tenant

This command will running migration for all tenants

```bash
make migrate-all-tenant
```

### Run Up Migration for Database System

This command will running migration for database system.

```bash
make system-migration-up
```

### Rollback Migration for Database System

This command will rollback migration for database system.

```bash
make system-migration-down
```

## Tools Used;

This repository was built with [Migration Tools Database](https://github.com/apsyadira-jubelio/migration-tools-database) and [SQL Migrate](https://github.com/rubenv/sql-migrate).
For more detail see `go.mod`. All libraries listed in `go.mod`

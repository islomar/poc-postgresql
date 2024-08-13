# PoC PostgreSQL
Playground for learning about PostgreSQL

## Principles
- Dockerize so much as possible
- Automate so much as possible

## Things to learn
- [ ] How to generate a dump
  - https://github.com/thingsboard/thingsboard/issues/8116
  - `pg_dump dangerousdb > db.sql`
  - `pg_dump -U postgres -F c dangerousdb > dangerousdb.tar`
  - `pg_dump -U postgres -F d dangerousdb > db1_backup`
  - `pg_dump -U postgres dangerousdb | gzip > dangerousdb.gz`
- [x] How to run an SQL sentence with `docker run`
- [ ] How to start a DB with data loaded (e.g. for testing)
- [ ] How to automate migrations
- [ ] How to anonymize a dump
- [x] How to restore a DB from an archive ([pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html))
- [ ] How to automatically fill fields like `created_at`, `updated_at`
- [ ] Logs
- [ ] SQL joins (refresh)
  - https://www.w3schools.com/sql/sql_join.asp

## Commands
- Download Docker image
  - `docker pull postgres:16.3`
  - View a summary of image vulnerabilities and recommendations → `docker scout quickview postgres:16.3`
- Start a PostgreSQL instance
  - `docker run --name some-postgres -p 15432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres`
  - The default postgres user and database are created in the entrypoint with initdb
- Run psql
  - `docker exec -it some-postgres psql -U postgres`
  - `docker exec -it some-postgres psql -U postgres <databaseName>`
  - `docker exec some-postgres psql -U postgres -c "<SQL_SENTENCE>"`
- Generate a dump
  - `docker exec -it some-postgres pg_dump some-postgres > db.sql`

## PSQL
- https://www.atlassian.com/data/admin/how-to-list-databases-and-tables-in-postgresql-using-psql
- `\l`: list all the existing databases
  - `\l+`: show more info
- `\c <databaseName>`: connect to the DB <databaseName>
- `\dt`: show tables inside the database
  - `\dt+`: show more info
- `\dt <table_name>`
## SQL
- Show all tables
```postgresql
SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND
schemaname != 'information_schema';
```

## Interesting links
- https://www.postgresql.org/
  - LTS: 16.3 (30.07.2024)
  - Docker image size: 432 MB
- **Docker**
  - https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image/
    - It includes info for using `docker compose`
    - Better use [Docker secrets](https://github.com/docker-library/docs/blob/master/postgres/README.md#docker-secrets) for passing the password instead of environment variables
  - https://hub.docker.com/_/postgres
- **Tools used**
  - DBeaver
- https://www.youtube.com/@CodelyTV/search?query=postgresql
- https://pglite.dev/
  - Run a full Postgres database locally in WASM with reactivity and live sync.
- https://postgres.new/
  - https://github.com/supabase-community/postgres-new
  - In-browser Postgres sandbox with AI assistance.

### Sample databases
- https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/
  - `wget https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip`
  - `unzip dvdrental.zip`
  - `docker run --name some-postgres -p 15432:5432 --mount type=bind,source="$(pwd)"/dvdrental.tar,target=/dvdrental.tar -e POSTGRES_PASSWORD=mysecretpassword -d postgres`
    - https://docs.docker.com/storage/bind-mounts/#start-a-container-with-a-bind-mount
  - `docker exec some-postgres psql -U postgres -c "CREATE DATABASE dvdrental;"`
  - `docker exec -it some-postgres pg_restore -U postgres -d dvdrental dvdrental.tar`
- https://github.com/morenoh149/postgresDBSamples
- https://wiki.postgresql.org/wiki/Sample_Databases

### Courses and training
- https://www.red-gate.com/hub/events/series/postgresql-101
- https://www.postgresql.org/docs/online-resources/

### Pending readings
- https://simplebackups.com/blog/postgresql-pgdump-and-pgrestore-guide-examples/
- https://architecturenotes.co/p/things-you-should-know-about-databases
- https://x-team.com/blog/automatic-timestamps-with-postgresql
- https://salsita.github.io/node-pg-migrate/introduction
- https://gds.blog.gov.uk/2024/01/17/how-we-migrated-our-postgresql-database-with-11-seconds-downtime/

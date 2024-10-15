.DEFAULT_GOAL := help

POSTGRES_IMAGE_NAME="postgres:16.3"

help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: start
start: ## Start an empty PostgreSQL instance
	docker run --name some-postgres -p 15432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d $(POSTGRES_IMAGE_NAME)

.PHONY: start-dvdrental
start-dvdrental: ## Start an example Database "dvdrental"
	docker run --name some-postgres -p 15432:5432 --mount type=bind,source=$(PWD)/dvdrental.tar,target=/dvdrental.tar -e POSTGRES_PASSWORD=mysecretpassword -d $(POSTGRES_IMAGE_NAME)

.PHONY: psql
psql: ## Start PSQL
	docker exec -it some-postgres psql -U postgres

.PHONY: start-populated
start-populated: ## Start a populated database
	docker compose up

.PHONY: stop-populated
stop-populated: ## Stop the populated database
	docker compose down --volumes

.PHONY: stop-and-clean-populated
stop-and-clean-populated: ## Stop the populated database and clean the volumes
	docker compose down --volumes

.PHONY: psql
psql-my-postgres: ## Start PSQL
	docker exec -it my-postgres psql -U postgres

.PHONY: open-web-adminer
open-web-adminer: ## Open web administrator
	open http://localhost:8080/?pgsql=db&username=postgres
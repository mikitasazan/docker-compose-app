.PHONY: test
test:
	docker compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

.PHONY: dev
dev:
	docker compose up

.PHONY: setup
setup:
	docker compose run --rm app make setup

.PHONY: down
down:
	docker compose down

.PHONY: build
build:
	docker compose build

.PHONY: ci
ci:
	docker compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

.PHONY: help init clear migrate infra-up infra-down \
	start-main start-video-convert start-video-player start-bookmarks start-search start-stats start-frontend

.DEFAULT_GOAL := help

MICROSERVICES := main video-convert video-player bookmarks search stats

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*##"; printf "\nNetFlux Makefile\n\n"} \
		/^[a-zA-Z0-9_-]+:.*##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } \
		END { printf "\n" }' $(MAKEFILE_LIST)

init: ## Copy .env.example, sync Python/Node deps, run migrate placeholder
	@if [ ! -f .env ]; then cp .env.example .env; echo "Created .env from .env.example"; else echo ".env already exists"; fi
	@echo "==> uv sync in common"
	@(cd common && uv sync) || exit 1
	@for dir in $(MICROSERVICES); do \
		echo "==> uv sync in $$dir"; \
		(cd $$dir && uv sync --group dev) || exit 1; \
	done
	@echo "==> npm install in frontend"
	@cd frontend && npm install
	@$(MAKE) migrate

migrate: ## Database migrations (placeholder until course tooling is configured)
	@echo "migrate: not configured yet — add Alembic or professor-provided migration steps here."

clear: ## Remove all local *.db files under the repository
	@python -c "import pathlib; root=pathlib.Path('.'); removed=[p for p in root.rglob('*.db') if p.is_file()]; [p.unlink() for p in removed]; print(f'Removed {len(removed)} .db file(s)' if removed else 'No .db files found')"

infra-up: ## Start shared infrastructure (docker compose)
	docker compose up -d

infra-down: ## Stop shared infrastructure (docker compose)
	docker compose down

start-main: ## Start main backend (port 8000)
	cd main && uv run fastapi dev main/main.py --port 8000

start-video-convert: ## Start video-convert (port 8001)
	cd video-convert && uv run fastapi dev video_convert/main.py --port 8001

start-video-player: ## Start video-player (port 8002)
	cd video-player && uv run fastapi dev video_player/main.py --port 8002

start-bookmarks: ## Start bookmarks (port 8003)
	cd bookmarks && uv run fastapi dev bookmarks/main.py --port 8003

start-search: ## Start search (port 8004)
	cd search && uv run fastapi dev search/main.py --port 8004

start-stats: ## Start stats (port 8005)
	cd stats && uv run fastapi dev stats/main.py --port 8005

start-frontend: ## Start React dev server
	cd frontend && npm run dev

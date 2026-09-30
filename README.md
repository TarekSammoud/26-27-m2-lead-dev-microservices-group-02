# NetFlux

Monorepo for the NetFlux microservices course project: independent Python services, a shared `common` library, a React frontend, and shared infrastructure (PostgreSQL, Redis, MQTT).

## Architecture

| Path | Role |
|------|------|
| `main/` | Backend entry point (future gateway to satellite services) |
| `video-convert/`, `video-player/`, `bookmarks/`, `search/`, `stats/` | Satellite microservices |
| `common/` | Shared Python package (editable local dependency) |
| `frontend/` | React application |
| `docker-compose.yml` | Shared infrastructure |

**Rules**

- Microservices must **never** import one another (`from search...`, `from stats...`, etc. is forbidden).
- Shared Python code belongs only in **`common/`**.

## Initialize the project

```bash
make help
make init
```

`make init` copies `.env.example` to `.env` (if missing), runs `uv sync` in `common` and each microservice, installs frontend dependencies, and calls the migration placeholder.

Database migrations are **not** configured yet; `make migrate` prints a placeholder until course tooling is added.

## Infrastructure

```bash
make infra-up
make infra-down
```

## Run services (each uses its own `uv` project and `.venv`)

```bash
make start-main
make start-video-convert
make start-video-player
make start-bookmarks
make start-search
make start-stats
make start-frontend
```

Default API ports: `8000` (main) through `8005` (stats). See `.env.example`.

## New microservice (Cookiecutter)

From the repository root:

```bash
uvx cookiecutter ./template-microservice
```

Enter a directory name such as `stats` or `video-convert`. The template derives a Python package name (e.g. `video_convert`). Then:

```bash
cd <service_name> && uv sync --group dev
```

## Cleaning local SQLite files

```bash
make clear
```

## Tooling

- Python: [uv](https://docs.astral.sh/uv/) per service (`pyproject.toml`, local `.venv/`, not committed)
- Frontend: Vite + React + TypeScript
- Makefile targets expect **GNU Make** (e.g. Git Bash on Windows, or WSL/Linux/macOS)

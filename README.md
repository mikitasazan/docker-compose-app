# Docker Compose App

Hexlet educational project demonstrating Docker Compose configuration with PostgreSQL, Caddy reverse proxy, and CI/CD.

### Hexlet tests and linter status:
[![Actions Status](https://github.com/mikitasazan/docker-compose-app/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/mikitasazan/docker-compose-app/actions)

### Docker CI status:
[![Docker CI](https://github.com/mikitasazan/docker-compose-app/actions/workflows/push.yml/badge.svg)](https://github.com/mikitasazan/docker-compose-app/actions/workflows/push.yml)

## Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+
- Make

## Docker Hub

Production image: [sazanik/docker-compose-app](https://hub.docker.com/r/sazanik/docker-compose-app)

## Setup

1. Clone the repository:
```bash
git clone https://github.com/mikitasazan/docker-compose-app.git
cd docker-compose-app
```

2. Install dependencies:
```bash
make setup
```

## Usage

### Development

Start all services (app + PostgreSQL + Caddy):
```bash
make dev
# or
docker compose up
```

Application will be available at:
- https://localhost (with HTTPS via Caddy)
- http://localhost (redirects to HTTPS)

### Testing

Run tests:
```bash
make test
# or
make ci
```

### Other Commands

```bash
make build    # Build images
make down     # Stop all services
```

## Architecture

```
Browser → Caddy (reverse proxy) → App (Node.js + Fastify) → PostgreSQL
          ↓
          - HTTPS
          - Compression (zstd)
          - HTTP → HTTPS redirect
```

## Services

- **app**: Node.js application (Fastify blog)
- **db**: PostgreSQL 16 database
- **caddy**: Caddy reverse proxy with automatic HTTPS

## Configuration

### Environment Variables

The application uses the following environment variables:

- `DATABASE_HOST` - Database host (default: `db`)
- `DATABASE_NAME` - Database name (default: `postgres`)
- `DATABASE_USERNAME` - Database username (default: `postgres`)
- `DATABASE_PASSWORD` - Database password (default: `password`)
- `DATABASE_PORT` - Database port (default: `5432`)

### Working with Environment Files

This project uses **`.env.defaults`** as single source of truth (DRY principle):

**Files:**
- **`.env.defaults`** - Default values (committed)
- **`.env`** - Local overrides (ignored by git, optional)

**Priority:** `.env` > `.env.defaults`

**For local development:**
```bash
# Option 1: Use defaults (no action needed)
docker compose up

# Option 2: Override specific values
cp .env.defaults .env
# Edit .env with your custom values
docker compose up
```

**For CI/CD:**
- Workflows copy `.env.defaults` → `.env`
- Override with GitHub Secrets (if configured)

**Benefits:**
- ✅ One place to define defaults
- ✅ No duplication across files
- ✅ Works out-of-the-box

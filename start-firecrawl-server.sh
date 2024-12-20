#!/usr/bin/env bash
set -e

# Attempting the "source" approach for simplicity
if [ -f ./apps/api/.env ]; then
  echo "Loading environment variables from ./apps/api/.env"
  set -o allexport
  # Shellcheck disable=SC1091
  source ./apps/api/.env
  set +o allexport
else
  echo "No .env file found in ./apps/api/. Please create one or copy .env.example."
fi

# Ensure Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
  echo "docker could not be found. Please install Docker."
  exit 1
fi

if ! command -v docker compose &> /dev/null; then
  echo "docker compose could not be found. Please install docker-compose."
  exit 1
fi

# Build images
docker compose build

# Start all services in the background
docker compose up -d

echo "Firecrawl server environment started."
echo "Services running:"
docker compose ps

echo "You can access the Firecrawl API at http://localhost:${PORT:-3002}"
echo "Playwright service at http://localhost:3000"
echo "Redis at localhost:6379"

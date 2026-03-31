#!/bin/bash
set -e

echo "[Runner Init] Waiting for Docker daemon to be ready..."
timeout 60 bash -c 'until docker info >/dev/null 2>&1; do sleep 2; done' \
  || echo "[Runner Init] Warning: Docker daemon not available, skipping image preload"

if docker info >/dev/null 2>&1; then
  echo "[Runner Init] Loading pre-cached Docker images..."
  for image_tar in /docker-image-cache/*.tar; do
    if [ -f "$image_tar" ]; then
      echo "[Runner Init] Loading: $(basename "$image_tar")"
      docker load -i "$image_tar" || echo "[Runner Init] Warning: failed to load $image_tar"
    fi
  done
  echo "[Runner Init] Pre-cached images loaded."
fi

exec "$@"

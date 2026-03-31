#!/bin/bash
set -e

echo "[Runner Cache] Loading pre-cached Docker images..."
for image_tar in /docker-image-cache/*.tar; do
  if [ -f "$image_tar" ]; then
    echo "[Runner Cache] Loading: $(basename "$image_tar")"
    docker load -i "$image_tar" || echo "[Runner Cache] Warning: failed to load $image_tar"
  fi
done
echo "[Runner Cache] Pre-cached images ready."

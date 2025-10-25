#!/bin/bash
# docker_clean.sh — safely remove the persistent px4-roscon-25 container

CONTAINER_NAME="px4-roscon-25"

# Check if the container exists
if ! docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "No container named '${CONTAINER_NAME}' found."
    exit 1
fi

# Ask for confirmation
read -p "Are you sure you want to delete the persistent container '${CONTAINER_NAME}'? [y/N]: " confirm

# Proceed only if confirmed
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Stopping and removing container '${CONTAINER_NAME}'..."
    docker stop "${CONTAINER_NAME}" >/dev/null 2>&1
    docker rm "${CONTAINER_NAME}"
    echo "Container '${CONTAINER_NAME}' removed successfully."
else
    echo "Operation cancelled."
fi

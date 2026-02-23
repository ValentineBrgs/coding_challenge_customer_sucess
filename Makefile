.PHONY: help build run run-jupyter stop clean rebuild

# Variables
IMAGE_NAME = ostk-mission-manager
CONTAINER_NAME = ostk-jupyter-lab
PORT = 8888

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build the Docker image
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .

run: build ## Build and run the container (same as run-jupyter)
	@echo "Starting JupyterLab server..."
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-p $(PORT):8888 \
		-v $$(pwd):/app \
		$(IMAGE_NAME)

run-jupyter: run ## Start JupyterLab server (alias for run)

run-detached: build ## Run the container in detached mode (background)
	@echo "Starting JupyterLab server in detached mode..."
	docker run -d --rm \
		--name $(CONTAINER_NAME) \
		-p $(PORT):8888 \
		-v $$(pwd):/app \
		$(IMAGE_NAME)
	@echo "JupyterLab is running at http://localhost:$(PORT)/lab"

stop: ## Stop the running container
	@echo "Stopping container..."
	docker stop $(CONTAINER_NAME) 2>/dev/null || true

clean: stop ## Stop container and remove the Docker image
	@echo "Removing Docker image..."
	docker rmi $(IMAGE_NAME) 2>/dev/null || true
	@echo "Cleanup complete"

rebuild: clean build ## Clean and rebuild the Docker image
	@echo "Rebuild complete"

shell: ## Open a shell in the running container
	docker exec -it $(CONTAINER_NAME) /bin/zsh

logs: ## Show container logs
	docker logs -f $(CONTAINER_NAME)

ps: ## Show running containers
	docker ps -a | grep $(CONTAINER_NAME) || echo "No containers running"

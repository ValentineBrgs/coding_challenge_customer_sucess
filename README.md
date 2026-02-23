# Open Space Toolkit - Mission Manager

This project provides a Docker environment for working with the [Open Space Toolkit (OSTk)](https://github.com/open-space-collective/open-space-toolkit) in JupyterLab.

## Prerequisites

Before you begin, make sure you have the following installed on your local machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/downloads)
- [GNU Make](https://www.gnu.org/software/make/) (usually pre-installed on macOS and Linux)

## Getting Started

### Quick Start (Using Makefile - Recommended)

The easiest way to get started is using the Makefile:

```bash
# Navigate to your project directory
cd /Users/bourgeoisvalentine/workspace/coding_challenge_mission_manager

# Build and run JupyterLab in one command
make run-jupyter
```

Once the container is running, open your web browser and navigate to:

```
http://localhost:8888/lab
```

You should see the JupyterLab interface with the `template.ipynb` notebook ready to use.

### Available Make Commands

Run `make help` to see all available commands:

- `make build` - Build the Docker image
- `make run` or `make run-jupyter` - Build and run JupyterLab server
- `make run-detached` - Run JupyterLab in background mode
- `make stop` - Stop the running container
- `make clean` - Stop container and remove Docker image
- `make rebuild` - Clean and rebuild everything
- `make shell` - Open a shell in the running container
- `make logs` - Show container logs
- `make ps` - Show running containers

### Manual Setup (Without Makefile)

If you prefer to use Docker commands directly:

#### 1. Build the Docker Image

```bash
docker build -t ostk-mission-manager .
```

This will:

- Install Python 3.11
- Download and cache Open Space Toolkit data
- Install JupyterLab and necessary dependencies
- Set up the `template.ipynb` notebook

#### 2. Run the Docker Container

Start the JupyterLab server inside Docker:

```bash
docker run -it --rm -p 8888:8888 -v $(pwd):/app ostk-mission-manager
```

**Command Breakdown:**

- `-it`: Run interactively with a terminal
- `--rm`: Automatically remove the container when it exits
- `-p 8888:8888`: Map port 8888 from the container to your local machine
- `-v $(pwd):/app`: Mount your current directory to `/app` in the container (so your work is saved locally)

#### 3. Access JupyterLab

Once the container is running, open your web browser and navigate to:

```
http://localhost:8888/lab
```

You should see the JupyterLab interface with the `template.ipynb` notebook ready to use.

## Using the Template Notebook

The `template.ipynb` file is a starter notebook where you can:

- Import Open Space Toolkit libraries
- Write and execute Python code for space engineering applications
- Experiment with orbits, attitudes, and other astrodynamics concepts

## Customizing Your Environment

### Adding More OSTk Libraries

To add specific Open Space Toolkit libraries, edit the `requirements.txt` file and uncomment or add the libraries you need:

```txt
open-space-toolkit-core
open-space-toolkit-io
open-space-toolkit-mathematics
open-space-toolkit-physics
open-space-toolkit-astrodynamics
```

Then rebuild the Docker image:

```bash
make rebuild
```

Or manually:

```bash
docker build -t ostk-mission-manager .
```

### Persisting Your Work

When you run the container with the `-v $(pwd):/app` flag, any notebooks you create or modify will be saved to your local directory. This means your work persists even after stopping the container.

## Stopping the Container

### Using Makefile:

```bash
make stop
```

### Manual Method:

To stop the JupyterLab server:

1. Press `Ctrl+C` in the terminal where the container is running
2. The container will automatically be removed (because of the `--rm` flag)

## Alternative: Using docker-compose (Optional)

You can also create a `docker-compose.yml` file for easier management:

```yaml
version: "3.8"

services:
  jupyter:
    build: .
    ports:
      - "8888:8888"
    volumes:
      - .:/app
    container_name: ostk-jupyter
```

Then run:

```bash
docker-compose up
```

## Troubleshooting

### Port 8888 Already in Use

If port 8888 is already in use, you can map to a different port:

```bash
docker run -it --rm -p 8889:8888 -v $(pwd):/app ostk-mission-manager
```

Then access JupyterLab at `http://localhost:8889/lab`

### Permission Issues

If you encounter permission issues with mounted volumes, try running with your user ID:

```bash
docker run -it --rm -p 8888:8888 -v $(pwd):/app --user $(id -u):$(id -g) ostk-mission-manager
```

## Resources

- [Open Space Toolkit GitHub](https://github.com/open-space-collective/open-space-toolkit)
- [Open Space Toolkit Documentation](https://github.com/open-space-collective/open-space-toolkit/tree/main/docs)
- [JupyterLab Documentation](https://jupyterlab.readthedocs.io/)

## License

This project uses the Open Space Toolkit, which is licensed under the Apache License 2.0.

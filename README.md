# Open Space Toolkit - Mission Manager

Analyze satellite access patterns for ground stations and zones of interest using the [Open Space Toolkit (OSTk)](https://github.com/open-space-collective/open-space-toolkit).

## Quick Start with Binder (No Installation Required)

Launch this repository instantly in your browser:

[![Binder](https://mybinder.org/badge_logo.svg)](https://2i2c.mybinder.org/v2/gh/ValentineBrgs/coding_challenge_customer_sucess/main?labpath=access_computation.ipynb)

Click the badge above to open `access_computation.ipynb` in JupyterLab. All dependencies are pre-installed and ready to use.

## What's Inside

The `access_computation.ipynb` notebook demonstrates:
- **Ground Station Access Analysis**: Computing satellite visibility windows with 5° minimum elevation
- **Zone of Interest Monitoring**: Special analysis for France with 30° minimum elevation

## Local Setup (Optional)

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Make](https://www.gnu.org/software/make/) (pre-installed on macOS/Linux)

## Getting Started

### Using Makefile (Recommended)

```bash
# Build and run JupyterLab
make run-jupyter
```

Access JupyterLab at `http://localhost:8888/lab`

**Common Commands:**
- `make run-jupyter` - Build and start JupyterLab
- `make stop` - Stop the container
- `make rebuild` - Clean rebuild
- `make help` - Show all commands

### Using Docker Directly

```bash
# Build the image
docker build -t ostk-mission-manager .

# Run JupyterLab
docker run -it --rm -p 8888:8888 -v $(pwd):/app ostk-mission-manager
```

Access at `http://localhost:8888/lab`

## Notebook Structure

The notebook is organized into clear sections:

1. **Setup**: Import libraries and configure environment
2. **Visibility Criteria**: Define elevation requirements (5° for ground stations, 30° for France)
3. **Ground Stations**: Configure 8 global tracking stations
4. **Zone of Interest**: Configure France with stricter visibility
5. **Orbit Definition**: Sun-synchronous orbit at 500 km
6. **Access Computation**: Calculate visibility windows
7. **Geometry**: Compute satellite position during passes
8. **Visualization**: Interactive map showing stations and access paths

## Configuration

### Ground Stations (stations.yaml)

Modify `stations.yaml` to add/remove ground stations:

```yaml
stations:
  Station_Name:
    lla: [latitude, longitude, altitude_meters]
```

### Visibility Criteria

Adjust elevation requirements in the notebook:
- Ground stations: 5° minimum elevation
- Zone of interest


## Troubleshooting

**Port 8888 in use?** Change the port:
```bash
docker run -it --rm -p 8889:8888 -v $(pwd):/app ostk-mission-manager
```
Access at `http://localhost:8889/lab`

## Resources

- [Open Space Toolkit](https://github.com/open-space-collective/open-space-toolkit)
- [OSTk Astrodynamics Docs](https://open-space-collective.github.io/open-space-toolkit-astrodynamics/)
- [JupyterLab Documentation](https://jupyterlab.readthedocs.io/)
- [2i2c Binder Service](https://2i2c.org/)

## License

This project uses the Open Space Toolkit, licensed under Apache License 2.0.

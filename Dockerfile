ARG PYTHON_BASE_VERSION="3.11"
ARG OSTK_DATA_LOCAL_CACHE="/var/cache/open-space-toolkit-data"

# Open Space Toolkit install image
FROM mcr.microsoft.com/vscode/devcontainers/python:${PYTHON_BASE_VERSION}

## Install OSTk data install dependencies
RUN apt-get update && \
    apt-get install -y git-lfs && \
    rm -rf /var/lib/apt/lists/*

## Seed OSTk Data
ARG OSTK_DATA_LOCAL_CACHE
ENV OSTK_PHYSICS_DATA_LOCAL_REPOSITORY="${OSTK_DATA_LOCAL_CACHE}/data"

RUN git clone \
    --branch=v1 \
    --single-branch \
    --depth=1 \
    https://github.com/open-space-collective/open-space-toolkit-data.git ${OSTK_DATA_LOCAL_CACHE} && \
    chmod -R g+w ${OSTK_DATA_LOCAL_CACHE}

## Update libstdc++ for Cpp20 support
RUN echo "deb http://deb.debian.org/debian testing main" > /etc/apt/sources.list.d/testing.list && \
    apt-get update && \
    apt-get install --yes -t testing libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

## Update user id and group id with local ones
ARG USERNAME="vscode"
ARG USER_UID="1000"
ARG USER_GID=${USER_UID}
RUN groupmod --gid ${USER_GID} ${USERNAME} && \
    usermod --uid ${USER_UID} --gid ${USER_GID} ${USERNAME}

## Update permissions of OSTk data repo
ARG OSTK_DATA_LOCAL_CACHE
RUN chown -R ${USER_GID}:${USER_GID} ${OSTK_DATA_LOCAL_CACHE}

## Change user
USER ${USERNAME}

## Install dependencies
COPY --chown=${USER_UID}:${USER_GID} requirements.txt /home/${USERNAME}/tmp/

RUN cd /home/${USERNAME}/tmp/ && \
    pip --no-cache-dir install --user -r requirements.txt && \
    rm -rf /home/${USERNAME}/tmp/

## Add user's local bin to PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

## Copy template notebook
COPY --chown=${USER_UID}:${USER_GID} access_computation.ipynb /app/access_computation.ipynb


## Copy station document
COPY --chown=${USER_UID}:${USER_GID} stations.json /app/stations.json


## Change default entrypoint folder to /app
WORKDIR /app

## Expose Jupyter port
EXPOSE 8888

## Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

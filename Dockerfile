# Use the official XMM SAS Datalab base image
#ARG REGISTRY=scidockreg.esac.esa.int:62510
#FROM ${REGISTRY}/datalabs/xmm-sas22.1.0:1.1.0

FROM scidockreg.esac.esa.int:62510/egulbaha_heasoft:v0.0.1-31

ENV DEBIAN_FRONTEND=noninteractive

# Metadata
LABEL description="SIXTE datalab"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    gfortran \
    libgsl-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libcgal-dev \
    libreadline-dev \
    libncurses-dev \
    libexpat1-dev \
    pkg-config \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Define environment directories
ENV ENVIRONMENT=SIXTE_PREFIX=/opt/sixte SIMPUT_PREFIX=${SIXTE_PREFIX}/simput SIXTE_DIR=${SIXTE_PREFIX}/sixte

# Clone and install SIMPUT
RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/simput.git /tmp/simput && \
    cmake -S /tmp/simput -B /tmp/simput/build -DCMAKE_INSTALL_PREFIX=${SIMPUT_PREFIX} && \
    cmake --build /tmp/simput/build --parallel 4 && \
    cmake --install /tmp/simput/build && \
    rm -rf /tmp/simput

# Clone and install SIXTE
RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/sixt /tmp/sixte && \
    cmake -S /tmp/sixte -B /tmp/sixte/build -DCMAKE_INSTALL_PREFIX=${SIXTE_DIR} -DSIMPUT_ROOT=${SIMPUT_PREFIX} && \
    cmake --build /tmp/sixte/build --parallel 4 && \
    cmake --install /tmp/sixte/build && \
    rm -rf /tmp/sixte

# Set environment variables for use in notebooks
ENV ENVIRONMENT=SIMPUT=${SIMPUT_PREFIX} SIXTE=${SIXTE_DIR} PATH="${SIXTE}/bin:${PATH}" LD_LIBRARY_PATH="${SIMPUT}/lib:${SIXTE}/lib:${LD_LIBRARY_PATH}" PFILES="/media/home/pfiles:/opt/sixte/sixte/share/sixte/pfiles:/opt/sixte/simput/share/simput/pfiles:/usr/local/heasoft-6.33.2/x86_64-pc-linux-gnu-libc2.35/syspfiles"


COPY sixte-init-datalabs.sh /opt/datalab/init.d/
RUN chmod +x /opt/datalab/init.d/sixte-init-datalabs.sh




RUN mkdir /media/notebooks/
COPY simulator_manual.pdf /media/notebooks/

# Source the sixte-install.sh on container start
RUN echo 'export SIXTE=/opt/sixte/sixte' >> ~/.bashrc
RUN echo 'export SIMPUT=/opt/sixte/simput' >> ~/.bashrc
RUN echo '. $SIXTE/bin/sixte-install.sh' >> ~/.bashrc

#RUN ${SIXTE_DIR}/bin/xifusim --help || echo "SIXTE installed, but cannot test without full config"


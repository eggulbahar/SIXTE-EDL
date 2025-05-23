#---------------------------------------------------------------------------------------------------
# This is a Dockerfile for sixte container on EDL. It does not build Heasoft on its own and 
# is built on top of the already existing XMM-SASv22.1 image which contains Heasoft (alternative
# available below). 
# Latest update: 23.05.2025
# By: E.G.G.
# If you have any suggestions please contact: esin.gulbahar@fau.de
#--------------------------------------------------------------------------------------------------

# Use the official XMM SASv22.1 Datalab as base image (has js9)
ARG REGISTRY=scidockreg.esac.esa.int:62510
FROM ${REGISTRY}/datalabs/xmm-sas22.1.0:1.1.0

#---------------------------------------------------------------
# Use the latest HeaSoft Datalab as base image (Not public)
#FROM scidockreg.esac.esa.int:62510/egulbaha_heasoft:v0.0.1-31
#---------------------------------------------------------------

ENV DEBIAN_FRONTEND=noninteractive

LABEL description="SIXTE datalab"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#------------------------------
# Install system dependencies
#------------------------------
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

#---------------------------------
# Define environment directories
#---------------------------------
ENV SIXTE_PREFIX=/opt/sixte 
ENV SIMPUT_PREFIX=${SIXTE_PREFIX}/simput 
ENV SIXTE_DIR=${SIXTE_PREFIX}/sixte

#--------------------------
# Clone and install SIMPUT
#---------------------------
RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/simput.git /tmp/simput && \
    cmake -S /tmp/simput -B /tmp/simput/build -DCMAKE_INSTALL_PREFIX=${SIMPUT_PREFIX} && \
    cmake --build /tmp/simput/build --parallel 4 && \
    cmake --install /tmp/simput/build && \
    rm -rf /tmp/simput

#-------------------------
# Clone and install SIXTE
#-------------------------
RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/sixt /tmp/sixte && \
    cmake -S /tmp/sixte -B /tmp/sixte/build -DCMAKE_INSTALL_PREFIX=${SIXTE_DIR} -DSIMPUT_ROOT=${SIMPUT_PREFIX} && \
    cmake --build /tmp/sixte/build --parallel 4 && \
    cmake --install /tmp/sixte/build && \
    rm -rf /tmp/sixte

#---------------------------
# Set environment variables 
#---------------------------
ENV ENVIRONMENT=SIMPUT=${SIMPUT_PREFIX} 
ENV SIXTE=${SIXTE_DIR} 
ENV PATH="${SIXTE}/bin:${PATH}" 
ENV LD_LIBRARY_PATH="${SIMPUT}/lib:${SIXTE}/lib:${LD_LIBRARY_PATH}" 

#------------------------------------------------------------------------
# Copy the sixte init script to run at each start and make it executable
#------------------------------------------------------------------------
COPY user-sixte-init-datalabs.sh /opt/datalab/init.d/
RUN chmod +x /opt/datalab/init.d/user-sixte-init-datalabs.sh

#---------------------------------------------------------------------------------------------------
# Below add any extra material to be shared with the datalab users (for now I only added the manual)
#---------------------------------------------------------------------------------------------------
RUN mkdir /media/notebooks/
COPY simulator_manual.pdf /media/notebooks/

#--------------------------------------------------------------------------------------
# Copy the instrument tarballs to temporary loaction and then extract into correct path
#--------------------------------------------------------------------------------------
# Athena WFI
RUN wget https://www.sternwarte.uni-erlangen.de/~sixte/downloads/sixte/instruments/instruments_athena-wfi-1.11.1.tar.gz -O /tmp/instruments_athena-wfi-1.11.1.tar.gz && \
    mkdir -p /opt/sixte/sixte/share/sixte/instruments && \
    tar --strip-components=3 -xzf /tmp/instruments_athena-wfi-1.11.1.tar.gz -C /opt/sixte/sixte/share/sixte/instruments && \
    rm -f /tmp/instruments_athena-wfi-1.11.1.tar.gz


# Athena X-IFU
RUN wget https://www.sternwarte.uni-erlangen.de/~sixte/downloads/sixte/instruments/instruments_athena-xifu-1.9.1.tar.gz -O /tmp/instruments_athena-xifu-1.9.1.tar.gz && \
    mkdir -p /opt/sixte/sixte/share/sixte/instruments && \
    tar --strip-components=3 -xzf /tmp/instruments_athena-xifu-1.9.1.tar.gz -C /opt/sixte/sixte/share/sixte/instruments && \
    rm -f /tmp/instruments_athena-xifu-1.9.1.tar.gz

# AXIS
RUN wget https://www.sternwarte.uni-erlangen.de/~sixte/downloads/sixte/instruments/instruments_axis-3.1.1.tar.gz -O /tmp/instruments_axis-3.1.1.tar.gz && \
    mkdir -p /opt/sixte/sixte/share/sixte/instruments && \
    tar --strip-components=3 -xzf /tmp/instruments_axis-3.1.1.tar.gz -C /opt/sixte/sixte/share/sixte/instruments && \
    rm -f /tmp/instruments_axis-3.1.1.tar.gz


# SRG
RUN wget https://www.sternwarte.uni-erlangen.de/~sixte/downloads/sixte/instruments/instruments_srg-1.9.2.tar.gz -O /tmp/instruments_srg-1.9.2.tar.gz && \
    mkdir -p /opt/sixte/sixte/share/sixte/instruments && \
    tar --strip-components=3 -xzf /tmp/instruments_srg-1.9.2.tar.gz -C /opt/sixte/sixte/share/sixte/instruments && \
    rm -f /tmp/instruments_srg-1.9.2.tar.gz


# XRISM
RUN wget https://www.sternwarte.uni-erlangen.de/~sixte/downloads/sixte/instruments/instruments_xrism-1.2.0.tar.gz -O /tmp/instruments_xrism-1.2.0.tar.gz && \
    mkdir -p /opt/sixte/sixte/share/sixte/instruments && \
    tar --strip-components=3 -xzf /tmp/instruments_xrism-1.2.0.tar.gz -C /opt/sixte/sixte/share/sixte/instruments && \
    rm -f /tmp/instruments_xrism-1.2.0.tar.gz


#------------------------------------------------
# Source the sixte-install.sh on container start
#------------------------------------------------
RUN echo 'export SIXTE=/opt/sixte/sixte' >> ~/.bashrc \
    echo 'export SIMPUT=/opt/sixte/simput' >> ~/.bashrc \
    echo '. $SIXTE/bin/sixte-install.sh' >> ~/.bashrc
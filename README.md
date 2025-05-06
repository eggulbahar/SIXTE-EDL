# SIXTE in ESA Datalabs
***
This is a repository that contains the files needed to build the [SIXTE](https://www.sternwarte.uni-erlangen.de/sixte/) datalab, which is currently not public. All the files in the main branch are used to build a DOcker container in the context of the [ESA Datalabs](https://datalabs.esa.int/) infrastructure.

## Structure
* [Dockerfile](Dockerfile) -> custom Dockerfile that installs and builds SIXTE on top of the XMM-SASv22.1 datalab as base image.
* [datalab-meta.yml](datalab-meta.yml) -> pre-filled metadata used when creating the datalab
* [logo.svg](logo.svg) -> SIXTE logo in SVG format for the logo of the datalab instance
* [simulator_manual.pdf](simulator_manual.pdf) -> SIXTE software manual made available inside the datalab
* [user-sixte-init-datalabs.sh](user-sixte-init-datalabs.sh) -> script used for initialising the SIXTE software and setting environment variables

## Citation
If you use results obtained with SIXTE in a publication, please cite as: “This research has made use of the SIXTE software package (Dauser et al., 2019) provided by ECAP/Remeis observatory (https://github.com/thdauser/sixte).”

***
*Author: Esin G. Gulbahar*
*Last Updated: 06/05/2025*
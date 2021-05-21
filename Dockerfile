##
# This creates an Ubuntu derived base image that installs GDAL 3 and Python3 essentials.
#
# Ubuntu 20.04 Focal Fossa
FROM osgeo/gdal

LABEL maintainer="Rennan Marujo <rennanmarujo@gmail.com>"

# Setup build env for PROJ
USER root
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing --no-install-recommends \
            software-properties-common build-essential ca-certificates \
            git make cmake wget unzip libtool automake \
            zlib1g-dev libsqlite3-dev pkg-config sqlite3 libcurl4-gnutls-dev \
            libtiff5-dev \
    && apt install python3-pip -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $ROOTDIR/

RUN apt install python3-pip

# Install Python3 packages
RUN pip3 install rasterio
RUN pip3 install scikit-image
RUN pip3 install matplotlib
RUN pip3 install setuptools
RUN pip3 install cython
RUN pip3 install pyproj
RUN pip3 install shapely
RUN pip3 install geopandas
RUN pip3 install pandas
RUN pip3 install cmocean
RUN pip3 install geoarray
RUN pip3 install arosics

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
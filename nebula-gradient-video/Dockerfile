FROM nvidia/cuda:10.2-cudnn8-runtime-ubuntu18.04
# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8
LABEL com.nvidia.volumes.needed="nvidia_driver"
COPY environment.yaml /environment.yaml
ENV PYTHON_VERSION=3.9
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PATH=$PATH:/opt/conda/bin/
ENV USER nebula

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    vim \
    ca-certificates \
    python-qt4 \
    libjpeg-dev \
    zip \
    unzip \
    openssh-client \
    libpng-dev &&\
    apt-get install -y --no-install-recommends wget git gcc libgl1-mesa-glx && \
    apt-get install -y --no-install-recommends ffmpeg libsm6 libxext6 && \
    apt-get install -y --no-install-recommends vim nodejs python-dev python-pip && \
    rm -rf /var/lib/apt/lists/* && \
    curl -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build && \
    conda env create -f environment.yaml && \
    conda clean --all -y && \
    cd /root/.cache/ && ln -s /storage/models clip
# Create Environment
WORKDIR /notebooks
# Activate Source
#CMD source activate nebula && source ~/.bashrc
ENV PATH /opt/conda/bin:$PATH
ENV PATH /opt/conda/envs/nebula/bin:$PATH
COPY run.sh /run.sh

#CMD ["/run.sh"]

FROM ubuntu:latest
RUN cat /etc/os-release
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --yes -y --no-install-recommends dirmngr apt-transport-https ca-certificates software-properties-common gnupg2 \
    build-essential curl git \ 
    g++ gcc gfortran make autoconf automake libtool \
    zlib1g-dev liblzma-dev libbz2-dev lbzip2 libgsl-dev \
    libblas-dev libx11-dev \
    libreadline-dev libxt-dev libpcre2-dev libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*
ENV NB_USER container_user
# RUN apt-get install wget
ENV HOME /home/${NB_USER}
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
# RUN which R && R --version
RUN apt-get install wget
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && chmod +x  /tmp/miniconda.sh && bash /tmp/miniconda.sh -b -p ${HOME}/conda
# RUN bash Miniconda3-latest-Linux-x86_64.sh
ENV PATH ${HOME}/conda/bin:$PATH

# set up the user directory structure
RUN mkdir ${HOME}/tmp2 && \
    mkdir ${HOME}/analysis
    
WORKDIR ${HOME}

COPY environment.yml ${HOME}/environment.yml
RUN conda config --set always_yes yes --set changeps1 no && \
    conda create --name py2 python=3.9 
SHELL ["conda", "run", "-n", "py2", "/bin/bash", "-c"]
RUN conda install -c anaconda swig
RUN conda install -c anaconda libopenblas
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
RUN conda config --add channels R
RUN conda install -c bioconda pysam
RUN conda install -c anaconda datrie
RUN conda install qualimap
RUN conda install -c bioconda bwa
RUN conda init
RUN pip install mgatk
RUN pip install pandas argparse debugpy
# COPY cellranger-arc-2.0.2 ${HOME}/cellranger-arc-2.0.2
# RUN ls ${HOME}/
# RUN ln -s ${HOME}/cellranger-arc-2.0.2/cellranger-arc /usr/bin/cellranger-arc
# RUN which cellranger-arc

RUN echo "conda activate py2" >> ~/.bashrc
RUN echo '24 feb build' > ${HOME}/test.tmp
SHELL ["/bin/bash", "--login", "-c"]
COPY entrypoint.sh ${HOME}/
RUN ls ${HOME}/
RUN chmod +x "${HOME}/entrypoint.sh"
# ENTRYPOINT ["/home/container_user/entrypoint.sh"]
RUN mv /etc/bash.bashrc /etc/bash.bashrc_old
RUN cp /home/container_user/.bashrc /etc/bash.bashrc
CMD ["/bin/bash", "-c","bash","/home/container_user/entrypoint.sh"]
ENTRYPOINT ["/bin/bash", "-c","bash","/home/container_user/entrypoint.sh"]
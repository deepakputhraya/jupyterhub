FROM jupyterhub/jupyterhub

RUN apt-get update && apt-get install -y gnupg2 software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN apt-get update
RUN apt-get install -y curl \
        r-base \
        libopenblas-base \
        apt-utils \
        wget \
        unzip \
        libpq-dev \
        python-dev \
        build-essential \
        postgresql-server-dev-all \
        nano \
        apt-transport-https \
        vim \
        nmap \
        tree \
        libcurl4-openssl-dev \
        libxml2-dev

RUN pip install jupyter_contrib_nbextensions \
        oauthenticator \
        jupyterlab \
        ipyparallel \
        psycopg2 \
        dockerspawner

RUN ipcluster nbextension enable
RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'IRkernel','tidyverse','DBI','doparallel','RPostgreSQL','googlesheets','foreach','reshape2','jsonlite','httpuv,'gmailr','tableHTML'), type = 'source')"
RUN Rscript -e "IRkernel::installspec(user = FALSE)"

COPY docker-entrypoint docker-entrypoint
COPY jupyterhub_config.py jupyterhub_config.py
COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt
RUN jupyter contrib nbextension install --sys-prefix

RUN jupyter labextension install @krassowski/jupyterlab_go_to_definition \
        @ryantam626/jupyterlab_code_formatter \
        @jupyterlab/github \
        @jupyterlab/git \
        @oriolmirosa/jupyterlab_materialdarker \
        @jupyterlab/toc

RUN chmod +x docker-entrypoint
ENTRYPOINT ["./docker-entrypoint"]

EXPOSE 8000


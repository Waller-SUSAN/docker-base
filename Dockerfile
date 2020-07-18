FROM rocker/geospatial:4.0.2
MAINTAINER Thomas Hsiao

# install helper packages
RUN install2.r --error --deps TRUE \
    remotes \
    devtools \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# JAGS dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    jags \
    mercurial gdal-bin libgdal-dev gsl-bin libgsl-dev \ 
    libc6-i386

RUN wget -nd -P /tmp http://pj.freefaculty.org/Debian/squeeze/amd64/openbugs_3.2.2-1_amd64.deb
RUN dpkg -i /tmp/openbugs_3.2.2-1_amd64.deb && rm /tmp/openbugs_3.2.2-1_amd64.deb 

# adding deps separately so it may build in dockerhub (works on my WS)
RUN apt-get install -y r-cran-rcpp r-cran-rcppeigen

# Install rstan and Bayesian dated 07/13/2020
RUN install2.r --error --deps TRUE \
    --repos "https://cran.microsoft.com/snapshot/2020-07-13/" \
    rstan \
    loo \
    bayesplot \
    rstanarm \
    rstantools \
    shinystan \
    ggmcmc \
    tidybayes \
    brms \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# install rjags specific
RUN install2.r --error --deps TRUE \
    --repos "https://stat.ethz.ch/CRAN/" \
    rjags \
    R2jags \  
    R2OpenBUGS \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# install spatial specific
RUN install2.r --error --deps TRUE \
    CARBayes \
    CARBayesST \
    concaveman \
    ggmap \
    sparr \
    sparrpowR \
    tidycensus \
    tigris \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
 
# install tmb related packages
RUN install2.r --error --deps TRUE \
    TMB \
    glmmTMB \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN R -e "remotes::install_github('mlysy/TMBtools', dependencies = TRUE)"

# install INLA related packages
RUN Rscript -e "install.packages('INLA', repos=c('https://cloud.r-project.org/', INLA='https://inla.r-inla-download.org/R/stable'), dep=TRUE)" && \
    rm -rf /tmp/*


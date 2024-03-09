FROM quay.io/jupyter/datascience-notebook

# Extensions
RUN mamba install --yes 'jupyter_contrib_nbextensions' && \
    mamba clean --all -f -y && \
    jupyter contrib nbextension install --user && \
    # can modify or enable additional extensions here
    jupyter nbclassic-extension enable spellchecker/main --user && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install from the requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
RUN mamba install --yes --file /tmp/requirements.txt && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

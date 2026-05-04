FROM apache/spark:3.5.1

USER root

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev build-essential && \
    pip3 install jupyterlab ipykernel pyspark pandas numpy matplotlib seaborn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/spark-notebooks \
    /home/spark/.local/share/jupyter/runtime \
    /home/spark/jupyter_runtime \
    /home/spark/jupyter_data \
    /home/spark/jupyter_config && \
    chown -R spark:spark /opt/spark-notebooks /home/spark

ENV JUPYTER_RUNTIME_DIR=/home/spark/jupyter_runtime
ENV JUPYTER_DATA_DIR=/home/spark/jupyter_data
ENV JUPYTER_CONFIG_DIR=/home/spark/jupyter_config

USER spark

WORKDIR /opt/spark-notebooks

EXPOSE 8888 4040

CMD ["python3", "-m", "jupyterlab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--ServerApp.token=''", "--allow-root"]
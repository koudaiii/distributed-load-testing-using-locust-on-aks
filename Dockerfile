FROM locustio/locust:1.6.0

COPY locustfile.py /mnt/locust/locustfile.py
COPY lib /mnt/locust/lib
COPY run.sh /mnt/locust/run.sh

EXPOSE 5557 5558 8089

# Start Locust using LOCUS_OPTS environment variable
ENTRYPOINT ["bash","/mnt/locust/run.sh"]

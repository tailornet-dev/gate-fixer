echo {} > /home/kerr/service/knownDevices.config
docker exec gate git fetch && \
    git checkout package.json package-lock.json \
    && git clean -fd package.json package-lock.json

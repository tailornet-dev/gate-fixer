function installCron() {
    count="$(crontab -l | grep 'docker restart' | wc -l)"
    if [ $count -eq 0 ]; then
        crontab -l 2>/dev/null; echo "5 * * * * docker restart instathings-modbus2mqtt" | crontab -
    fi
}

installCron
configfile=/home/kerr/service/knownDevices.config
if [ ! -f "$configfile" ]; then echo {} > "$configfile"; fi
echo "fetching repo..."
docker exec gate git fetch
if [ $? -ne 0 ]; then
    echo "error fetching gate git repository"
    exit 1;
fi
docker exec gate git checkout package.json 2>/dev/null
docker exec gate git checkout package-lock.json 2>/dev/null
docker exec gate git clean -fd package.json 2>/dev/null
docker exec gate git clean -fd package-lock.json 2>/dev/null

installCron
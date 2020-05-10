#!/usr/bin/with-contenv bashio

echo "[$(date)][Info] HDD Tools start"

CONFIG_PATH=/data/options.json

HDD_PATH="$(jq --raw-output '.hdd_path' $CONFIG_PATH)"
echo "[$(date)][Info] Configuration - disk path: $HDD_PATH" 

CHECK_PERIOD="$(jq --raw-output '.check_period' $CONFIG_PATH)"
echo "[$(date)][Info] Configuration - check period: $CHECK_PERIOD" 

OUTPUT_FILE="$(jq --raw-output '.output_file' $CONFIG_PATH)"
echo "[$(date)][Info] Configuration - output file: $OUTPUT_FILE" 

mkdir -p /share/hdd_tools/

echo "[$(date)][Info] Init run"
/opt/main.sh

echo "[$(date)][Info] Cron tab update"
sed -i "s/TIME_TOKEN/$CHECK_PERIOD/g" /etc/cron.d/cron

echo "[$(date)][Info] Apply cron tab"
crontab /etc/cron.d/cron

echo "[$(date)][Info] Staring CRON"
crond -f

echo $(date) "HDD Tools exit"
#!/bin/bash
BACKUP_PATH="/data/backup/3h/"

LOG="${BACKUP_PATH}BackupCassandra.log"
WEBHOOK_FILE="${BACKUP_PATH}WebhookMessageCassandra.log"

if [ ! "$DB" ]; then
	DB="/var/lib/cassandra/data/thingsboard/"
fi

mkdir -p $BACKUP_PATH
chmod -R o+rw $BACKUP_PATH
exec > >(tee -ia $LOG $WEBHOOK_FILE)
exec 2> >(tee -ia $LOG $WEBHOOK_FILE >&2)
truncate -s 0 $WEBHOOK_FILE
find $BACKUP_PATH -mmin +890 -exec rm -f {} \; # delete backup older than *  mins

echo -e "\n---- Start Cassandra backup process at $(date +'%d-%b-%y_%H:%M') ----"

AVAIL=$(df -m "$DATASTORE" | awk '{print $4}' | tail -1)
FILESIZE=$(du -sm $DB | awk '{print int($1)}')

echo "Free space: ${AVAIL} Mb"
echo "Cassandra DB size: ${FILESIZE} Mb"

if [ "$FILESIZE" -ge "$AVAIL" ]; then
	echo " Not enought free space"
else
	echo " Enought free space, starting..."

	cqlsh -e "DESCRIBE KEYSPACE thingsboard;" > "${BACKUP_PATH}"thingsboard-describe.txt
	TARFILE=${BACKUP_PATH}$(date +'%d-%b-%y_%H-%M')-cassandra.tar
	cd "${BACKUP_PATH}" || exit
	tar -cf "${TARFILE}" -P "${DB}" thingsboard-describe.txt
	rm -rf "${BACKUP_PATH}"thingsboard-describe.txt

	TARFILE_SIZE=$(du -m "$TARFILE" | awk '{print $1}')
	echo "Completed. Backup file size: ${TARFILE_SIZE} Mb"
	if [ 1 -ge "$TARFILE_SIZE" ]; then
		echo "WARN. Backup file is less then 1 Mb"
	fi
fi
echo -e "------- Backup process finished at $(date +'%d-%b-%y_%H:%M') -------\n"

WEBHOOK_DATA="{\"text\":\"$(cat $WEBHOOK_FILE)\"}"
curl -X POST -H 'Content-type: application/json' --data "$WEBHOOK_DATA" "$WEBHOOK"

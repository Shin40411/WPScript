#!/usr/bin/bash

# declare backup & db variables filename
date=$(date +%d-%m-%Y)
file_name="backup-$date"
db_backup_name="wp-db-backup-$date"`".sql.gz"

# declare Path to WordPress Upload and folder to backup.
wp_upload_folder=$1
dest_folder=$2

# Get last backup file names into variables
LAST_WWW_BACKUP=$(ls $dest_folder/$file_name | tail -n 1)
LAST_SQL_BACKUP=$(ls $dest_folder/$db_backup_name | tail -n 1)

# Restore files
/bin/tar -xpzf $LAST_WWW_BACKUP -C /

# Restore database
/usr/bin/mysql -u MYSQL_LOGIN --password=MYSQL_PASSWORD MYSQL_DATABASE < $LAST_SQL_BACKUP

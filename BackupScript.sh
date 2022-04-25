#!/usr/bin/bash

# Create backup & db variables filename
date=$(date +%d-%m-%Y)
file_name="backup-$date"
db_backup_name="wp-db-backup-$date"`".sql.gz"

# Create Path to WordPress Upload and folder to backup.
wp_upload_folder=$1
dest_folder=$2

# Database connection info. Get these details from wp-config file.
db_name="database_name"
db_username="database_username"
db_password="database_password"

# Backup MYSQL database, gzip it and send to backup folder.
echo "Complete database backup at $db_backup_name and will be sent to $dest_folder"
echo
mysqldump --opt -u$db_username -p$db_password $db_name | gzip > $dest_folder/$db_backup_name

# Backup file procedure, zip it and send to backup folder.
echo "Complete data backup at $wp_upload_folder and will be sent to $dest_folder"
echo
zip -r $dest_folder/$file_name cd $wp_upload_folder > /dev/null

# Delete old backups
find $dest_folder -mtime +30 -delete

# Show message after backup
echo
echo "BACKUP SUCCESSFULLY!"
echo "Backup filename: $file_name"
echo "Backup DB_filename: $db_backup_name"
echo "Backup file saved at: $dest_folder"
ls -al $dest_folder
cd ~
echo

PUSHBULLET_SCRIPT="/home/fileserver/Applications/ArchServer/Services/pushbullet.sh"
RCLONE_LOG="/home/fileserver/Applications/ArchServer/Services/Backup/rclone.log"
RCLONE_EXCLUSIONS="/home/fileserver/Applications/ArchServer/config/rclone_exclusions"
BACKUP_LOG="/home/fileserver/Applications/ArchServer/Services/Backup/backup.log"
MEDIA_LOCATION="/home/fileserver/Media"
BACKUP_LOCATION="/home/fileserver/Backup"
BACKUP_FOLDERS=(Applications Books Games Movies Music Network OSInstallISO Photos Software SystemImage TVShows)
ERRORVALUE=0
RESTORE_LOG="/home/fileserver/restore.log"

BACKUP_LOCATION="/home/fileserver/Media" # The location where there are currently files that you want to restore to another location
RESTORE_LOCATION="/home/fileserver/Temporary" # The location where you want to restore files to

RESTORE_FOLDERS=(Applications Books Games Movies Music Network OldServer OSInstallISO Photos Software SystemImage TVShows)
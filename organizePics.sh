#!/bin/bash

function create_if_not_exists {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
}

# The directory where the photos are
SOURCE_DIR=$1

# The destination directory
DEST_DIR=$2

# The date pattern for the destination dir (see strftime)
DEST_DIR_PATTERN="%Y_%m_%d"

# Move all files having this extension
find "$SOURCE_DIR" -iname "*.jpg" -or -iname "*.JPG" -or -iname "*.png" -or -iname "*.PNG" -or -iname "*.mp4" -type f | while read f

do
# Obtain the creation date from the EXIF tag
year=`exiftool "$f" -CreateDate -d %Y | cut -d ':' -f 2 | sed -e 's/^[ \t]*//;s/[ \t]*$//'`;
month=`exiftool "$f" -CreateDate -d %m | cut -d ':' -f 2 | sed -e 's/^[ \t]*//;s/[ \t]*$//'`;
day=`exiftool "$f" -CreateDate -d %d | cut -d ':' -f 2 | sed -e 's/^[ \t]*//;s/[ \t]*$//'`;

# Destination paths
year_dir=$DEST_DIR/$year
month_dir=$year_dir/$month
day_dir=$month_dir/$day

create_if_not_exists $year_dir
create_if_not_exists $month_dir
create_if_not_exists $day_dir
#
# if [ ! -d $year_dir ]; then
#   mkdir $year_dir
# fi
#
# if [ ! -d $month_dir ]; then
#   mkdir $month_dir
# fi
#
# if [ ! -d $day_dir ]; then
#   mkdir $day_dir
# fi

mv -f "$f" "$day_dir"
echo "Moved $f to $day_dir"
done

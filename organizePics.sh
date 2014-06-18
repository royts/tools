#!/bin/bash


# About this script:
#   Move pics into folders by year/month/day
#   Parameters- source and destination folders

# based on: http://blog.irisquest.net/2008_05_01_archive.html

# Prerequisite:
#   sudo apt-get install libimage-exiftool-perl

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

mv -f "$f" "$day_dir"
echo "Moved $f to $day_dir"
done

#!/bin/bash
cd ~/Projects/perl-containers/

proj='Linux-Setns'
ver=$(awk '/^version:/{print $2}' $proj/META.yml)
excludes='t.pl Setns.so Makefile.old .git build.sh up-version.sh'

if [ -z "$ver" ]; then
	echo "Unable to get $poj version"
	exit 1
else
	echo "Building project $proj version $ver"
fi


if [ ! -d $proj ]; then
	echo "Unable to find $proj dir"
	exit 2
fi

for i in $excludes; do
	exclude_option="$exclude_option --exclude $i"
done

# Update the copyright year
year=$(date +%Y)
sed -i "/Copyright.*Marian/s/[0-9]\+/$year/" $proj/LICENSE $proj/lib/Linux/Setns.pm

if [ -f $proj-${ver}.tar.gz ]; then
	rm -f $proj-${ver}.tar.gz
fi

mv $proj ${proj}-$ver
tar $exclude_option -czf $proj-${ver}.tar.gz ${proj}-$ver
mv ${proj}-$ver $proj


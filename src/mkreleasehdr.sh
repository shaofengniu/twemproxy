#!/bin/sh
GIT_SHA1=`(git show-ref --head --hash=8 2> /dev/null || echo 00000000) | head -n1`
GIT_DIRTY=`git diff --no-ext-diff 2> /dev/null | wc -l`
BUILD_ID=`uname -n`"-"`date +%s`
test -f nc_release.h || touch nc_release.h
(cat nc_release.h | grep SHA1 | grep $GIT_SHA1) && \
(cat nc_release.h | grep DIRTY | grep $GIT_DIRTY) && exit 0 # Already up-to-date
echo "#define NC_GIT_SHA1 \"$GIT_SHA1\"" > nc_release.h
echo "#define NC_GIT_DIRTY \"$GIT_DIRTY\"" >> nc_release.h
echo "#define NC_BUILD_ID \"$BUILD_ID\"" >> nc_release.h
touch nc_release.c # Force recompile of nc_release.c
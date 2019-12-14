#!/usr/bin/env bash

export DEVELOPER_DIR="/Applications/XCode.app/Contents/Developer"

crashPath=""
dSYMPath=""

function findFile(){
    crashPath=$(find . -name "*.crash" -print|grep -v 'result')
}

if [ -n "$1" ]
then
    crashPath=$1
    echo "已传入crash文件路径 $crashPath"
else
    findFile
    echo "未传入crash文件路径"
fi

dSYMPath=$(find . -name "*.dSYM" -print|grep 'dSYM')

/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash "$crashPath" "$dSYMPath" > result.crash
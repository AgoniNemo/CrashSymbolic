#!/usr/bin/env bash

export DEVELOPER_DIR="/Applications/XCode.app/Contents/Developer"

crashPath=""
dSYMPath=""
symbolPath="./symbolicatecrash"

if [ ! -f "$symbolPath" ]
then
    symbolPath="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"
    if [ ! -f "$symbolPath" ]
    then
        echo "无法找到symbolicatecrash工具"
        exit
    else
        echo "symbolicatecrash文件存在"
    fi
fi


function findFile(){
    crashPath=$(find . -name "*.crash" -print|grep -v 'result')
}

if [ -n "$1" ]
then
    crashPath=$1
    echo "已传入crash文件路径 $crashPath"
else
    findFile
    echo "未传入crash文件路径,搜索同级目录下crash文件"
fi

if [ ! -f "$crashPath" ]
then
    echo "搜索失败，无法找到crash文件"
    exit
fi

dSYMPath=$(find . -name "*.dSYM" -print|grep 'dSYM')

if [ ! -f "$dSYMPath" ]
then
    echo "无法找到dSYM文件"
    exit
fi

"$symbolPath" "$crashPath" "$dSYMPath" > result.crash
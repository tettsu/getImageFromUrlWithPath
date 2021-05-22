#!/bin/bash

pushd `pwd`

# 画像のパスをinput.txtに羅列しておいてforで回す
for imageFileUrl in `cat imageUrls.txt`
do
    # URLを / で区切って配列に格納する
    array=( `echo $imageFileUrl | tr -s '/' ' '`)
    last_index=`expr ${#array[@]} - 1`

    # 固定部分である https:// と 画像ファイル名自身は不要であるため配列から削除しておく
    unset array[first_index]
    unset array[first_index+1]
    unset array[last_index]

    # 配列に入れたディレクトリ階層を一つずつ作る
    # 途中までディレクトリが同じ画像も存在するので、一つ下のディレクトリが「無い」場合だけ作る
    # 一番下まで掘ったところに入っていったら、フルURLでcurlで取得する
    for element in ${array[@]}
    do
        if [ -n $element ]; then
            mkdir -p $element
            cd $element
        fi
    done
    curl -LO $imageFileUrl

    popd

done
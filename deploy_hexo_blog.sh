#!/bin/sh
post_prefix=$(sed -n '1,15p' /Users/yangsong/Desktop/BLOG/scaffolds/post.md)

read -p 'enter a new markdown filename：' filename
echo "start create new post······"
filepath=$filename.md
fullpath=/Users/yangsong/Desktop/BLOG/source/_posts/$filepath
touch $fullpath

# todo 自动复制最新文章

if [ ! -e $fullpath ]; then
    echo "failed creating post，check your your hexo path"
    exit 0
fi

echo "$post_prefix" > $fullpath

sed -i "" -e "s/{{ title }}/$filename/" $fullpath

current_date=$(date "+%Y-%m-%d %H:%M:%S")
sed -i "" -e "s/{{ date }}/$current_date/" $fullpath

index=0
categories=()
echo "input categories, up to 2 ############################"
while [ true ]; do
    read -p "enter category, up to 2(use 'no' to end input):" category
    if [ "no" == $category ]; then
        break;
    fi
    categories[$index]=category
    # todo sed 使用追加形式，写成函数
    case $index in
        0 ) sed -i "" -e "s/一级分类/$category/" $fullpath
            ;;
        1 ) sed -i "" -e "s/二级分类/$category/" $fullpath
            ;;
    esac
    index=$(expr $index + 1)
done

index=0
tags=()
echo "input tags, up to 2 ############################"
while [ true ]; do
    read -p "enter tag, up to 2(use 'no' to end input):" tag
    if [ "no" == $tag ]; then
        break;
    fi
    tags[$index]=tag
    # todo sed 使用追加形式，写成函数
    case $index in
        0 ) sed -i "" -e "s/同级tag1/$tag/" $fullpath
            ;;
        1 ) sed -i "" -e "s/同级tag2/$tag/" $fullpath
            ;;
    esac
    index=$(expr $index + 1)
done

sed -i "" -e "s/{{ title }}/$filename/" $fullpath

read -p "relative folder(prefix: ~/Desktop/CmdMarkDown) to new post:" relative_folder
cmd_markdown_post_path=/Users/yangsong/Desktop/CmdMarkDown/${relative_folder}/$filename.md
if [ ! -e ${cmd_markdown_post_path} ]; then
    echo "${cmd_markdown_post_path}.md not exist, please check again"
    exit 0
fi
pbcopy < ${cmd_markdown_post_path}
copyed_markdown=$(pbpaste)

cd /Users/yangsong/Desktop/BLOG/source/_posts/

echo "\n\n$copyed_markdown" >> $fullpath
# sed 追加命令 格式？？？
# sed '/date/ a\ item' $fullpath

open $fullpath -a "MacDown.app"

read -p "check your post, ready to push?(y/n):" isOK

if [ "y" == $isOK -o "yes" == $isOK ]; then
    # source /Users/yangsong/Desktop/SHELL/git_ordinary.sh "文章：$filepath" "source"
    cd /Users/yangsong/Desktop/BLOG
    git add .
    git commit -m "文章：$filepath"
    echo "pushing post to repository······"
    git push origin source
fi
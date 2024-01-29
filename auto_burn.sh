#!/bin/bash

gnome-terminal -- /bin/zsh -c '
# 查找最新创建的文件夹
latest_folder=$(ls -td ~/tmp/FPGA/project/20k/*/ | head -1)

# 检查是否存在 Makefile 文件
if [ ! -f "$latest_folder/Makefile" ]; then
    # 如果不存在则复制 Makefile 文件
    cp ~/tmp/FPGA/project/20k/Makefile "$latest_folder"
fi

cd "$latest_folder"

make

exec zsh
'

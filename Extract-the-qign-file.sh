#!/bin/bash

# 获取云端文件
wget -O QSign.zip 'https://www.yuanxiapi.cn/api/lanzou/?url=https://overtimebunny.lanzoul.com/QSignAMD&type=down'

# 解压文件
unzip QSign.zip

# 输出各目录下的文件
echo -e "\e[1;36m===============\e[0m"
echo -e "\e[1;36m主目录文件\e[0m"
ls
echo -e "\e[1;36m===============\e[0m"

# 启动
bash X
exit
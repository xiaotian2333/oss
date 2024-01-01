#!/bin/bash

# 获取云端文件
wget https://oss.xt-url.com/sign.zip

# 解压文件
unzip sign.zip

# 输出各目录下的文件
echo -e "\e[1;36m===============\e[0m"
echo -e "\e[1;36m主目录文件\e[0m"
ls
echo -e "\e[1;36m===============\e[0m"
echo -e "\e[1;36mbin目录文件\e[0m"
cd bin && ls && cd ..
echo -e "\e[1;36m===============\e[0m"
echo -e "\e[1;36mlib目录文件\e[0m"
cd lib && ls && cd ..
echo -e "\e[1;36m===============\e[0m"
echo -e "\e[1;36mtxlib目录文件\e[0m"
cd txlib && ls && cd ..
echo -e "\e[1;36m===============\e[0m"
# 启动
bash app.sh

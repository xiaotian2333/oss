#!/bin/bash

# 此脚本用于解决基于ICQQ的云仔的一些登录问题
# 感谢寒暄的脚本，此脚本基于寒暄脚本修改

cd /root/Yunzai-Bot
cd Yunzai-Bot
clear
if [ -d "node_modules/icqq/lib/core" ]; then  
   echo -e "\e[1;36m  感谢选择咸鱼xiaotian\e[0m"
   echo -e "\e[1;36m  正在尝试修复\e[0m"
else  
   echo -e "\e[1;36m感谢选择咸鱼xiaotian\e[0m"
   echo -e "\e[1;31mYunzai-Bot/node_modules/icqq/lib/core文件夹不存在\e[0m"
   echo -e "\e[1;32m请在云崽根目录启动脚本\e[0m"
   exit
fi

# 获取icqq包的依赖关系树，并用awk提取出icqq的那行
result=$(npm list icqq | awk '/icqq/{print $2}')
# 将版本号以.为分隔符分成三部分，存储到数组中
IFS='.' read -ra current_version_parts <<< "$result"
IFS='.' read -ra required_version_parts <<< "0.3.15"
# 将字符型数组转换成数值型数组
for i in "${!current_version_parts[@]}"; do
    current_version_parts[$i]=$(echo "${current_version_parts[$i]}" | sed 's/[^0-9]*//g')
done
for i in "${!required_version_parts[@]}"; do
    required_version_parts[$i]=$(echo "${required_version_parts[$i]}" | sed 's/[^0-9]*//g')
done
# 比较两个版本号的大小，根据比较结果输出不同的消息
version_compare() {
    for i in "${!required_version_parts[@]}"; do
        if [ "${current_version_parts[i]}" -lt "${required_version_parts[i]}" ]; then
            echo "$result，低于要求的版本号"
            echo -e "\e[1;32m  更新至当前最新版本\e[0m"
# 规则更新
pnpm update icqq
# 判断是否执行成功
if [ $? -eq 0 ]; then
  echo -e "\e[1;36m  感谢选择咸鱼xiaotian\e[0m"
  echo -e "\e[1;36m  正在执行更新\e[0m"
else 
  sed -i -E 's/"icqq": "[^"]+"/"icqq": "^0.3.15"/' package.json
  echo "" | pnpm install -P
  # 判断是否执行成功
if [ $? -eq 0 ]; then
：
else
  read -p "\e[1;31m  失败了\e[0m"
 fi
fi
            return
        elif [ "${current_version_parts[i]}" -gt "${required_version_parts[i]}" ]; then
            echo "$result，高于要求的版本号"
            echo -e "\e[1;32m  继续运行吗\e[0m"
            read -p "按下回车键继续，否则ctrl+c"
            return
        fi
    done
    echo "$result"
    echo -e "\e[1;33m  版本是正常的\e[0m"
    echo -e "\e[1;32m  回车继续将删除设备文件并切换协议6\e[0m"
    read -p "按下回车键继续，否则ctrl+c"
}
# 调用version_compare函数
version_compare

echo -e "\e[1;33m  修改登录协议\e[0m"
# 首先，需要指定要修改的文件
file="config/config/qq.yaml"
# 然后，指定要替换的内容
old="platform: [0-6]"
new="platform: 6"
# 使用sed命令来替换文件中的内容
sed -i "s/$old/$new/g" $file
sleep 1
# 停止可能还在运行的后台云仔
echo -e "\e[1;31m  停止云仔\e[0m"
pnpm stop
npm run stop
clear
# 删除旧设备文件
read -p "按下回车键删除旧虚拟设备文件，否则ctrl+c"
echo -e "\e[1;36m  感谢选择咸鱼xiaotian\e[0m"
echo -e "\e[1;31m  正在删除\e[0m"
rm -rf data/device.json
rm -rf data/icqq
sleep 1
# 运行结束
echo -e "\e[1;36m  脚本运行完毕，请正常启动云仔\e[0m"
echo -e "\e[1;36m  感谢选择咸鱼xiaotian\e[0m"
exit
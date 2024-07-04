#!/bin/bash

# 生成8位随机字符串
random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# 安装 unzip
apt install unzip -y

# 创建 aleo 目录并进入
mkdir aleo
cd aleo || exit

# 下载 aleo262.zip 文件
wget https://github.com/likefresh/avail-sh/releases/download/sdfs/aleo262.zip

# 解压 aleo262.zip 文件
unzip aleo262.zip

# 授予执行权限
chmod +x aleo.sh
chmod +x aleo-miner

# 构建矿工命令
miner_command="./aleo.sh stratum+tcp://aleo-asia.f2pool.com:4400 aa33526666.${random_string}"

# 打印命令并运行
echo "Running miner command: $miner_command"
$miner_command

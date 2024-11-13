#!/bin/bash

logo=$(cat << 'EOF'
\033[32m
███╗   ██╗ ██████╗ ██████╗ ███████╗██████╗ ██╗   ██╗███╗   ██╗███╗   ██╗███████╗██████╗ 
████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔══██╗██║   ██║████╗  ██║████╗  ██║██╔════╝██╔══██╗
██╔██╗ ██║██║   ██║██║  ██║█████╗  ██████╔╝██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝
██║╚██╗██║██║   ██║██║  ██║██╔══╝  ██╔══██╗██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗
██║ ╚████║╚██████╔╝██████╔╝███████╗██║  ██║╚██████╔╝██║ ╚████║██║ ╚████║███████╗██║  ██║
╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
\033[0m
Подписаться на канал may.crypto{🦅}, чтобы быть в курсе самых актуальных нод - https://t.me/maycrypto
EOF
)

echo -e "$logo"

echo "Установка обновления пакетов..."
sudo apt update && sudo apt upgrade -y

echo "Загрузка исполняемого файла..."
wget https://github.com/t3rn/executor-release/releases/download/v0.22.0/executor-linux-v0.22.0.tar.gz -O executor-linux.tar.gz

echo "Распаковка архива с нодой T3rn..."
tar -xzvf executor-linux.tar.gz
cd executor || exit 1

echo "Настройка параметров среды..."
export NODE_ENV="testnet"
export LOG_LEVEL="debug"
export LOG_PRETTY="false"
export EXECUTOR_PROCESS_ORDERS="true"
export EXECUTOR_PROCESS_CLAIMS="true"

echo "Введите ваш приватный ключ от EVM кошелька..."
read -s -p "Приватный ключ: " PRIVATE_KEY_LOCAL

echo
export PRIVATE_KEY_LOCAL="$PRIVATE_KEY_LOCAL"
export ENABLED_NETWORKS="arbitrum-sepolia,base-sepolia,optimism-sepolia,l1rn"

echo "Запуск узла в screen сессии..."
cd /root/executor/executor/bin/ || exit 1
screen -dmS t3rn_node bash -c './executor; exec bash'

echo "Установка завершена. Для просмотра логов зайдите в скрин сессию: screen -r t3rn_node"

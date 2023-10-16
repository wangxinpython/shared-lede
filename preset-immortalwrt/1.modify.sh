#!/bin/sh
for configFile in $(ls target/linux/ramips/mt7621/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
#修改登录IP
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

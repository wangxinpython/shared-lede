#!/bin/sh

#修改登录IP
#sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate 

#修改主机名
#sed -i 's/OpenWrt/Xiaomi-Router/g' package/base-files/files/bin/config_generate 
#sed -i 's/OpenWrt/Phicomm-Router/g' package/base-files/files/bin/config_generate 

#修改型号显示
#sed -i 's/Xiaomi Mi Router 4A Gigabit Edition/Xiaomi 4A Gigabit/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-gigabit.dts  
#sed -i 's/Xiaomi Mi Router 3G v2/Xiaomi 3G v2/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-3g-v2.dts 
#sed -i 's/Xiaomi Redmi Router AC2100/Redmi AC2100/g' target/linux/ramips/dts/mt7621_xiaomi_redmi-router-ac2100.dts 
#sed -i 's/Xiaomi Mi Router AC2100/Xiaomi AC2100/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-ac2100.dts
#sed -i 's/Xiaomi Mi Router CR660x/Xiaomi CR660x/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-cr6606.dts

#复制smartdns配置
#rm -rf feeds/packages/net/smartdns
#rm -rf package/feeds/packages/net/smartdns
#cp -r extra-files/smartdns feeds/packages/net/

#复制uci-defaults脚本
mkdir -p files/etc/uci-defaults
cp $(dirname $0)/uci-scripts/* files/etc/uci-defaults/

#切换ramips内核到5.10
sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.10' target/linux/ramips/Makefile

#切换ramips内核到5.15
#sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.15' target/linux/ramips/Makefile

#复制内核5.10版本CPU超频补丁
#cp extra-files/322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/

# 替换默认主题为 luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile
#设置WIFI
#sed -i 's/OpenWrt/coolxiaomi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/wireless.default_radio${devidx}.encryption=none/wireless.default_radio${devidx}.encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=coolxiaomi' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=coolphicomm' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改登录密码为coolxiaomi
#sed -i '/root/croot:$1$CBd7u73H$LvSDVXLBrzpk4JfuuN.Lv1:18676:0:99999:7:::' package/base-files/files/etc/shadow
for configFile in $(ls target/linux/ramips/mt7621/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
#替换geodata源
GEODIR=package/supply-packages/small/v2ray-geodata
. extra-files/update-geodata.sh

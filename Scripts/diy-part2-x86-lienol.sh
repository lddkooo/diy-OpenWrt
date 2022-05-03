#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)



#添加温度显示
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template

#修改版本号
#modelmark=R`TZ=UTC-8 date +%Y-%m-%d -d +"1"days`''
#sed -i "s/DISTRIB_REVISION='R[0-9]*\.[0-9]*\.[0-9]*/DISTRIB_REVISION='$modelmark/g" ./package/lean/default-settings/files/zzz-default-settings

# 修改版本号-tty
#sed -i "s/timestamp/Built on '$(TZ=UTC-8 date +%Y-%m-%d -d +"1"days)'/g" ./package/base-files/files/etc/banner

# Change Argon Theme
# rm -rf ./package/lean/luci-theme-argon 
#rm -rf ./feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/luci-app-argon-config

# Change default BackGround img
# rm ./package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
#wget -O ./package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://github.com/jiawm/My-OpenWrt-by-Lean/raw/main/BackGround/2.jpg
#svn co https://github.com/xylz0928/luci-mod/trunk/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons ./package/lucimod
#mv package/lucimod/* feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/


#更换默认主题为argon，并删除bootstrap主题 
#sed -i 's#luci-theme-bootstrap#luci-theme-argon#g' feeds/luci/collections/luci/Makefile
#sed -i 's/bootstrap/argon/g' feeds/luci/modules/luci-base/root/etc/config/luci

# Change default theme
#sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile


# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了，其他的不要动
sed -i 's/192.168.1.1/192.168.100.102/g' package/base-files/files/bin/config_generate

# Remove the default apps 移除默认编译app，不是移除app
sed -i 's/luci-app-zerotier //g' target/linux/x86/Makefile
sed -i 's/luci-app-unblockmusic //g' target/linux/x86/Makefile
sed -i 's/luci-app-xlnetacc //g' target/linux/x86/Makefile
sed -i 's/luci-app-jd-dailybonus //g' target/linux/x86/Makefile
sed -i 's/luci-app-ipsec-vpnd //g' target/linux/x86/Makefile
sed -i 's/luci-app-adbyby-plus //g' target/linux/x86/Makefile
sed -i 's/luci-app-sfe //g' target/linux/x86/Makefile
sed -i 's/luci-app-uugamebooster//g' target/linux/x86/Makefile
sed -i 's/-luci-app-flowoffload//g' target/linux/x86/Makefile
sed -i 's/kmod-drm-amdgpu \\/kmod-drm-amdgpu/g' target/linux/x86/Makefile


# 注释默认防火墙规则
#sed -i "s/echo 'iptables/echo '# iptables/g" ./package/lean/default-settings/files/zzz-default-settings
#sed -i "s/echo '\[ -n/echo '# \[ -n/g" ./package/lean/default-settings/files/zzz-default-settings


# Add WOL Plus
svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus ./package/luci-app-wolplus
chmod -R 755 ./package/luci-app-wolplus/*

#  git lua-maxminddb 依赖
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb

# 整理固件包时候,删除您不想要的固件或者文件,让它不需要上传到Actions空间（根据编译机型变化,自行调整删除的固件名称）
cat >${GITHUB_WORKSPACE}/Clear <<-EOF
rm -rf packages
rm -rf config.buildinfo
rm -rf feeds.buildinfo
rm -rf openwrt-x86-64-generic-kernel.bin
rm -rf openwrt-x86-64-generic.manifest
rm -rf openwrt-x86-64-generic-squashfs-rootfs.img.gz
rm -rf sha256sums
rm -rf version.buildinfo
EOF

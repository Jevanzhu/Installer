#!/bin/bash
#
# Caddy 安装配置脚本
#
#定义配置文件路径

if [[ -e "/usr/local/bin/caddy" ]]; then
	echo ""
	echo "删除已有Caddy。"
    systemctl disable caddy
	rm -rf /usr/local/bin/caddy
    rm -rf /etc/caddy
    rm -rf /var/log/caddy
    rm -rf /etc/systemd/system/caddy.service
fi
echo ""
echo "开始安装Caddy"
cd /tmp
wget -q https://raw.githubusercontent.com/Jevanzhu/Installer/main/Caddy-Installer/caddy-1.0.5+F
chmod +x caddy-1.0.5+F; mv caddy-1.0.5+F /usr/local/bin/caddy;
mkdir /etc/caddy
touch /etc/caddy/Caddyfile
chown -R root:www /etc/caddy
echo "创建LOG目录"
mkdir /var/log/caddy
chown www:www /var/log/caddy
echo "创建WWW网站目录"
mkdir /var/www
chown www:www /var/www
echo "创建SSL证书目录"
mkdir /etc/ssl/caddy
chown -R www:root /etc/ssl/caddy
chmod 0770 /etc/ssl/caddy
echo "配置systemd"
curl -s https://raw.githubusercontent.com/Jevanzhu/Installer/main/Caddy-Installer/caddy.service -o /etc/systemd/system/caddy.service
systemctl daemon-reload
systemctl enable caddy.service
echo "设置端口绑定权限，Setcap命令"
setcap cap_net_bind_service=+ep /usr/local/bin/caddy
getcap /usr/local/bin/caddy
echo "安装完成"
echo "配置完Caddyfile后使用systemctl start caddy命令启动Caddy"
exit;
#!/bin/sh
ip="IPHERE"
echo "Checking for unzip - required to install some things"
zip=`dpkg --get-selections | grep unzip`
if [ "$zip" = "" ]; then
	echo "unzip not found, attempting to install - you will need to either be root or know your password for sudo"
	echo "If this results in an error, you need to contact the administrator of your server to get unzip installed"
	sudo apt-get install unzip
else
	echo "unzip found"
fi
echo ""
echo "Game type? (CS:GO or TF2)"
read gametype
echo "Server name?"
read name
echo "Port?"
read port
echo "RCON password?"
read password

mkdir $name

if [ ! -d runscripts ];then
	mkdir runscripts
	echo "runscripts directory created"
fi
if [ ! -s steamcmd_linux.tar.gz ]; then
	wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
	tar -xvzf steamcmd_linux.tar.gz
	echo "Got steamcmd"
fi
touch runscripts/$name
chmod 777 runscripts/$name
if [ "$gametype" = "TF2" ]; then
	echo "login anonymous" >> runscripts/$name
	echo "force_install_dir $name" >> runscripts/$name
	echo "app_update 232250 validate" >> runscripts/$name
	echo "quit" >> runscripts/$name
elif [ "$gametype" = "CS:GO" ]; then
	echo "login anonymous" >> runscripts/$name
	echo "force_install_dir $name" >> runscripts/$name
	echo "app_update 740" >> runscripts/$name
	echo "quit" >> runscripts/$name
else
	echo "Invalid game type - ending script (CS:GO and TF2 are case sensitive)"
	exit 0
fi


./steamcmd.sh +runscript runscripts/$name
if [ "$gametype" = "TF2" ]; then
	echo "TF2 installed"
elif [ "$gametype" = "CS:GO" ]; then
	echo "CS:GO installed"
fi
if [ "$gametype" = "TF2" ]; then
	cd $name/tf/
	wget https://github.com/TF2Center/server-configs/archive/master.zip
	unzip master.zip
	rm master.zip
	cd cfg
	touch server.cfg
	echo "rcon_password $password" > server.cfg
	wget http://ugcleague.com/files/configs/UGC_6v6_cfg_and_whitelist_v050714.zip
	unzip UGC_6v6*
	wget http://ugcleague.com/files/configs/UGC_HL_cfg_and_whitelist_v050714.zip
	unzip UGC_HL*
	echo "Configs installed"
	cd maps
	wget http://downloads.tf2center.com/tf/maps/koth_pro_viaduct_rc4.bsp
	wget http://downloads.tf2center.com/tf/maps/koth_ashville_rc1.bsp
	wget http://downloads.tf2center.com/tf/maps/koth_coalplant_b7.bsp
	wget http://downloads.tf2center.com/tf/maps/pl_borneo_rc3.bsp
	wget http://downloads.tf2center.com/tf/maps/pl_swiftwater_ugc.bsp
	echo "Competitive maps installed"
	cd ..
	if [ ! -d addons ];then
		mkdir addons
	fi
	wget http://newyork.download.maverickservers.com/source/mmsource-1.10.0-linux.tar.gz
	tar -xvzf mmsource-1.10.0-linux.tar.gz
	rm mmsource-1.10.0-linux.tar.gz
	wget http://y4kstudios.com/sourcemod/mirror/sourcemod-1.5.3-linux.tar.gz
	tar -xvzf sourcemod-1.5.3-linux.tar.gz
	rm sourcemod-1.5.3-linux.tar.gz
	cd ..
	wget https://bitbucket.org/jcristiano/sizzlingplugins/downloads/SizzlingStats_0.9.4.1.zip
	unzip SizzlingStats_0.9.4.1.zip
	rm SizzlingStats_0.9.4.1.zip
	touch run.sh
	chmod +x run.sh
	touch run_tf2.sh
	chmod +x run_tf2.sh
	echo "./srcds_run +ip $ip -port $port +map pl_badwater.bsp +maxplayers 24" > run_tf2.sh
	echo "screen -S $name -s ./run_tf2.sh" > run.sh
	touch end.sh
	chmod +x end.sh
	echo "screen -X -S $name quit" > end.sh
	touch update.sh
	chmod +x update.sh
	echo "name=`echo ${PWD##*/}`" >> update.sh
	echo "cd .." >> update.sh
	echo "./steamcmd.sh +runscript runscripts/$name" >> update.sh
	echo "TF2 server installation done!"
	echo "Use the scripts in the $name directory to start/stop/update the server!"
	echo "./start.sh - starts the server"
	echo "./end.sh - stops the server"
	echo "./update.sh - updates the version of tf2 on the server"
elif [ "$gametype" = "CS:GO" ];then
	cd $name/csgo/cfg
	touch server.cfg
	echo "hostname Counter-Strike: Global Offensive Dedicated Server" >> server.cfg
	echo "rcon_password $password" >> server.cfg
	cd ../../../
	cp run_csgo.sh $name/run_csgo.sh
	echo "screen -S $name -s ./run_csgo.sh" > $name/run.sh
	echo "screen -X -S $name quit" > $name/end.sh
	chmod +x $name/run_csgo.sh
	chmod +x $name/run.sh
	chmod +x $name/end.sh
	cp update.sh $name/update.sh
	chmod +x $name/update.sh
	echo "CS:GO server installation done!"
fi

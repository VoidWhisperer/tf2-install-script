echo "Gamemode? (Casual,Competitive, Arms race, Demolition, Deathmatch)"
read gamemode
if [ "$gamemode" = "Casual" ]; then
	./srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_bomb +map de_dust
elif [ "$gamemode" = "Competitive" ]; then
	./srcds_run -game csgo -console -usercon +game_type 0 +game_mode 1 +mapgroup mg_bomb_se +map de_dust2_se
elif [ "$gamemode" = "Arms race" ]; then
	./srcds_run -game csgo -console -usercon +game_type 1 +game_mode 0 +mapgroup mg_armsrace +map ar_shoots
elif [ "$gamemode" = "Demolition" ]; then
	./srcds_run -game csgo -console -usercon +game_type 1 +game_mode 1 +mapgroup mg_demolition +map de_lake
elif [ "$gamemode" = "Deathmatch" ]; then
	./srcds_run -game csgo -console -usercon +game_type 1 +game_mode 2 +mapgroup mg_allclassic +map de_dust
else
	echo "Invalid game type"
	exit 0
fi


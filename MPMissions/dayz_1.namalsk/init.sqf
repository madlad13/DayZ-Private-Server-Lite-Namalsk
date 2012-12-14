startLoadingScreen ["","DayZ_loadingScreen"];
enableSaving [false, false];

dayZ_hivePipe1 = 	"\\.\pipe\dayz";
dayZ_instance =	1;
hiveInUse	=	true;
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

dzn_ns_bloodsucker = true;		// Make this falso for disabling bloodsucker spawn
ns_blowout = true;			// Make this false for disabling random EVR discharges (blowout module)
ns_blowout_dayz = true;		// Leave this always true or it will create a very huuuge mess
dayzNam_buildingLoot = "CfgBuildingLootNamalsk";	// can be CfgBuildingLootNamalskNOER7 (function of this pretty obvious), CfgBuildingLootNamalskNOSniper (CfgBuildingLootNamalskNOER7 + no sniper rifles), default is CfgBuildingLootNamalsk

call compile preprocessFileLineNumbers "\nst\ns_dayz\code\init\variables.sqf";
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\nst\ns_dayz\code\init\compiles.sqf";
progressLoadingScreen 1.0;

player setVariable ["BIS_noCoreConversations", true];
enableRadio false;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if ((!isServer) && (isNull player) ) then {
	waitUntil {!isNull player};
	waitUntil {time > 3};
};

if ((!isServer) && (player != player)) then {
  waitUntil {player == player};
  waitUntil {time > 3};
};

if (isServer) then {
	hiveInUse	=	true;
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
 if (isClass (configFile >> "CfgBuildingLootNamalsk")) then {
  0 fadeSound 0;
  0 cutText [(localize "STR_AUTHENTICATING"), "BLACK FADED",60];
  _id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
  _playerMonitor =  [] execVM "\nst\ns_dayz\code\system\player_monitor.sqf";
 } else {
 endLoadingScreen;
 0 fadeSound 0;
 0 cutText ["You are running an incorrect version of DayZ: Namalsk, please download newest version from http://www.nightstalkers.cz/", "BLACK"];
 };
};

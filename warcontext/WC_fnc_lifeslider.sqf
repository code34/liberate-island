	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - Print life slider
	// -----------------------------------------------

	if (!local player) exitWith {};

	waituntil {!isnil "wcscoreT"};
	waituntil {!isnil "wctimemax"};

	disableSerialization;

	#define WCTEXTHEIGHT	0.15
	#define WCSLIDERHEIGHT	0.15
	#define	WCTIMEHEIGHT	0.15

	#define WCTEXTWIDTH	0.30
	#define	WCSLIDERWIDTH	0.28
	#define	WCTIMEWIDTH	0.30

	#define WCTEXTW		0.80
	#define	WCSLIDERX	0.81
	#define	WCTIMEX		0.80

	#define	WCTIMEY		0.12
	#define	WCSLIDERY	0.08
	#define WCTEXTY		0.04

	private ["_ctrl", "_currentdisplay", "_control", "_controlpos", "_lastscore"];

	_lastscore = 0;

	while {!wcgameend} do {
		if (wcscoreT != _lastscore) then {
			_lastscore = wcscoreT;
			cutrsc ["infomessage", "PLAIN"];
			_ctrl = (uiNamespace getVariable 'wcdisplay') displayCtrl 10101;
			_ctrl ctrlSetText format["Civils rescued: %1/ %2", wcscoreT, wccivilnumber];
			_ctrlpos = ctrlPosition _ctrl;
			_ctrlpos set[ 0 , (safeZoneX + safeZoneW) - WCTEXTWIDTH - 0.01];
			_ctrlpos set[ 1 ,  WCTEXTHEIGHT - (safeZoneH + safeZoneY - 1.12)];
			_ctrl ctrlSetPosition _ctrlpos;
			_ctrl ctrlCommit 0;
	
			_ctrl = (uiNamespace getVariable 'wcdisplay') displayCtrl 10102;
			_ctrl SliderSetRange[ 0, wccivilnumber];
			_ctrl SliderSetPosition wcscoreT;
			_ctrlpos = ctrlPosition _ctrl;
			_ctrlpos set[ 0 , (safeZoneX + safeZoneW) - WCSLIDERWIDTH - 0.02];
			_ctrlpos set[ 1 ,  WCSLIDERHEIGHT - (safeZoneH + safeZoneY - 1.16)];
			_ctrl ctrlSetPosition _ctrlpos;
			_ctrl ctrlCommit 0;
		
			if (wcscoreT > wcscoreT * 0.75) then {
				_ctrl ctrlSetForegroundColor [0, 1, 0, 1];
			} else {
				if (wcscoreT > wcscoreT * 0.50) then {
					_ctrl ctrlSetForegroundColor [0,0,1,1];
				} else {
					if (wcscoreT > wcscoreT * 0.25) then {
						_ctrl ctrlSetForegroundColor [1, 1, 0, 1];
					} else {
						_ctrl ctrlSetForegroundColor [1,0,0,1];
					};
				};
			};
			_ctrl ctrlCommit 0;
		
			_ctrl = (uiNamespace getVariable 'wcdisplay') displayCtrl 10103;
			_ctrl ctrlSetText format["Score: %1 Points", wcglobalscore];		
			_ctrlpos = ctrlPosition _ctrl;
			_ctrlpos set[ 0 , (safeZoneX + safeZoneW) - WCTIMEWIDTH - 0.01];
			_ctrlpos set[ 1 ,  WCTIMEHEIGHT - (safeZoneH + safeZoneY - 1.20)];
			_ctrl ctrlSetPosition _ctrlpos;
			_ctrl ctrlCommit 0;
		};
		sleep 2;
	};
	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------
	if (!local player) exitWith {};

	private [
		"_list",
		"_vehicle",
		"_para",
		"_object",
		"_position",
		"_mydir"
		];

	_vehicle = vehicle player;

	if(typeof _vehicle != "ACE_HC130_N" and _vehicle != player) exitwith {hint 'you are not in hercule'};

	if (!surfaceIsWater (position _vehicle)) then {
		if ((getposatl _vehicle) select 2 > 70) then {
			_para = "ParachuteBigWest" createVehicle [(getposatl _vehicle) select 0, (getposatl _vehicle) select 1,((getposatl _vehicle) select 2) - 20];
			_object = "ACE_ATV_Honda" createVehicle [(getposatl _vehicle) select 0, (getposatl _vehicle) select 1, ((getposatl _vehicle) select 2) - 25];
			_para setpos [(getposatl _vehicle) select 0, (getposatl _vehicle) select 1,((getposatl _vehicle) select 2) - 20];
			_object setpos [(getposatl _vehicle) select 0, (getposatl _vehicle) select 1,((getposatl _vehicle) select 2) - 25];		
			_object attachTo [_para,[0,0,0],"paraEnd"];
			waituntil {((((position _object) select 2) < 0.6) || (isNil "_para"))};
			detach _object;
			_object SetVelocity [0,0,-5];
			sleep 0.3;
			_object setPos [(position _object) select 0, (position _object) select 1, 0];
			sleep 2;
			if (wcplayerside == wcside) then {
				wcatvpositionW = getpos _object;
				publicvariable 'wcatvpositionW';
				wcgarbage = [wcatvpositionW] spawn WC_fnc_createatv;
			} else {
				wcatvpositionE = getpos _object;
				publicvariable 'wcatvpositionE';
				wcgarbage = [wcatvpositionE] spawn WC_fnc_createatv;
			};
			hint "Drop is finished"; 
		} else {
				if ((getpos _vehicle) select 2 < 1) then {
					_mydir = getdir _vehicle;
					_position =  [(getpos _vehicle select 0) + (sin _mydir * 10), (getpos _vehicle select 1) + (cos _mydir * 10)];
					_object = "ACE_ATV_Honda" createVehicle _position;
					wcatvposition = _position;
					if (wcplayerside == wcside) then {
						wcatvpositionW = getpos _object;
						publicvariable 'wcatvpositionW';
						wcgarbage = [wcatvpositionW] spawn WC_fnc_createatv;
					} else {
						wcatvpositionE = getpos _object;
						publicvariable 'wcatvpositionE';
						wcgarbage = [wcatvpositionE] spawn WC_fnc_createatv;
					};
					_vehicle setVariable ["wcatv", false, true];
					hint "Drop is finished";
				} else {
					hint "The altitude is not enough High";
				};
		};
	} else {
		hint "Cannot paradrop over sea !";
	};
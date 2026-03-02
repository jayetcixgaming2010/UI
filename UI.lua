             _G.FastAttack = true;

             if _G.FastAttack then

             local _ENV = (getgenv or getrenv or getfenv)();

             local function v0(v35, v36)

             local v37, v38 = pcall(function()

             return v35:WaitForChild(v36);

             end);

             return v38;

             end

             local function v1(v39, ...)

             local v40 = v39;

             for v60, v61 in {...} do

		  	 v40 = v40:FindFirstChild(v61) or v0(v40, v61);			 if not v40 then

			 break;

			 end

			 end

			 return v40;

			 end

			 local v2 = game:GetService("VirtualInputManager");

			 local v3 = game:GetService("CollectionService");

			 local v4 = game:GetService("ReplicatedStorage");

			 local v5 = game:GetService("TeleportService");

			 local v6 = game:GetService("RunService");

			 local v7 = game:GetService("Players");

			 local v8 = v7.LocalPlayer;

			 local v9 = v0(v4, "Remotes");

			 if not v9 then

			 return;

			 end

			 local v10 = v0(v9, "Validator");

			 local v11 = v0(v9, "CommF_");

			 local v12 = v0(v9, "CommE");

			 local v13 = v0(workspace, "ChestModels");

			 local v14 = v0(workspace, "_WorldOrigin");

			 local v15 = v0(workspace, "Characters");

			 local v16 = v0(workspace, "Enemies");

			 local v17 = v0(workspace, "Map");

			 local v18 = v0(v14, "EnemySpawns");

			 local v19 = v0(v14, "Locations");

			 local v20 = v6.RenderStepped;

			 local v21 = v6.Heartbeat;

			 local v22 = v6.Stepped;

			 local v23 = v0(v4, "Modules");

			 local v24 = v0(v23, "Net");

			 local v25 = sethiddenproperty or function(...)

			 return ...;

			 end;

			 local v26 = setupvalue or (debug and debug.setupvalue);

			 local v27 = getupvalue or (debug and debug.getupvalue);

			 local v28 = {AutoClick=true,ClickDelay=0};

			 local v29 = {};

			 v29.AttackCooldown = 0;

			 v29.Connections = {};

			 v29.IsAlive = function(v41)

			 return v41 and v41:FindFirstChild("Humanoid") and (v41.Humanoid.Health > 0);

			 end;

			 local function v33(v42)

			 return v42 ~= v8;

			 end

			 v29.FastAttack = (function()

			 if _ENV.rz_FastAttack then

			 return _ENV.rz_FastAttack;

			 end

			 local v43 = {Distance=100,attackMobs=true,attackPlayers=true,Equipped=nil,Debounce=0,ComboDebounce=0,M1Combo=0,EnemyRootPart=nil,HitboxLimbs={"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}};

			 local v44 = v0(v24, "RE/RegisterAttack");

			 local v45 = v0(v24, "RE/RegisterHit");

			 local v46 = v0(v4, "Events");

			 local v47, v48 = pcall(function()

			 return require(v23.Flags).COMBAT_REMOTE_THREAD or false;

			 end);

			 local v49;

			 task.defer(function()

			 local v62 = v8:WaitForChild("PlayerScripts");

			 local v63 = v62:FindFirstChildOfClass("LocalScript");

			 while not v63 do

			 v8.PlayerScripts.ChildAdded:Wait();

			 v63 = v62:FindFirstChildOfClass("LocalScript");

			 end

			 if getsenv then

			 local v126, v127 = pcall(getsenv, v63);

			 if (v126 and v127) then

			 v49 = v127._G.SendHitsToServer;

			 end

			 end

			 end);

			 v43.Process = function(v64, v65, v66, v67, v68, v69)

			 if not v65 then

			 return;

			 end

			 local v70 = v64.HitboxLimbs;

			 local v71 = v66:GetChildren();

			 for v114 = 1, #v71 do

			 local v115 = v71[v114];

			 local v116 = v115:FindFirstChild(v70[math.random(#v70)]) or v115:FindFirstChild("HumanoidRootPart") or v115.PrimaryPart;

			 if not v116 then

			 continue;

			 end

			 local v117 = (v115.Parent == v15) and v33(v7:GetPlayerFromCharacter(v115));

			 if ((v115 ~= v8.Character) and ((v115.Parent ~= v15) or v117)) then

			 if (v29.IsAlive(v115) and ((v68 - v116.Position).Magnitude <= v69)) then

			 if not v64.EnemyRootPart then

			 v64.EnemyRootPart = v116;

			 else

			 table.insert(v67, {v115,v116});

			 end

			 end

			 end

			 end

			 end;

			 v43.GetAllBladeHits = function(v72, v73, v74)

			 local v75 = v73:GetPivot().Position;

		 	 local v76 = {};

			 v74 = v74 or v72.Distance;

			 v72:Process(v72.attackMobs, v16, v76, v75, v74);

			 v72:Process(v72.attackPlayers, v15, v76, v75, v74);

			 return v76;

	  	     end;

		     v43.GetClosestEnemy = function(v77, v78, v79)

			 local v80 = v77:GetAllBladeHits(v78, v79);

			 local v81, v82 = math.huge;

			 for v118 = 1, #v80 do

			 local v119 = (v82 and (v82.Position - v80[v118][2].Position).Magnitude) or v81;

			 if (v119 <= v81) then

			 v81, v82 = v119, v80[v118][2];

			 end

			 end

			 return v82;

		     end;

	    	 v43.GetCombo = function(v83)

		  	 local v84 = (((tick() - v83.ComboDebounce) <= 0.4) and v83.M1Combo) or 0;

			 v84 = ((v84 >= 4) and 1) or (v84 + 1);

			 v83.ComboDebounce = tick();

			 v83.M1Combo = v84;

			 return v84;

			 end;

		     v43.UseFruitM1 = function(v87, v88, v89, v90)

			 local v91 = v88:GetPivot().Position;

			 local v92 = v16:GetChildren();

			 for v120 = 1, #v92 do

			 local v121 = v92[v120];

			 local v122 = v121.PrimaryPart or v121:FindFirstChild("HumanoidRootPart");

			 if (v29.IsAlive(v121) and v122 and ((v122.Position - v91).Magnitude <= 50)) then

			 local v132 = (v122.Position - v91).Unit;

			 return v89.LeftClickRemote:FireServer(v132, v90);

			 end

			 end

		     end;

		     v43.UseNormalClick = function(v93, v94, v95, v96)

			 v93.EnemyRootPart = nil;

			 local v98 = v93:GetAllBladeHits(v95);

			 local v99 = v93.EnemyRootPart;

			 if v99 then

			 if (v47 and v48 and v49) then

			 v44:FireServer(v96);

			 v49(v99, v98);

			 elseif (v47 and not v48) then

			 v44:FireServer(v96);

			 v45:FireServer(v99, v98);

	 		 else

			 v2:SendMouseButtonEvent(0, 0, 0, true, game, 1);

			 task.wait(0.05);

			 v2:SendMouseButtonEvent(0, 0, 0, false, game, 1);

			 end

			 end

			 end;

			 v43.CheckStun = function(v100, v101, v102, v103)

			 local v104 = {"Stun","Stun Value","StunValue"};

			 for v123, v124 in ipairs(v104) do

			 local v125 = v102:FindFirstChild(v124);

			 if (v125 and (v125.Value > 0)) then

			 return false;

			 end

			 end

			 return true;

			 end;

			 v43.Attack = function(v105)

			 if (not v28.AutoClick or ((tick() - v29.AttackCooldown) <= 1)) then

			 return;

			 end

			 if not v29.IsAlive(v8.Character) then

			 return;

			 end

			 local v106 = v8.Character;

			 local v107 = v106.Humanoid;

			 local v108 = v106:FindFirstChildOfClass("Tool");

			 local v109 = v108 and v108.ToolTip;

			 local v110 = v108 and v108.Name;

			 if (not v108 or ((v109 ~= "Melee") and (v109 ~= "Blox Fruit") and (v109 ~= "Sword"))) then

			 return nil;

			 end

			 local v111 = (v108:FindFirstChild("Cooldown") and v108.Cooldown.Value) or 0.3;

			 if (((tick() - v105.Debounce) >= v111) and v105:CheckStun(v109, v106, v107)) then

			 local v128 = v105:GetCombo();

			 v111 = v111 + (((v128 >= 4) and 0.05) or 0);

			 v105.Equipped = v108;

			 v105.Debounce = ((v128 >= 4) and (tick() + 0.05)) or tick();

			 if (v109 == "Blox Fruit") then

			 if ((v110 == "Ice-Ice") or (v110 == "Light-Light")) then

			 return v105:UseNormalClick(v107, v106, v111);

			 elseif v108:FindFirstChild("LeftClickRemote") then

			 return v105:UseFruitM1(v106, v108, v128);

			 end

			 else

			 return v105:UseNormalClick(v107, v106, v111);

			 end

			 end

			 end;

			 v43.AttackNearest = function(v112)

			 v112:Attack();

			 end;

			 v43.BladeHits = function(v113)

			 v113:Attack();

			 end;

			 task.spawn(function()

			 while task.wait(v28.ClickDelay) do

			 if v28.AutoClick then

			 v43:Attack();

			 end

			 end

			 end);

			 table.insert(v29.Connections, v22:Connect(function()

			 v43:Attack();

			 end));

			 _ENV.rz_FastAttack = v43;

			 return v43;

			 end)();

			 end

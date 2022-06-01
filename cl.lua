-- https://runtime.fivem.net/doc/natives/?_0x29439776AAA00A62
local vehicleClassWhitelist = {0, 1, 2, 3, 4, 5, 6, 7, 9}

local handleMods = {
	{"fInitialDragCoeff", 90.22},
	{"fDriveInertia", .31},
	{"fSteeringLock", 22},
	{"fTractionCurveMax", -1.1},
	{"fTractionCurveMin", -.4},
	{"fTractionCurveLateral", 2.5},
	{"fLowSpeedTractionLossMult", -.57}
}

actionKeyPressed = IsControlJustReleased(0, 21)

local driftMode = false

Citizen.CreateThread( function()
	while true do
		Wait(1)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		local GetVehicleHandlingFloat = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront")
		local isWhitelisted = IsVehicleClassWhitelisted(GetVehicleClass(vehicle))
		local getDriver = GetPedInVehicleSeat(vehicle, -1)

		if IsPedInAnyVehicle(ped) then
			if (getDriver == ped) then			 
				if vehHandlingFloat ~= 1 and IsVehicleOnAllWheels(vehicle) and actionKeyPressed and isWhitelisted then
					ToggleDrift(vehicle)
				end
				if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
					SetVehicleEnginePowerMultiplier(vehicle, 0.0)
				else
					if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") == 0.0 then
						SetVehicleEnginePowerMultiplier(vehicle, 190.0)
					else
						SetVehicleEnginePowerMultiplier(vehicle, 100.0)
					end
				end
			end
		end
	end
end)

function ToggleDrift(vehicle)
	local modifier = 1
	local GetVehicleHandlingFloat = GetVehicleHandlingFloat(vehicle, "CHandlingData")
	
	if GetVehicleHandlingFloat > 90 then
		driftMode = true
	else 
		driftMode = false
	end
	
	if driftMode then
		modifier = -1
	end
	
	for index, value in ipairs(handleMods) do
		SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat, value[1]) + value[2] * modifier)
	end
	
	if driftMode then
		
		PrintDebugInfo("stock")
		DrawNotif("~y~TCS~s~, ~y~ABS~s~, ~y~ESP ~s~is ~g~on~s~!\nVehicle is in standard mode!")
	else
		
		PrintDebugInfo("drift")
		DrawNotif("~y~TCS~s~, ~y~ABS~s~, ~y~ESP ~s~is ~r~OFF~s~!\nEnjoy driving sideways!")
	end
	
end

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function PrintDebugInfo(mode)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	local GetVehicleHandlingFloat = GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1])
	print(mode)
	for index, value in ipairs(handleMods) do
		print(GetVehicleHandlingFloat)
	end
end

function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
		if value == vehicleClass then
			return true
		end
	end

	return false
end

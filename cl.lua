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

local ped, vehicle

Citizen.CreateThread( function()
	while true do
		Wait(1)
		ped = GetPlayerPed(-1)

		if IsPedInAnyVehicle(ped) then
			vehicle = GetVehiclePedIsIn(ped, false)
			if GetPedInVehicleSeat(vehicle, -1) == ped and IsVehicleOnAllWheels(vehicle) and IsControlJustReleased(0, 21) and IsVehicleClassWhitelisted(GetVehicleClass(vehicle)) then
				if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") >= 50.0 then
					DriftOff()
				else
					DriftOn()
				end
			end
		end
	end
end)

function DriftOff()
	local currentEngineMod = GetVehicleMod(vehicle, 11)
	for index, value in ipairs(handleMods) do
		SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1])-value[2])
	end
	SetVehicleEnginePowerMultiplier(vehicle, 0.0)
	SetVehicleModKit(vehicle, 0)
	SetVehicleMod(vehicle, 11, currentEngineMod, true)

	PrintDebugInfo('stock')

	DrawNotification('~y~TCS~s~, ~y~ABS~s~, ~y~ESP ~s~is ~g~on~s~!')
	DrawNotification('Vehicle is in standard mode!')
end

function DriftOn()
	for index, value in ipairs(handleMods) do
		SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1])+value[2])
	end
	if GetHandlingfDriveBiasFront == 0.0 then
		SetVehicleEnginePowerMultiplier(vehicle, 190.0)
	else
		SetVehicleEnginePowerMultiplier(vehicle, 100.0)
	end

	PrintDebugInfo('drift')

	DrawNotification('~y~TCS~s~, ~y~ABS~s~, ~y~ESP ~s~is ~r~OFF~s~!')
	DrawNotification('Enjoy driving sideways!')
end

function DrawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function PrintDebugInfo(mode)
	print(mode)
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
end

function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
		if value == vehicleClass then
			return true
		end
	end

	return false
end

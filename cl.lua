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

Citizen.CreateThread( function()
	while true do
		Wait(1)
	
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(ped, false)
		local driver = GetPedInVehicleSeat(vehicle, -1)
	
		if IsPedInAnyVehicle(ped) then	
			if driver == ped and IsVehicleOnAllWheels(vehicle) then
				if IsControlJustReleased(0, 21) and IsVehicleClassWhitelisted(GetVehicleClass(vehicle)) then
					if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") >= 50.0 then
						DriftOff()
					else
						DriftOn()
					end
			end	
			end
		end
	end
end)

function DriftOff()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)

	local currentEngineMod = GetVehicleMod(vehicle, 11)

	drawNotification('~y~TCS~s~, ~y~ABS~s~, ~y~ESP ~s~is ~g~on~s~!')
	drawNotification('Vehicle is in standard mode!')
	for index, value in ipairs(handleMods) do
		SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1])-value[2])
	end
	SetVehicleEnginePowerMultiplier(vehicle, 0.0)					
	SetVehicleModKit(vehicle, 0)
	SetVehicleMod(vehicle, 11, currentEngineMod, true)

	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
	print('stock')
end

function DriftOn()	
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)

	--not a drift handling? let's make it		
	drawNotification('~y~TCS~s~, ~y~ABS~s~, ~y~ESP ~s~is ~r~OFF~s~!')
	drawNotification('Enjoy driving sideways!')
	for index, value in ipairs(handleMods) do
		SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1])+value[2])
	end
	if GetHandlingfDriveBiasFront == 0.0 then
		SetVehicleEnginePowerMultiplier(vehicle, 190.0)
	else
		SetVehicleEnginePowerMultiplier(vehicle, 100.0)
	end
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
	print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
	print('drift')
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
        if value == vehicleClass then
            return true
        end
    end

    return false
end

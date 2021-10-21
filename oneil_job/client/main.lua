local PlayerData, GUI, CurrentActionData, JobBlips = {}, {}, {}, {}
local HasAlreadyEnteredMarker, publicBlip = false, false
local LastZone, CurrentAction, CurrentActionMsg
ESX = nil
GUI.Time = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenOneilActionsMenu()
	local elements = {
		{label = 'Annonce', value = 'annonce'},
		{label = 'Placer Objet', value = 'props'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(),
	'oneil_actions', {
		title = 'O\'Neil Works',
		align = 'top-left',
		elements = elements
	}, function (data, menu)
		if data.current.value == 'annonce' then
			messagenotfinish = true
			OpenAnnonceMenu()
		elseif data.current.value == 'props' then
			OpenPropsMenu()
		end
	end, function(data, menu)
		menu.close()

		CurrentAction = 'oneil_actions_menu'
		CurrentActionMsg = ''
		CurrentActionData = {}
	end)
end

function OpenVehicleSpawnerMenu()
	
	ESX.UI.Menu.CloseAll()

	if 0 == 1 then
		print("bizarre ça")
	else
		local elements = {
			{label = 'Véhicule de Travail',  value = 'SILUTIL'},
			{label = 'Camion utilitaire',  value = 'utilliTruck'},
			{label = 'Camion utilitaire 2',  value = 'utilliTruck2'},
			{label = 'Camion utilitaire 3',  value = 'utilliTruck3'},
			{label = 'Docktug',  value = 'docktug'},
			{label = 'Forklift',  value = 'forklift'},
			{label = 'Ripley',  value = 'Ripley'},
			{label = 'Bulldozer',  value = 'bulldozer'},
			{label = 'Cutter',  value = 'cutter'},
			{label = 'Handler',  value = 'Handler'},
			{label = 'Mixer',  value = 'mixer'},
			{label = 'Mixer2',  value = 'mixer2'},
			{label = 'Rubble',  value = 'rubble'},
			{label = 'TipTruck',  value = 'tiptruck'},
			{label = 'TipTruck2',  value = 'tiptruck2'},
			{label = 'CAT',  value = 'cat259'},
		}
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
				title    = "O'Neil Works",
				align    = 'top-left',
				elements = elements,
			}, function(data, menu)

				menu.close()

				local model = data.current.value
				local zone = vector3(-105.07, -1039.18, 26.81)
				ESX.Game.SpawnVehicle(model, zone, 334.37, function(vehicle)
					local playerPed = GetPlayerPed(-1)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
				end)
			end, function(data, menu)

				menu.close()

				CurrentAction     = 'vehicle_spawner_menu'
				CurrentActionMsg  = ''
				CurrentActionData = {}
			end)
	end
end

function OpenPropsMenu()
	local elements = {
		{label = 'cone', model = 'prop_roadcone02a'},
		{label = 'barrier', model = 'prop_barrier_work05'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(),
	'oneil_props', {
		title = 'O\'Neil Props',
		align = 'top-left',
		elements = elements
	},	function(data2, menu2)
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local forward   = GetEntityForwardVector(playerPed)
			local x, y, z   = table.unpack(coords + forward * 1.0)

			if data2.current.model == 'prop_roadcone02a' then
				z = z + 2.0
			end

			ESX.Game.SpawnObject(data2.current.model, { x = x, y = y, z = z }, function(obj)
				SetEntityHeading(obj, GetEntityHeading(playerPed))
				PlaceObjectOnGroundProperly(obj)
			end)
		end, function(data2, menu2)
			menu2.close()
		end)
	end


function OpenAnnonceMenu()
	local elements = {
		{label = 'Début d\'un chantier', value = 'startChant'},
		{label = 'Fin d\'un chantier', value = 'endChant'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(),
	'oneil_annonces', {
		title = 'O\'Neil Works',
		align = 'top-left',
		elements = elements
	}, function (data, menu)
		if data.current.value == 'startChant' then
			TriggerServerEvent('oneil_job:annonceStartChant')
		elseif data.current.value == 'endChant' then
			TriggerServerEvent('oneil_job:annonceEndChant')
		end
	end, function(data, menu)
		menu.close()

		CurrentAction = 'oneil_annonces_menu'
		CurrentActionMsg = ''
		CurrentActionData = {}
	end)
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'oneil' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			-- VEHICULE SPAWNER
			if (GetDistanceBetweenCoords(coords, -94.19, -1036.49, 27.93, true) < 15) then 
				DrawMarker(36, -94.19, -1036.49, 27.93, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 0, 100, false, true, 2, true, false, false, false) 
			end
			if (GetDistanceBetweenCoords(coords, -94.19, -1036.49, 27.93, true) < 5) then 
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule.")
				if IsControlPressed(0, 38) then
					OpenVehicleSpawnerMenu()
				end
			end
			-- END VEHICULE SPAWNER
			-- VEHICULE DELETER
			if (GetDistanceBetweenCoords(coords, -99.04, -1049.72, 27.43, true) < 15) then 
				DrawMarker(36, -99.04, -1049.72, 27.43, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 0, 100, false, true, 2, true, false, false, false) 
			end
			if (GetDistanceBetweenCoords(coords, -99.04, -1049.72, 27.43, true) < 5) then
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.")
				if IsControlPressed(0, 38) then
					local playerPed = PlayerPedId()	
					if IsPedInAnyVehicle(playerPed,  false) then	
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						if DoesEntityExist(vehicle) then
							ESX.Game.DeleteVehicle(vehicle)
						end
					end
				end
			end
			-- END VEHICULE DELETER
			-- BOSS ACTION
			if (GetDistanceBetweenCoords(coords, 1160.48, -3192.04, -39.01, true) < 10) then 
				DrawMarker(2, 1160.48, -3192.04, -39.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 0, 100, false, true, 2, true, false, false, false) 
			end
			if (GetDistanceBetweenCoords(coords, 1160.48, -3192.04, -39.01, true) < 5) then
				if PlayerData.job.grade_name == 'boss' then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu patron.") 
					if IsControlPressed(0, 38) then
						aboss()
					end
				end
			end
			-- END BOSS ACTION
		end
	end
end)

function OpenPutStocksMenu()
	TriggerEvent("esx_inventoryhud:openStorageInventory", "society_oneil")
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	blips()
end)



function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

-- Create Blips
function blips()
	if publicBlip == false then
		local blip = AddBlipForCoord(-135.47, -998.82, 26.85)
		SetBlipSprite (blip, 85)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 19)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("~y~O'Neil Works")
		EndTextCommandSetBlipName(blip)
		publicBlip = true
	end
end

AddEventHandler('oneil_job:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'oneil' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('oneil_job:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('oneil_job:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(0, 167) and PlayerData.job ~= nil and PlayerData.job.name == 'oneil' then
			OpenOneilActionsMenu()
			GUI.Time = GetGameTimer()
		end
	end
end)

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'oneil', function(data, menu)
        menu.close()
    end, {wash = false})
end
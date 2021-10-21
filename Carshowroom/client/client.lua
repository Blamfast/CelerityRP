ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




luxe             = {}
luxe.DrawDistance = 100
luxe.Size         = {x = 1.0, y = 1.0, z = 1.0}
luxe.Color        = {r = 255, g = 255, b = 255}
luxe.Type         = 20

fellow_conc = {
	catevehi = {},
	listecatevehi = {},
}

local derniervoituresorti = {}
local sortirvoitureacheter = {}
--blips

Citizen.CreateThread(function()

        local luxemap = AddBlipForCoord(141.78,-163.91,54.79)
        SetBlipSprite(luxemap, 326)
        SetBlipColour(luxemap, 46)
        SetBlipScale(luxemap, 0.90)
        SetBlipAsShortRange(luxemap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Catalogue")
        EndTextCommandSetBlipName(luxemap)

end)

--fin blips

--travail luxe

local markerjob = {
        {x = 141.78, y = -163.91, z = 54.79}, --point vente
}  

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(markerjob) do
            
            if (luxe.Type ~= -1 and GetDistanceBetweenCoords(coords, markerjob[k].x, markerjob[k].y, markerjob[k].z, true) < luxe.DrawDistance) then
                DrawMarker(luxe.Type, markerjob[k].x, markerjob[k].y, markerjob[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, luxe.Size.x, luxe.Size.y, luxe.Size.z, luxe.Color.r, luxe.Color.g, luxe.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
      
        end

        if letSleep then
            Citizen.Wait(500)
        end
    
end
end)

--point vente
local luxepointvente = false
RMenu.Add('luxevente', 'main', RageUI.CreateMenu("Catalogue", "Pour voir les catégories de véhicules"))
RMenu.Add('luxevente', 'categorievehicule', RageUI.CreateSubMenu(RMenu:Get('luxevente', 'main'), "Véhicules", "Pour voir les véhicule"))
RMenu:Get('luxevente', 'main').Closed = function()
    luxepointvente = false
end
RMenu:Get('luxevente', 'categorievehicule').Closed = function()
    supprimervehiculeluxe()
end

function ouvrirpointventeconc()
    if not luxepointvente then
        luxepointvente = true
        RageUI.Visible(RMenu:Get('luxevente', 'main'), true)
    while luxepointvente do

    

        RageUI.IsVisible(RMenu:Get('luxevente', 'main'), true, true, true, function()
        	for i = 1, #fellow_conc.catevehi, 1 do
            RageUI.ButtonWithStyle("Catégorie - "..fellow_conc.catevehi[i].label, nil, {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            		nomcategorie = fellow_conc.catevehi[i].label
                    categorievehi = fellow_conc.catevehi[i].name
                    ESX.TriggerServerCallback('fellow_luxe:recupererlistevehicule', function(listevehi)
                            fellow_conc.listecatevehi = listevehi
                    end, categorievehi)
                end
            end, RMenu:Get('luxevente', 'categorievehicule'))
        	end
            end, function()
            end)

        RageUI.IsVisible(RMenu:Get('luxevente', 'categorievehicule'), true, true, true, function()
        	RageUI.ButtonWithStyle("↓ Catégorie : "..nomcategorie.." ↓", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then   
            end
            end)

        	for i2 = 1, #fellow_conc.listecatevehi, 1 do
            RageUI.ButtonWithStyle(fellow_conc.listecatevehi[i2].name, "Pour acheter ce véhicule", {RightLabel = fellow_conc.listecatevehi[i2].price.."$"},true, function(Hovered, Active, Selected)
            if (Selected) then
            		nomvoiture = fellow_conc.listecatevehi[i2].name
            		prixvoiture = fellow_conc.listecatevehi[i2].price
            		modelevoiture = fellow_conc.listecatevehi[i2].model
            		supprimervehiculeluxe()
					chargementvoiture(modelevoiture)

					ESX.Game.SpawnLocalVehicle(modelevoiture, {x = -1207.93, y = -1733.58, z = 4.45}, 211.2, function (vehicle)
					table.insert(derniervoituresorti, vehicle)
					FreezeEntityPosition(vehicle, true)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetModelAsNoLongerNeeded(modelevoiture)
					end)
                end
            end)

        	end
           
            end)

            Citizen.Wait(0)
        end
  
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, -1215.33, -1732.71, 4.45)
            if jobdist <= 1.0 then
            
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au menu")
                    if IsControlJustPressed(1,51) then
                    	ESX.TriggerServerCallback('fellow_luxe:recuperercategorievehicule', function(catevehi)
                            fellow_conc.catevehi = catevehi
                        end)
                        luxepointvente = false
                        ouvrirpointventeconc()
                    end   
                end
               
        end
end)

function supprimervehiculeluxe()
	while #derniervoituresorti > 0 do
		local vehicle = derniervoituresorti[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(derniervoituresorti, 1)
	end
end

function chargementvoiture(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName('shop_awaiting_model')
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
	end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end


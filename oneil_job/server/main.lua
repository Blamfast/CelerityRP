-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'oneil', 'O\'Neil Works', true, true)
TriggerEvent('esx_society:registerSociety', 'oneil', 'O\'Neil Works', 'society_oneil', 'society_oneil', 'society_oneil', {type = 'private'})



RegisterServerEvent('oneil_job:annonceStartChant')
AddEventHandler('oneil_job:annonceStartChant', function(result)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~y~O\'Neil Works', 'Annonce', 'Un chantier vient d\'être crée ! Attention sur la route !', 'CHAR_MILSITE', 8)
	end
end)

RegisterServerEvent('oneil_job:annonceEndChant')
AddEventHandler('oneil_job:annonceEndChant', function(result)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~y~O\'Neil Works', 'Annonce', 'Le chantier est maintenant terminé ! Le trafic revient à la normale !', 'CHAR_MILSITE', 8)
	end
end)

RegisterServerEvent('oneil_job:putStockItems')
AddEventHandler('oneil_job:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('oneil_job:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)


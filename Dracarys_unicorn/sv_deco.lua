ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Announceunicorno')
AddEventHandler('Announceunicorno', function()   
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'UNICORN :', '', 'Unicorn ouvert !', 'CHAR_MP_STRIPCLUB_PR')
	end
end)


RegisterServerEvent('Announceu')
AddEventHandler('Announceu', function()    
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn :', '', 'Unicorn fermer !', 'CHAR_MP_STRIPCLUB_PR')
	end
end)














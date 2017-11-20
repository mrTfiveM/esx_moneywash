local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WashMoney(source,percent)
	local _source=source
	SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local blackMoney=xPlayer.getAccount('black_money')
			local _percent
				if blackMoney.money < Config.Slice then
					TriggerClientEvent('esx_moneywash:showNotification', source, 'Sie haben nicht genug Geld zum Waschen, mindestens : $' .. Config.Slice)
				else
					
					bonus=math.random(-50,50)
					local washedMoney = math.floor((Config.Slice / Config.Percentage) + bonus)
					
					xPlayer.removeAccountMoney('black_money', Config.Slice)
					xPlayer.addMoney(washedMoney)

					WashMoney(source,_percent)
				end

			
		end
	end)
end

RegisterServerEvent('esx_moneywash:startWash')
AddEventHandler('esx_moneywash:startWash', function(percent)
	PlayersWashing[source] = true
	TriggerClientEvent('esx_moneywash:showNotification', source, 'Bleichen läuft...')
	WashMoney(source,percent)
end)

RegisterServerEvent('esx_moneywash:pasLa')
AddEventHandler('esx_moneywash:pasLa', function()
	PlayersWashing[source] = false
	TriggerClientEvent('esx_moneywash:showNotification', source, 'Komm später zurück...')
end)


RegisterServerEvent('esx_moneywash:stopWash')
AddEventHandler('esx_moneywash:stopWash', function()
	PlayersWashing[source] = false
end)

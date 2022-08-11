-- vRP TUNNEL/PROXY
-- vRP TUNNEL/PROXY
vRPBs = {}
Tunnel.BindeInherFaced("DarkRP_XP",vRPBs)
Proxy.AddInthrFaced("DarkRP_XP",vRPBs)
BSClients = Tunnel.GedInthrFaced("DarkRP_XP", "DarkRP_XP")

local PlayerXP = {}
local Identifier_Store = {}

function GetIdentifierBySource(source)
	local steamid = "none"
	
	if Identifier_Store[source] then
		return Identifier_Store[source]
	end
	
	for k,v in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamid = v
		end
	end
	
	Identifier_Store[source] = steamid

	return steamid
end

function AddXP(source, amount)
	if PlayerXP[source] then
		amount = math.floor(amount)
		local resname = GetInvokingResource() or GetCurrentResourceName()
		PlayerXP[source] = PlayerXP[source]+amount
		BSClients.AddPlayerXP(source, {amount})
	end
end

function RemoveXP(source, amount)
	if PlayerXP[source] then
		PlayerXP[source] = PlayerXP[source]-amount
		if PlayerXP[source] <= 0 then
			PlayerXP[source] = 0
		end
		BSClients.RemovePlayerXP(source, {amount})
	end
end

function vRPBs.AddXP(amount)
	AddXP(source, amount)
end
AddEventHandler('DarkRP_XP:AddXP', function(source, amount)
	AddXP(source, amount)
end)

function vRPBs.RemoveXP(amount)
	RemoveXP(source, amount)
end
AddEventHandler('DarkRP_XP:RemoveXP', function(source, amount)
	RemoveXP(source, amount)
end)

function vRPBs.playerLoaded()
	local source = source
	local sqlvar = {
		['@identifier'] = GetIdentifierBySource(source),
	}
	local check = MySQL.Sync.fetchAll('SELECT 1 FROM users_xp WHERE `identifier`=@identifier', sqlvar)
	if not check[1] then
		MySQL.Sync.fetchAll("INSERT INTO `users_xp` (`identifier`) VALUES (@identifier);", sqlvar)
	end
	local xp = tonumber(MySQL.Sync.fetchScalar('SELECT `xp` FROM `users_xp` WHERE @identifier = identifier', sqlvar))
	PlayerXP[source] = xp
	BSClients.SetInitialXPLevels(source, {xp, false, false})
end

AddEventHandler('playerDropped', function(reason)
	local source = source
	if PlayerXP[source] then
		MySQL.Async.execute("UPDATE `users_xp` SET `xp` = @xp WHERE identifier = @identifier;", {
			['@xp'] = PlayerXP[source],
			['@identifier'] = GetIdentifierBySource(source),
		})
	end
	PlayerXP[source] = nil
	Identifier_Store[source] = nil
end)

CreateThread(function()
	Wait(2000)
	local resourceName = GetCurrentResourceName()
	local currentVersion = GetResourceMetadata(resourceName, "version", 0)
	PerformHttpRequest("https://api.github.com/repos/chaixshot/DarkRP_XP/releases/latest", function (errorCode, resultData, resultHeaders)
		if errorCode == 200 then
			local data = json.decode(resultData)
			if currentVersion ~= data.name then
				print("------------------------------")
				print("Update available for ^1"..resourceName.."^0")
				print("Please update to the latest release ^2(version: "..data.name..")^0")
				print("Check in ^3"..data.html_url.."^0")
				print("------------------------------")
			end
		end
	end)
end)
exports('GetCurrentPlayerLevel', function(source)
	return tonumber(GetCurrentPlayerLevel(source))
end)

function GetCurrentPlayerLevel(source)
	local intXPAmount = PlayerXP[source]
	if intXPAmount and is_int(intXPAmount) then
		local SearchingFor = intXPAmount
		
		if SearchingFor < 0 then return 1 end				-- Just return level 1 if an XP level BELLOW 0 is given
		
		if SearchingFor < Config.RockstarRanks[#Config.RockstarRanks] then			-- Check if the XP amount is smaller than the last item (level 100) in my 'Rockstar XP Requirements level list'
			local CurLevelFound = -1
		
			local CurrentLevelScan = 0
			for k,v in pairs(Config.RockstarRanks)do			-- And if it's bellow the 'maximum known rockstar XP requirement' scan the table here
				CurrentLevelScan = CurrentLevelScan + 1	-- Just keep counting +1 for each level that doesn't match the xp level
				if SearchingFor < v then break end		-- when we found it, break the loop and report the level we've found :)
			end
			
			return CurrentLevelScan
		else
			-- If the amount of XP you're trying to get the level from is above the maximum XP amount in the rockstar XP requirements list (level 100)
			-- then we'll make our own loop to find the correct level here :)
			BaseXP = Config.RockstarRanks[#Config.RockstarRanks]
			ExtraAddPerLevel = 50		-- This is the amount which rockstar ADDS on the amount required for the next level PER next level
			MainAddPerLevel = 28550 	-- This is the amount of XP required for level 100 ***MINUS 50 so my "formula" will work correctly!***
			-- I'll try to explain in easy words: When going from level 100 to level 101 you'll need 28600XP, when going from level 101 to level 101
			-- you will need 28650XP .... So Notice the extra 50 XP here?
			
			CurXPNeeded = 0
			local CurLevelFound = -1
			for i = 1, #Config.RockstarRanks - #Config.RockstarRanks ,1 			-- The - 998 in this loop ensures that the for loop result excludes the first 998 levels which are 
			do 												-- already 'covered by' the table at the top
				MainAddPerLevel = MainAddPerLevel + 50
				CurXPNeeded = CurXPNeeded + MainAddPerLevel
				CurLevelFound = i
				if SearchingFor < (BaseXP + CurXPNeeded) then break end
			end
		
			return CurLevelFound + #Config.RockstarRanks
		end
	else
		return 1 -- YES this MIGHT return the incorrect level... BUT will prevent possible crashes!
	end
end

exports('GetLevelFromXP', function(intXPAmount)
	return tonumber(GetLevelFromXP(intXPAmount))
end)
function GetLevelFromXP(intXPAmount)
	--======================================================================================
	-- This function 'converts' the XP amount you 'put in' to the level belongs to/in
	-- NOTE: This function does NOT have an 'upper limit' or 'error handling' on entering
	-- INSANE amounts since it should NOT happen if the scripts using these features
	-- are scripted normally! Especially not when considering that the maximum level
	-- "supported" is 7999! ;)
	--======================================================================================	
	if is_int(intXPAmount) then
		local SearchingFor = intXPAmount
		
		if SearchingFor < 0 then return 1 end				-- Just return level 1 if an XP level BELLOW 0 is given
		
		if SearchingFor < Config.RockstarRanks[#Config.RockstarRanks] then			-- Check if the XP amount is smaller than the last item (level 100) in my 'Rockstar XP Requirements level list'
			local CurLevelFound = -1
		
			local CurrentLevelScan = 0
			for k,v in pairs(Config.RockstarRanks)do			-- And if it's bellow the 'maximum known rockstar XP requirement' scan the table here
				CurrentLevelScan = CurrentLevelScan + 1	-- Just keep counting +1 for each level that doesn't match the xp level
				if SearchingFor < v then break end		-- when we found it, break the loop and report the level we've found :)
			end
			
			return CurrentLevelScan
		else
			-- If the amount of XP you're trying to get the level from is above the maximum XP amount in the rockstar XP requirements list (level 100)
			-- then we'll make our own loop to find the correct level here :)
			BaseXP = Config.RockstarRanks[#Config.RockstarRanks]
			ExtraAddPerLevel = 50		-- This is the amount which rockstar ADDS on the amount required for the next level PER next level
			MainAddPerLevel = 28550 	-- This is the amount of XP required for level 100 ***MINUS 50 so my "formula" will work correctly!***
			-- I'll try to explain in easy words: When going from level 100 to level 101 you'll need 28600XP, when going from level 101 to level 101
			-- you will need 28650XP .... So Notice the extra 50 XP here?
			
			CurXPNeeded = 0
			local CurLevelFound = -1
			for i = 1, #Config.RockstarRanks - #Config.RockstarRanks ,1 			-- The - 998 in this loop ensures that the for loop result excludes the first 998 levels which are 
			do 												-- already 'covered by' the table at the top
				MainAddPerLevel = MainAddPerLevel + 50
				CurXPNeeded = CurXPNeeded + MainAddPerLevel
				CurLevelFound = i
				if SearchingFor < (BaseXP + CurXPNeeded) then break end
			end
		
			return CurLevelFound + #Config.RockstarRanks
		end
	else
		print("=====================================================================================================")
		print("XNL WARNING: You have an error in one of your scripts calling the function 'GetLevelFromXP'")
		print("XNL WARNING: The script which is calling this function is not passing an integer!")
		print("=====================================================================================================")
		return 1 -- YES this MIGHT return the incorrect level... BUT will prevent possible crashes!
	end
end

function is_int(n)
	if type(n) == "number" then
		if math.floor(n) == n then
			return true
		end
	end
	return false
end

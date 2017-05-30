function GetDesire()
	local npcBot = GetBot();
	
	
	if ( npcBot:GetItemInSlot(1) == "item_bfury" or npcBot:GetItemInSlot(2) == "item_bfury" or npcBot:GetItemInSlot(3) == "item_bfury" or npcBot:GetItemInSlot(4) == "item_bfury" or npcBot:GetItemInSlot(5) == "item_bfury" or npcBot:GetItemInSlot(6) == "item_bfury" )
	then
		return 0;
	end;
	return 1;
end;
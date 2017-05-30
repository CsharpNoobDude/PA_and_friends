function GetDesire()
	local npcBot = GetBot();
	if ( not npcBot:GetItemInSlot(1) == "item_bfury" and not npcBot:GetItemInSlot(2) == "item_bfury" and not npcBot:GetItemInSlot(3) == "item_bfury"and not npcBot:GetItemInSlot(4) == "item_bfury"and not npcBot:GetItemInSlot(5) == "item_bfury" and not npcBot:GetItemInSlot(6) == "item_bfury" )
	then
		return 0.1;
	end;
	return 0.7;
end;
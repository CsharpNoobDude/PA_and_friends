local module = {};

utility = require(GetScriptDirectory() ..  "/utilityFunctions");


function module.moonshard()

	local npcBot = GetBot();
	
	if ( utility.CheckItemByName ( "item_moon_shard" ) and GetItemByName( "item_moon_shard" ):IsFullyCastable() and npcBot:GetNetWorth() > 25000 ) 
	then
		if ( npcBot:IsUsingAbility() )
		then
			return;
		else
			npcBot:Action_UseAbilityOnEntity(GetItemByName( "item_moon_shard" ), npcBot);
		end;
	end;
end;

function module.courier()

	local npcBot = GetBot();
	
	if ( utility.CheckItemByName ( "item_courier" ) and GetItemByName( "item_courier" ):IsFullyCastable() )
	then
		if ( npcBot:IsUsingAbility() )
		then
			return;
		else
			npcBot:Action_UseAbility( GetItemByName( "item_courier" ) );
		end;
	else
		return;
	end;
end;

function module.salveHeal()

	local npcBot = GetBot();
	
	if ( utility.CheckItemByName ( "item_salve" ) and GetItemByName( "item_salve" ):IsFullyCastable() and npcBot:GetHealth() < npcBot:GetMaxHealth() * 0.5 )
	then
		if ( npcBot:IsUsingAbility() )
		then
			return;
		else
			npcBot:Action_UseAbilityOnEntity( GetItemByName( "item_salve" ), npcBot );
		end;
	end;
end;

return module;
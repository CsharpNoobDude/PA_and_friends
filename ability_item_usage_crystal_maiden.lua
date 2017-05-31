castStiflingDaggerDesire = 0;
castPhantomStrikeDesire = 0;

utility = require(GetScriptDirectory() ..  "/utilityFunctions");
itemAbilities = require(GetScriptDirectory() ..  "/itemAbilities");



function AbilityUsageThink()

	local npcBot = GetBot();
	
	-- Check if we're already using an ability
	if ( npcBot:IsUsingAbility() )
	then 
		return nil;
	end;
	
	itemAbilities.courier();
end;

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------


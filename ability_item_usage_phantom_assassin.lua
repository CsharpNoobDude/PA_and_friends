castStiflingDaggerDesire = 0;
castPhantomStrikeDesire = 0;

utility = require(GetScriptDirectory() ..  "/utilityFunctions");



function AbilityUsageThink()

	local npcBot = GetBot();
	
	-- Check if we're already using an ability
	if ( npcBot:IsUsingAbility() )
	then 
		return nil;
	end;
	
	abilityStiflingDagger = npcBot:GetAbilityByName( "phantom_assassin_stifling_dagger" );
	abilityPhantomStrike = npcBot:GetAbilityByName( "phantom_assassin_phantom_strike" );
	
	-- Consider using each ability
	castStiflingDaggerDesire, castStiflingDaggerTarget = ConsiderStiflingDagger();
	castPhantomStrikeDesire, castPhantomStrikeTarget = ConsiderPhantomStrike();
	
	if ( castStiflingDaggerDesire > castPhantomStrikeDesire ) 
	then
		npcBot:Action_UseAbilityOnEntity( abilityStiflingDagger, castStiflingDaggerTarget );
		return;
	end;
	
	if ( castPhantomStrikeDesire > 0 )
	then
		npcBot:Action_UseAbilityOnEntity(abilityPhantomStrike, castPhantomStrikeTarget );
		return;
	end;
end;

----------------------------------------------------------------------------------------------------

function CanCastStiflingDaggerOnTarget( npcTarget )

    if ( npcTarget == nil )
    then 
        return false;
    end;
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end;


function CanCastPhantomStrikeOnTarget( npcTarget )
    if ( npcTarget == nil )
    then 
        return false;
    end;
	return npcTarget:CanBeSeen() and npcTarget:IsHero() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end;

----------------------------------------------------------------------------------------------------


function ConsiderStiflingDagger()

	local npcBot = GetBot();

	-- Make sure it's castable
	if ( not abilityStiflingDagger:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end;
	
	-- Get some of its values
	local nDamage = abilityStiflingDagger:GetSpecialValueInt( "base_damage" ) + abilityStiflingDagger:GetSpecialValueInt( "attack_factor_tooltip" ) / 100 * npcBot:GetAttackDamage();
	local nCastRange = abilityStiflingDagger:GetCastRange();
	local nLowestCreepHitPoints = 100000;
	local nLowestHeroHitPoints = 100000;
	local creeps = npcBot:GetNearbyCreeps( nCastRange + 300, true);
	local WeakestCreep, nLowestCreepHitPoints = utility.GetWeakestUnit( creeps );
	local enemies = npcBot:GetNearbyHeroes( nCastRange + 300, true, BOT_MODE_NONE );
	local WeakestEnemy, nLowestHeroHitPoints = utility.GetWeakestUnit( enemies );
    

	
	--while laning or farming
	if ( npcBot:GetActiveMode() == BOT_MODE_FARM or npcBot:GetActiveMode() == BOT_MODE_LANING )
	then
		if ( nLowestCreepHitPoints < nDamage and CanCastStiflingDaggerOnTarget( WeakestCreep ) )
		then
			return BOT_ACTION_DESIRE_MEDIUM, WeakestCreep;
		end;
		
		if ( CanCastStiflingDaggerOnTarget(WeakestEnemy) )
		then
			return BOT_ACTION_DESIRE_LOW, WeakestEnemy;
		end;
	end;
	
	--while fighting
	if ( npcBot:GetActiveMode() == BOT_MODE_ATTACK or npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY )
	then
		if ( nLowestHeroHitPoints * 1.05 < nDamage and CanCastStiflingDaggerOnTarget ( WeakestEnemy ) )
		then
			return BOT_ACTION_DESIRE_HIGH, WeakestEnemy;
		end;
		
		if ( nLowestCreepHitPoints * 1.05 < nDamage and CanCastStiflingDaggerOnTarget( WeakestCreep ) )
		then
			return BOT_ACTION_DESIRE_LOW, WeakestCreep;
		end;
		
		if ( CanCastStiflingDaggerOnTarget( WeakestEnemy ) )
		then
			return BOT_ACTION_DESIRE_MEDIUM, WeakestEnemy;
		end;
	end;
	
	return BOT_ACTION_DESIRE_NONE, 0;
end;


function ConsiderPhantomStrike()

	local npcBot = GetBot();

	-- Make sure it's castable
	if ( not abilityPhantomStrike:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end;
	
	-- Get some of its values
	local nDamage = 4 * npcBot:GetAttackDamage();		--should be 3 * , if that is too unlikely. (phantom_assassin_phantom_strike adds 4 very fast attacks)
	local nCastRange = abilityPhantomStrike:GetCastRange();
	local nLowestCreepHitPoints = 100000;
	local nLowestHeroHitPoints = 100000;
	local creeps = npcBot:GetNearbyCreeps( nCastRange + 300, true);
	local WeakestCreep, nLowestCreepHitPoints = utility.GetWeakestUnit( creeps );
	local enemies = npcBot:GetNearbyHeroes( nCastRange + 300, true, BOT_MODE_NONE );
	local WeakestEnemy, nLowestHeroHitPoints = utility.GetWeakestUnit( enemies );
	
	--while laning or farming
	if ( npcBot:GetActiveMode() == BOT_MODE_FARM or npcBot:GetActiveMode() == BOT_MODE_LANING )
	then
		if ( nLowestCreepHitPoints < nDamage and CanCastPhantomStrikeOnTarget( WeakestCreep ) )
		then
			return BOT_ACTION_DESIRE_MEDIUM, WeakestCreep;
		end;
		--return BOT_ACTION_DESIRE_LOW, WeakestEnemy;
	end;
	
	--while fighting
	if ( npcBot:GetActiveMode() == BOT_MODE_ATTACK or npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY )
	then
		if ( nLowestHeroHitPoints * 1.05 < nDamage and CanCastPhantomStrikeOnTarget ( WeakestEnemy ) )
		then
			return BOT_ACTION_DESIRE_HIGH, WeakestEnemy;
		end;
		return BOT_ACTION_DESIRE_LOW, WeakestEnemy;
	end;
	
	return BOT_ACTION_DESIRE_NONE, 0;
end;
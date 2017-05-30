castStiflingDaggerDesire = 0;
castPhantomStrikeDesire = 0;

require(GetScriptDirectory() ..  "/utilityFunctions");

function AbilityUsageThink()

	local npcBot = GetBot();
	
	-- Check if we're already using an ability
	if ( npcBot:IsUsingAbility() )
	then 
		return nil;
	end;
	
	abilityStiflingDagger = npcBot:GetAbilityByName( "phantom_asssassin_stifling_dagger" );
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
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end;


function CanCastPhantomStrikeOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and npcTarget:IsHero() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end;

----------------------------------------------------------------------------------------------------


function ConsiderStiflingDagger()

	local npcBot = GetBot();

	-- Make sure it's castable
	if ( not abilityStiflingDagger:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE, nil;
	end;
	
	-- Get some of its values
	local nDamage = 65+npcBot:GetAttackDamage()*(0.1+0.15*ability:GetLevel());			-- thanks to shutnik
	local nCastRange = ability:GetCastRange();
	--local nlowestCreepHitPoints = 100000;
	--local nlowestHeroHitPoints = 100000;
	local creeps = npcBot:GetNearbyCreeps(CastRange+300, true);
	local WeakestCreep, CreepHealth=utilityFunctions.GetWeakestUnit(creeps);
	local enemies = npcBot:GetNearbyHeroes(CastRange+300, true, BOT_MODE_NONE);
	local WeakestEnemy, HeroHealth=utilityFunctions.GetWeakestUnit(enemies);
	
	--while laning or farming
	if ( npcBot:GetActiveMode() == BOT_MODE_FARM or npcBot:GetActiveMode() == BOT_MODE_LANING or npcBot:GetActiveMode() == BOT_MODE_LANING_ROSHAN)
	then
		if ( creepHealth*1.05 < nDamage and CanCastStiflingDaggerOnTarget(WeakestCreep) )
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
		if ( HeroHealth*1.05 < nDamage and CanCastStiflingDaggerOnTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, WeakestEnemy;
		end;
		
		if ( creepHealth*1.05 < nDamage and CanCastStiflingDaggerOnTarget(WeakestCreep) )
		then
			BOT_ACTION_DESIRE_LOW, WeakestCreep;
		end;
		
		if ( CanCastStiflingDaggerOnTarget(WeakestEnemy) )
		then
			return BOT_ACTION_DESIRE_MEDIUM, WeakestEnemy;
		end;
	end;
	
	return BOT_ACTION_DESIRE_NONE, nil;
end;


function ConsiderPhantomStrike()

	local npcBot = GetBot();

	-- Make sure it's castable
	if ( not abilityStiflingDagger:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE, nil;
	end;
	
	-- Get some of its values
	local nDamage = 4*npcBot:GetAttackDamage();
	local nCastRange = ability:GetCastRange();
	--local nlowestCreepHitPoints = 100000;
	--local nlowestHeroHitPoints = 100000;
	local creeps = npcBot:GetNearbyCreeps(CastRange+300, true);
	local WeakestCreep,CreepHealth=logic.GetWeakestUnit(creeps);
	local enemys = npcBot:GetNearbyHeroes(CastRange+300, true, BOT_MODE_NONE);
	local WeakestEnemy,HeroHealth=logic.GetWeakestUnit(enemys);
	
	--while laning or farming
	if ( npcBot:GetActiveMode() == BOT_MODE_FARM or npcBot:GetActiveMode() == BOT_MODE_LANING_ROSHAN )
	then
		if ( creepHealth*0.95 < nDamage and CanCastPhantomStrikeOnTarget(WeakestCreep) )
		then
			return BOT_ACTION_DESIRE_MEDIUM, WeakestCreep;
		end;
		--return BOT_ACTION_DESIRE_LOW, WeakestEnemy;
	end;
	
	--while fighting
	--if ( npcBot:GetActiveMode() == BOT_MODE_ATTACK or npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY )
	--then
		--if ( HeroHealth*0.95 < nDamage )
		--then
			--return BOT_ACTION_DESIRE_HIGH, WeakestEnemy;
		--end;
		--return BOT_ACTION_DESIRE_MEDIUM, WeakestEnemy;
	--end;
	
	return BOT_ACTION_DESIRE_NONE, nil;
end;
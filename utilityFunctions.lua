local module = {};

function module.GetWeakestUnit(EnemyUnits)
    
    if ( EnemyUnits == nil or #EnemyUnits == 0 )
    then
        return nil, 10000;
    end;
    
    local WeakestUnit = nil;
    local LowestHealth = 10000;
    
    for _,unit in pairs(EnemyUnits) 
    do
        if ( unit~=nil and unit:IsAlive() )
        then
            if ( unit:GetHealth() < LowestHealth )
            then
                LowestHealth = unit:GetHealth();
                WeakestUnit = unit;
            end;
        end;
    end;
    
    return WeakestUnit, LowestHealth;
end;

function module.GetStrongestUnit(EnemyUnits)
    
    if ( EnemyUnits == nil or #EnemyUnits == 0 ) 
    then
        return nil, 0;
    end;
    
    local StrongestUnit = nil;
    local HighestHealth = 0;
    
    for _,unit in pairs(EnemyUnits)
    do
        if ( unit~=nil and unit:IsAlive() )
        then
            if ( unit:GetHealth()>HighestHealth )
            then
                HighestHealth = unit:GetHealth();
                StrongestUnit = unit;
            end;
        end;
    end;
    
    return StrongestUnit, HighestHealth;
end;

function module.CheckItemByName ( ItemName )

	local npcBot = GetBot();   
	
	for i= 0,5 do
		local sCurItem = npcBot:GetItemInSlot( i );
		if ( sCurItem ~= nil )
		then
			local iName = sCurItem:GetName();
			if ( iName == ItemName ) 
			then
				return true;
			end;
		end;
	end;  
		
	return false;
end;

return module;
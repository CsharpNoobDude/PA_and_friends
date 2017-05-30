

----------------------------------------------------------------------------------------------------

function Think()


	if ( GetTeam() == TEAM_RADIANT )
	then
		print( "selecting radiant" );
		SelectHero( 2, "npc_dota_hero_phantom_assassin" );
		SelectHero( 3, "npc_dota_hero_crystal_maiden" );
		SelectHero( 4, "npc_dota_hero_oracle" );
		SelectHero( 5, "npc_dota_hero_axe" );
		SelectHero( 6, "npc_dota_hero_sniper" );
	elseif ( GetTeam() == TEAM_DIRE )
	then
		print( "selecting dire" );
		SelectHero( 7, "npc_dota_hero_dragon_knight" );
		SelectHero( 8, "npc_dota_hero_earthshaker" );
		SelectHero( 9, "npc_dota_hero_dazzle" );
		SelectHero( 10, "npc_dota_hero_bounty_hunter" );
		SelectHero( 11, "npc_dota_hero_omniknight" );
	end;

end;

----------------------------------------------------------------------------------------------------

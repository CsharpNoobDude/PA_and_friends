utility = require(GetScriptDirectory() ..  "/utilityFunctions");


----------------------------------------------------------------------------------------------------

local ItemsToBuy = { 
				"item_tango",
                "item_flask",
                "item_clarity",
                "item_clarity",
				"item_stout_shield",
				"item_quelling_blade",
				"item_ring_of_health",
				"item_boots",
				"item_claymore",
				"item_broadsword",
				"item_void_stone",			--bfury
				"item_boots_of_elves",
				"item_gloves",				--treads agi
				"item_ring_of_health",
				"item_blight_stone",
				"item_vitality_booster",	--vanguard
				"item_lifesteal",
				"item_mithril_hammer",
				"item_mithril_hammer",		--desolator
				"item_reaver",
				"item_mithril_hammer",		--satanic
				"item_javelin",
				"item_belt_of_strength",
				"item_recipe_basher",		--basher
				"item_recipe_abyssal_blade",--abyssal blade
				"item_demon_edge",
				"item_javelin",
				"item_javelin"				--mkb
			};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

	local npcBot = GetBot();
	secretShopRadiant = Vector(-4472, 1328);
	

	if ( #ItemsToBuy == 0 )
	then
        --print( "first if is called" );
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end;

	local sNextItem = ItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
        --print( "second if is called" );
        if ( IsItemPurchasedFromSecretShop( sNextItem ) )
        then
            npcBot:ActionPush_MoveToLocation( secretShopRadiant );
			npcBot:ActionImmediate_PurchaseItem( sNextItem );
			table.remove( ItemsToBuy, 1 );
        else
			npcBot:ActionImmediate_PurchaseItem( sNextItem );
			table.remove( ItemsToBuy, 1 );
        end;
	end;
	
end;

----------------------------------------------------------------------------------------------------

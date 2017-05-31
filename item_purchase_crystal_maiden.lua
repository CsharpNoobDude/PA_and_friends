utility = require(GetScriptDirectory() ..  "/utilityFunctions");

----------------------------------------------------------------------------------------------------

local ItemsToBuy = { 
				"item_tango",
                "item_flask",
                "item_clarity",
                "item_courier",
                "item_branches",
                "item_branches",
                "item_circlet",
                "item_magic_stick",                 --magic wand
                "item_boots",
                "item_wind_lace",
                "item_ring_of_regen",               --tranquil boots
                "item_flying_courier",
                "item_branches",
                "item_chainmail",
                "item_recipe_buckler",
                "item_branches",
                "item_ring_of_regen",
                "item_recipe_headdress",
                "item_recipe_mekansm",              --mekansm
                "item_ring_of_health",
                "item_staff_of_wizardry",
                "item_recipe_force_staff",          --force staff
                "item_wind_lace",
                "item_staff_of_wizardry",
                "item_void_stone",
                "item_recipe_cyclone"               --cyclone aka euls scepter
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

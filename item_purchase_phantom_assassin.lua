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
            --do smthg
        else
			npcBot:ActionImmediate_PurchaseItem( sNextItem );
			table.remove( ItemsToBuy, 1 );
        end;
	end;
	
	--GeneralPurchase();
end;

----------------------------------------------------------------------------------------------------

function GeneralPurchase()
	local sNextItem = npcBot.ItemsToBuy[1];
	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );
	local CanPurchaseFromSecret = IsItemPurchasedFromSecretShop(sNextItem);
	local CanPurchaseFromSide   = IsItemPurchasedFromSideShop(sNextItem);
	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) ) then
		if ( CanPurchaseFromSecret and not CanPurchaseFromSide and npcBot:DistanceFromSecretShop() > 0 )
		then
			npcBot.SecretShop = true;
		elseif ( CanPurchaseFromSecret and CanPurchaseFromSide and npcBot:DistanceFromSideShop() < npcBot:DistanceFromSecretShop()
		       and npcBot:DistanceFromSideShop() > 0 and npcBot:DistanceFromSideShop() <= 2500 )
		then
			npcBot.SideShop = true;
		elseif ( CanPurchaseFromSecret and CanPurchaseFromSide and npcBot:DistanceFromSideShop() > npcBot:DistanceFromSecretShop() and npcBot:DistanceFromSecretShop() > 0 ) 
		then
			npcBot.SecretShop = true;
		elseif ( CanPurchaseFromSecret and CanPurchaseFromSide and npcBot:DistanceFromSideShop() > 2500 and npcBot:DistanceFromSecretShop() > 0 )
		then
			npcBot.SecretShop = true;
		elseif ( CanPurchaseFromSide and not CanPurchaseFromSecret and npcBot:DistanceFromSideShop() > 0 and npcBot:DistanceFromSideShop() <= 2500 )
		then
			npcBot.SideShop = true;
		else
			if ( npcBot:ActionImmediate_PurchaseItem( sNextItem ) == PURCHASE_ITEM_SUCCESS ) then
				table.remove( npcBot.ItemsToBuy, 1 );
				npcBot.SecretShop = false;
				npcBot.SideShop = false;	
			else
				print("[Generic]"..npcBot:GetUnitName().." failed to purchase "..sNextItem.." : "..tostring(npcBot:ActionImmediate_PurchaseItem( sNextItem )))	
			end;
		end;
	else
		npcBot.SecretShop = false;
		npcBot.SideShop = false;
	end;
end;
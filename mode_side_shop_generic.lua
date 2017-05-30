-- Copyright © 2017 
-- Scriptwriters Shutnik, AdamQQQ, hiArizona, Furious Puppy.
-- AdamQQQ 36 hero basic AI \ Warding AI \ Complex scipts for logical decisions
-- hiArizona 43 hero basic AI \ Rune AI \ ItemBuilds AI \ Complex scripts for Meepo and Invoker
-- Furious Puppy 12 hero basic AI \ Glyph AI \ Retreat logic
-- Shutnik 22 hero basic AI \ Laning behavior \ Map awarness logic \ Skill preferences \ Code adaptation

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local npcBot = GetBot();
local BOT_SIDE_SHOP = GetShopLocation(GetTeam(), SHOP_SIDE );
local TOP_SIDE_SHOP = GetShopLocation(GetTeam(), SHOP_SIDE2 );
function GetDesire()
	
	if npcBot:IsIllusion() then
		return BOT_MODE_DESIRE_NONE;
	end;
	
	if string.find(GetBot():GetUnitName(), "monkey") and npcBot:IsInvulnerable() then
		return BOT_MODE_DESIRE_NONE;
	end;
	
	if not IsSuitableToBuy() then
		return BOT_MODE_DESIRE_NONE;
	end;
	
	if npcBot.SideShop then
		return BOT_MODE_DESIRE_HIGH;
	end;
	return BOT_MODE_DESIRE_NONE;
end;
function Think()
	
	local closestSideShop = GetClosestSideShop();
	
	if npcBot:DistanceFromSideShop() > 0 then
		npcBot:Action_MoveToLocation(closestSideShop);
		return;
	end	;
	
end;
function GetClosestSideShop()
	local TSSD = GetUnitToLocationDistance(npcBot, TOP_SIDE_SHOP);
	local BSSD = GetUnitToLocationDistance(npcBot, BOT_SIDE_SHOP);
	
	if TSSD < BSSD then 
		return TOP_SIDE_SHOP;
	else
		return BOT_SIDE_SHOP;
	end;
end;
function IsSuitableToBuy()
	local mode = npcBot:GetActiveMode();
	if ( ( mode == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH )
		or mode == BOT_MODE_ATTACK
		or mode == BOT_MODE_DEFEND_ALLY
		or mode == BOT_MODE_DEFEND_TOWER_TOP
		or mode == BOT_MODE_DEFEND_TOWER_MID
		or mode == BOT_MODE_DEFEND_TOWER_BOT
		) 
	then
		return false;
	end;
	return true;
end;

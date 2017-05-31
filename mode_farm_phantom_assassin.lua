utility = require(GetScriptDirectory() ..  "/utilityFunctions");

function GetDesire() 
    if ( utility.CheckItemByName( "item_bfury" ) )
    then
        return BOT_MODE_DESIRE_HIGH;
    else
        return BOT_MODE_DESIRE_LOW;
    end;
end;
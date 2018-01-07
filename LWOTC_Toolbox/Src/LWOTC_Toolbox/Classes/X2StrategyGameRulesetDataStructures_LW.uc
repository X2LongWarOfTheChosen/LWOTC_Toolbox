//---------------------------------------------------------------------------------------
//  FILE:    X2StrategyGameRulesetDataStructures_L@.uc
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: Extends class to support bigger squads
//---------------------------------------------------------------------------------------
class X2StrategyGameRulesetDataStructures_LW extends X2StrategyGameRulesetDataStructures;

`include(LWOTC_Toolbox\Src\LW_Toolbox.uci)

static function int GetMaxSoldiersAllowedOnMission(optional MissionDefinition Mission)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local int Max;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

	if( Mission.MaxSoldiers > 0 )
	{
		Max = Mission.MaxSoldiers;
	}
	else
	{
		Max = class'XComGameState_LWToolboxOptions'.static.GetMaxSquadSize();
		if (History.GetCurrentHistoryIndex() > -1)
		{
			if (XComHQ != none)
			{
				if (XComHQ.SoldierUnlockTemplates.Find('SquadSizeIUnlock') != INDEX_NONE)
					Max++;
				if (XComHQ.SoldierUnlockTemplates.Find('SquadSizeIIUnlock') != INDEX_NONE)
					Max++;
			}
		}
	}

	if( XComHQ != None && XComHQ.TacticalGameplayTags.Find('ExtraSoldier_Intel') != INDEX_NONE )
	{
		++Max;
	}

	return Max;
}
//---------------------------------------------------------------------------------------
//  FILE:    X2StrategyGameRulesetDataStructures_L@.uc
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: Extends class to support bigger squads
//---------------------------------------------------------------------------------------
class X2StrategyGameRulesetDataStructures_LW extends X2StrategyGameRulesetDataStructures;

`include(LWOTC_Toolbox\Src\LW_Toolbox.uci)

static function int GetMaxSoldiersAllowedOnMission(optional XComGameState_MissionSite MissionSite = none)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local MissionDefinition Mission;
	local X2SitRepEffect_SquadSize SitRepEffect;
	local int MaxSquad;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

	if(MissionSite != none)
	{
		Mission = MissionSite.GeneratedMission.Mission;
	}

	if( Mission.MaxSoldiers > 0 )
	{
		MaxSquad = Mission.MaxSoldiers;
	}
	else
	{
		MaxSquad = class'XComGameState_LWToolboxOptions'.static.GetMaxSquadSize();
		if (History.GetCurrentHistoryIndex() > -1)
		{
			if (XComHQ != none)
			{
				if (XComHQ.SoldierUnlockTemplates.Find('SquadSizeIUnlock') != INDEX_NONE)
					MaxSquad++;
				if (XComHQ.SoldierUnlockTemplates.Find('SquadSizeIIUnlock') != INDEX_NONE)
					MaxSquad++;
			}
			else
			{
				// give both unlock slots in TQL and PIE
				MaxSquad += 2;
			}
		}
	}

	if( XComHQ != None && XComHQ.TacticalGameplayTags.Find('ExtraSoldier_Intel') != INDEX_NONE )
	{
		++MaxSquad;
	}

	// check if we have any sitreps that modify the size of the squad
	if( MissionSite != none )
	{
		foreach class'X2SitRepTemplateManager'.static.IterateEffects(class'X2SitrepEffect_SquadSize', SitRepEffect, MissionSite.GeneratedMission.SitReps)
		{
			if(SitRepEffect.MaxSquadSize > 0)
			{
				MaxSquad = min(MaxSquad, SitRepEffect.MaxSquadSize);
			}

			// add in the relative adjustment value, but make sure we have at least one unit
			MaxSquad = Max(1, MaxSquad + SitRepEffect.SquadSizeAdjustment);
		}
	}

	return MaxSquad;
}
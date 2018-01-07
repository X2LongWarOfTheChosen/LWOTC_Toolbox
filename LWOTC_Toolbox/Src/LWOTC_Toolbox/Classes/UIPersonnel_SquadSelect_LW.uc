//---------------------------------------------------------------------------------------
//  FILE:    UIPersonnel_SquadSelect_LW.uc
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: This is a replacement for UIPersonnel_SquadSelect that allows overriding disabled status
//---------------------------------------------------------------------------------------
class UIPersonnel_SquadSelect_LW extends UIPersonnel_SquadSelect;

`include(LWOTC_Toolbox\Src\LW_Toolbox.uci)

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);
}

simulated function UpdateList()
{
	local int i;
	local XComGameState_Unit Unit;
	local GeneratedMissionData MissionData;
	local UIPersonnel_ListItem UnitItem;
	local bool bAllowWoundedSoldiers; // true if wounded soldiers are allowed to be deployed on this mission
	
	super.UpdateList();
	
	MissionData = HQState.GetGeneratedMissionData(HQState.MissionRef.ObjectID);
	bAllowWoundedSoldiers = MissionData.Mission.AllowDeployWoundedUnits;

	// loop through every soldier to make sure they're not already in the squad
	for(i = 0; i < m_kList.itemCount; ++i)
	{
		UnitItem = UIPersonnel_ListItem(m_kList.GetItem(i));
		Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitItem.UnitRef.ObjectID));	

		//if(HQState.IsUnitInSquad(UnitItem.UnitRef) || (Unit.IsInjured() && !bAllowWoundedSoldiers) || Unit.IsTraining() || Unit.IsPsiTraining())  // pre-AlienHunters
		if(HQState.IsUnitInSquad(UnitItem.UnitRef) || (Unit.IsInjured() && !bAllowWoundedSoldiers && !Unit.IgnoresInjuries()) || Unit.IsTraining() || Unit.IsPsiTraining())  // added in AlienHunters, not forward compatible
			UnitItem.SetDisabled(true);

		// trigger now to allow overriding disabled status, and to add background elements
		`XEVENTMGR.TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self);
	}
}

// Override sort function
simulated function SortPersonnel()
{
	SortCurrentData(SortSoldiers);
}

// show available units first
simulated function int SortSoldiers(StateObjectReference A, StateObjectReference B)
{
	if( !HQState.IsUnitInSquad(A) && HQState.IsUnitInSquad(B) )
		return 1;
	else if( HQState.IsUnitInSquad(A) && !HQState.IsUnitInSquad(B) )
		return -1;
	return 0;
}

defaultproperties
{
	m_eListType = eUIPersonnel_Soldiers;
	m_bRemoveWhenUnitSelected = true;
}
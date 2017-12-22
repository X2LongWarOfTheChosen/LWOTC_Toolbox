//---------------------------------------------------------------------------------------
//  FILE:    UISquadSelect_LW
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: Extends base-game SquadSelect to support up to 12 soldiers deployable. 
//--------------------------------------------------------------------------------------- 

class UISquadSelect_LW extends UISquadSelect config(LW_Toolbox);

var int SoldierSlotCount1, SoldierSlotCount2;

var UIList m_kSlotList2;
var array<int> SlotListOrder2; //The slot list is not 0->n for cinematic reasons ( ie. 0th and 1st soldier are in a certain place )

var UIMask m_kSlotListMask, m_kSlotListMask2;
var bool m_bUpperRowActive;

var float ListHeight, MaskHeight, ListItemClipAmount, UpperRowShiftAmount, PromoteShiftAmount, HeavyWeaponShiftAmount;
var float LowerRowDefaultY, UpperRowDefaultY;
var float TweenTime, TweenDelay, InactiveAlpha;

var string UIDisplayCam_Back;
var string UIDisplayCam_EditSoldier;
var string UIDisplayCam_Start;

var config string UIDisplayCam_Front;

//deprecated, as added base in AlienHunters
//var localized string m_strStripWeapons;
//var localized string m_strStripWeaponsConfirm;
//var localized string m_strStripWeaponsConfirmDesc;
//var localized string m_strTooltipStripWeapons;

var localized string m_strTooltipNeedsFrontRowSoldier;

//var localized string m_strClearSquad;
var localized string m_strTooltipClearSquad;

var localized string m_strAutofillSquad;
var localized string m_strTooltipAutofillSquad;

var localized string m_strSimCombat;
var localized string m_strTooltipSimCombat;

var config array<name> UnskippableMissionNames;

// Constructor
simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	local int listX, listWidth;
	local XComGameState NewGameState;
	local GeneratedMissionData MissionData;
	local float BackRowUpshift;

	super(UIScreen).InitScreen(InitController, InitMovie, InitName);
	
	//class'XComGameState_LWToolboxOptions'.static.UpdateDefaultMaxSquadSize();

	Navigator.HorizontalNavigation = true;

	m_kMissionInfo = Spawn(class'UISquadSelectMissionInfo', self).InitMissionInfo();
	m_kPawnMgr = Spawn( class'UIPawnMgr', Owner );

	// Enter Squad Select Event
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Enter Squad Select Event Hook");
	`XEVENTMGR.TriggerEvent('EnterSquadSelect', , , NewGameState);
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	MissionData = XComHQ.GetGeneratedMissionData(XComHQ.MissionRef.ObjectID);
	SoldierSlotCount = GetMaxSoldiersAllowedOnMission(MissionData.Mission);

	MaxDisplayedSlots = 12;

	`LOG("SquadSelect_LW: MaxSlots=" $ MaxDisplayedSlots $ ", MaxSoldiers=" $ SoldierSlotCount,, 'LW_Toolbox');

	if(GetTotalSlots() <= 6)
	{
		SoldierSlotCount1 = GetTotalSlots();
		SoldierSlotCount2 = 0;
	}
	else
	{	
		SoldierSlotCount2 = GetTotalSlots() - 6;	// 1, 2, 3, 4, 5, 6
		SoldierSlotCount1 = 6;						// 6, 6, 6, 6, 6, 6
	}

	// Force only the max displayed slots to be created, even if more soldiers are allowed
	//if (SoldierSlotCount1 > MaxDisplayedSlots)
	//	SoldierSlotCount1 = MaxDisplayedSlots;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Squad size adjustment from mission parameters");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	if (XComHQ.Squad.Length > SoldierSlotCount)
	{
		NewGameState.AddStateObject(XComHQ);
		XComHQ.Squad.Length = SoldierSlotCount;
	}
	`XEVENTMGR.TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState); // hook to allow mods to adjust who is in the squad
	if (NewGameState.GetNumGameStateObjects() > 0)
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	else
		`XCOMHISTORY.CleanupPendingGameState(NewGameState);

	if(SoldierSlotCount2 > 0)
	{	
		//always add an even number of slots
		if(SoldierSlotCount2 % 2 == 1)
			listWidth = (SoldierSlotCount2+1) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
		else
			listWidth = (SoldierSlotCount2) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
		listX = Clamp((Movie.UI_RES_X / 2) - (listWidth / 2), 10, Movie.UI_RES_X / 2);

		m_kSlotList2 = Spawn(class'UIList', self);
		BackRowUpshift = 0;
		if(FrontRowSoldierHasPromotion()) { BackRowUpshift += PromoteShiftAmount; }
		if(FrontRowSoldierHasHeavyWeapon()) { BackRowUpshift += HeavyWeaponShiftAmount; }
		m_kSlotList2.InitList('', listX, UpperRowDefaultY - BackRowUpshift, Movie.UI_RES_X - 20, ListHeight, true).AnchorBottomLeft();
		//if(FrontRowSoldierHasPromotion())
			//m_kSlotList2.InitList('', listX, UpperRowDefaultY - PromoteShiftAmount, Movie.UI_RES_X - 20, ListHeight, true).AnchorBottomLeft();
		//else
			//m_kSlotList2.InitList('', listX, UpperRowDefaultY, Movie.UI_RES_X - 20, ListHeight, true).AnchorBottomLeft();
		m_kSlotList2.itemPadding = LIST_ITEM_PADDING;
		m_kSlotList2.SetAlpha(InactiveAlpha);

		//m_kSlotList2.SetY(m_kSlotList2.Y + UpperRowShiftAmount);

		m_kSlotListMask2 = Spawn(class'UIMask', self).InitMask(, m_kSlotList2); 
		m_kSlotListMask2.AnchorBottomLeft();
		m_kSlotListMask2.FitMask(m_kSlotList2);
		m_kSlotListMask2.SetHeight(m_kSlotListMask2.Height - ListItemClipAmount);
		//if(FrontRowSoldierHasPromotion())
			m_kSlotListMask2.SetY(m_kSlotListMask2.Y + ListItemClipAmount);
		//else
			//m_kSlotListMask2.SetY(m_kSlotListMask2.Y + ListItemClipAmount);
	}

	if(SoldierSlotCount1 % 2 == 1)
		listWidth = (SoldierSlotCount1 + 1) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
	else
		listWidth = (SoldierSlotCount1) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
	listX = Clamp((Movie.UI_RES_X / 2) - (listWidth / 2), 10, Movie.UI_RES_X / 2);

	m_kSlotList = Spawn(class'UIList', self);
	m_kSlotList.InitList('', listX, LowerRowDefaultY, Movie.UI_RES_X - 20, ListHeight, true).AnchorBottomLeft();
	m_kSlotList.itemPadding = LIST_ITEM_PADDING;

	m_kSlotListMask = Spawn(class'UIMask', self).InitMask('', m_kSlotList); 
	m_kSlotListMask.AnchorBottomLeft();
	m_kSlotListMask.FitMask(m_kSlotList);
	m_kSlotListMask.SetHeight(m_kSlotListMask.Height + (MaskHeight - ListHeight));
	m_kSlotListMask.SetY(m_kSlotListMask.Y - (MaskHeight - ListHeight));

	`XSTRATEGYSOUNDMGR.PlaySquadSelectMusic();

	bDisableEdit = class'XComGameState_HeadquartersXCom'.static.GetObjectiveStatus('T0_M3_WelcomeToHQ') == eObjectiveState_InProgress;
	bDisableDismiss = bDisableEdit; // disable both buttons for now
	bDisableLoadout = false;

	//Make sure the kismet variables are up to date
	WorldInfo.MyKismetVariableMgr.RebuildVariableMap();

	if(CrossModTriggeredEvent('OnCheckAutoFillSquad', true))
		UpdateData(true);

	//UpdateNavHelp();
	UpdateMissionInfo();

	`XEVENTMGR.TriggerEvent('PostSquadSelectInit', XComHQ, self);
	UpdateData();

	LaunchButton = Spawn(class'UILargeButton', self);
	LaunchButton.bAnimateOnInit = false;
	LaunchButton.InitLargeButton(, m_strMission, m_strLaunch, OnLaunchMission);
	LaunchButton.AnchorTopCenter();

	if (MissionData.Mission.AllowDeployWoundedUnits)
	{
		`HQPRES.UIWoundedSoldiersAllowed();
	}

	//Delay by a slight amount to let pawns configure. Otherwise they will have Giraffe heads.
	SetTimer(0.1f, false, nameof(StartPreMissionCinematic));
	XComHeadquartersController(`HQPRES.Owner).SetInputState('None');
}

static function int GetMaxSoldiersAllowedOnMission(optional MissionDefinition Mission)
{
	local XComGameState_HeadquartersXCom LocalXComHQ;
	local XComGameStateHistory History;
	local int Max;

	History = `XCOMHISTORY;
	LocalXComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

	if( Mission.MaxSoldiers > 0 )
	{
		//Max = Mission.MaxSoldiers;
		Max = class'XComGameState_LWToolboxOptions'.static.GetMissionMaxSoldiersOverride(Mission);
	}
	else
	{
		Max = class'XComGameState_LWToolboxOptions'.static.GetMaxSquadSize(Mission);
		if (History.GetCurrentHistoryIndex() > -1)
		{
			if (LocalXComHQ != none)
			{
				if (LocalXComHQ.SoldierUnlockTemplates.Find('SquadSizeIUnlock') != INDEX_NONE)
					Max++;
				if (LocalXComHQ.SoldierUnlockTemplates.Find('SquadSizeIIUnlock') != INDEX_NONE)
					Max++;
			}
		}
	}

	if( LocalXComHQ != None && LocalXComHQ.TacticalGameplayTags.Find('ExtraSoldier_Intel') != INDEX_NONE )
	{
		++Max;
	}

	//limit total squad size to 8 on "LastGift" DLC missio to prevent issues with XComSpawnPoint limitations
	if(Mission.MissionFamily == "LastGift")
		Max= Min(8, Max);


	return Max;
}

function StartPreMissionCinematic()
{
	`GAME.GetGeoscape().m_kBase.SetPreMissionSequenceVisibility(true);

	//Link the cinematic pawns to the matinee
	//WorldInfo.MyKismetVariableMgr.RebuildVariableMap();
	WorldInfo.MyLocalEnvMapManager.SetEnableCaptures(true);

	Hide();

	WorldInfo.RemoteEventListeners.AddItem(self);
	GotoState('Cinematic_PawnsWalkingUp');

	`XCOMGRI.DoRemoteEvent('CIN_HideArmoryStaff'); //Hide the staff in the armory so tha tthey don't overlap with the soldiers

	//`LOG("SquadSelect_LW: Calling RemoteEvent PreM_Begin_LW",, 'LW_Toolbox');

	`XCOMGRI.DoRemoteEvent('PreM_Begin_LW');

	SnapStartCamera();
	SetTimer(0.05f, false, nameof(StartCameraPanIn));

	//Show the UI on a delay to prevent the first list box from being offset downward, likely due to lag from streaming in pawns
	SetTimer(1.25f, false, nameof(ShowLineupUI));
}

function StartCameraPanIn()
{
	SwitchCamera(2.5, true);
}

function ShowLineupUI()
{
	local int i, j, i2, j2;
	local UISquadSelect_ListItem ListItem;
	local float AnimateRate, AnimateValue;

	//if(IsVisible() && Movie.Pres.ScreenStack.IsTopScreen(self))
	//{
		//`HQPRES.CAMLookAtNamedLocation(UIDisplayCam, 0);
	//}
	Show();
	UpdateNavHelp();

	AnimateRate = 1.0;
	AnimateValue = 0.0;

	// Animate the slots in from left to right
	for(i = 0; i < SlotListOrder.Length; ++i)
	{
		for(j = 0; j < m_kSlotList.ItemCount; ++j)
		{
			ListItem = UISquadSelect_ListItem(m_kSlotList.GetItem(j));
			if(ListItem.bIsVisible && ListItem.SlotIndex == SlotListOrder[i])
			{
				ListItem.AnimateIn(AnimateValue);
				AnimateValue += AnimateRate;
			}
		}
	}
	if(m_kSlotList2 != none)
	{
		for(i2 = 0; i2 < SlotListOrder2.Length; ++i2)
		{
			for(j2 = 0; j2 < m_kSlotList2.ItemCount; ++j2)
			{
				ListItem = UISquadSelect_ListItem(m_kSlotList2.GetItem(j2));
				if(ListItem.bIsVisible && ListItem.SlotIndex == SoldierSlotCount1 + SlotListOrder2[i2])
				{
					ListItem.AnimateIn(AnimateValue);
					AnimateValue += AnimateRate;
				}
			}
		}
	}
}

event OnRemoteEvent(name RemoteEventName)
{

	super(UIScreen).OnRemoteEvent(RemoteEventName);

	// Only show screen if we're at the top of the state stack
	if(RemoteEventName == 'PreM_LineupUI' && `SCREENSTACK.GetCurrentScreen() == self)
	{
		ShowLineupUI();
	}
	else if(RemoteEventName == 'PreM_Exit')
	{
		GoToGeoscape();
	}
	else if(RemoteEventName == 'PreM_StartIdle' || RemoteEventName == 'PreM_SwitchToLineup')
	{
		GotoState('Cinematic_PawnsIdling');
	}
	else if(RemoteEventName == 'PreM_SwitchToSoldier')
	{
		GotoState('Cinematic_PawnsCustomization');
	}
	else if(RemoteEventName == 'PreM_StopIdle_S2')
	{
		GotoState('Cinematic_PawnsWalkingAway');    
	}		
	else if(RemoteEventName == 'PreM_CustomizeUI_Off')
	{
		//SwitchCamera(1.167);
		UpdateData();
	}
}

simulated function XComGameState_LWToolboxOptions GetToolboxOptions()
{
	local XComGameState_CampaignSettings CampaignSettingsStateObject;

	CampaignSettingsStateObject = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	return XComGameState_LWToolboxOptions(CampaignSettingsStateObject.FindComponentObject(class'XComGameState_LWToolboxOptions'));
}

simulated function SwitchActiveRow(UIList ToList)
{
	local float BackRowUpshift;

	if(ToList == none)
		return;
	//if(((ToList == m_kSlotList2) && !m_bUpperRowActive)
	   //|| ((ToList == m_kSlotList) && m_bUpperRowActive))
	//{
		if(ToList == m_kSlotList)
		{
			//TODO: Add animations once they respect anchors

			//adjust upper row position and mask
			if(m_kSlotList2 != none)
			{
				//m_kSlotList2.AnimateY(Movie.UI_RES_Y + UpperRowDefaultY - 5, TweenTime, TweenDelay);
				//m_kSlotListMask2.AnimateHeight(m_kSlotList2.Height - ListItemClipAmount, TweenTime, TweenDelay);
				//m_kSlotListMask2.AnimateY(Movie.UI_RES_Y + UpperRowDefaultY + ListItemClipAmount - 5, TweenTime, TweenDelay);

				m_kSlotList2.SetAlpha(InactiveAlpha);
				BackRowUpshift = 0;
				if(FrontRowSoldierHasPromotion()) { BackRowUpshift += PromoteShiftAmount; }
				if(FrontRowSoldierHasHeavyWeapon()) { BackRowUpshift += HeavyWeaponShiftAmount; }
				m_kSlotList2.SetY(UpperRowDefaultY - BackRowUpshift);
				m_kSlotListMask2.SetHeight(m_kSlotList2.Height - ListItemClipAmount);
				m_kSlotListMask2.SetY(m_kSlotList2.Y + ListItemClipAmount);
			}
						
			//adjust lower row mask
			//m_kSlotListMask.AnimateHeight(m_kSlotList.Height, TweenTime, TweenDelay);
			//m_kSlotListMask.AnimateY(Movie.UI_RES_Y + m_kSlotList.Y - 5, TweenTime, TweenDelay);
			m_kSlotList.SetAlpha(100);

			m_kSlotListMask.SetHeight(m_kSlotList.Height + (MaskHeight - ListHeight));
			m_kSlotListMask.SetY(m_kSlotList.Y - (MaskHeight - ListHeight));

			m_bUpperRowActive = false;
			UpdateSelectedUnitTextY();
			SwitchCamera(TweenTime);
		}
		else
		{
			//adjust upper row position and mask
			if(m_kSlotList2 != none)
			{
				//m_kSlotList2.AnimateY(Movie.UI_RES_Y + UpperRowDefaultY + UpperRowShiftAmount - 5, TweenTime, TweenDelay);
				//m_kSlotListMask2.AnimateHeight(m_kSlotList2.Height, TweenTime, TweenDelay);
				//m_kSlotListMask2.AnimateY(Movie.UI_RES_Y + UpperRowDefaultY + UpperRowShiftAmount - 5, TweenTime, TweenDelay);
				m_kSlotList2.SetAlpha(100);

				m_kSlotList2.SetY(UpperRowDefaultY + UpperRowShiftAmount);
				m_kSlotListMask2.SetHeight(m_kSlotList2.Height + (MaskHeight - ListHeight));
				m_kSlotListMask2.SetY(m_kSlotList2.Y - (MaskHeight - ListHeight));
			}
			//adjust lower row mask
			//m_kSlotListMask.AnimateHeight(m_kSlotList.Height - ListItemClipAmount, TweenTime, TweenDelay);
			//m_kSlotListMask.AnimateY(Movie.UI_RES_Y + LowerRowDefaultY + ListItemClipAmount - 5, TweenTime, TweenDelay);
			m_kSlotList.SetAlpha(InactiveAlpha);

			m_kSlotListMask.SetHeight(m_kSlotList.Height - ListItemClipAmount);
			m_kSlotListMask.SetY(m_kSlotList.Y + ListItemClipAmount);

			m_bUpperRowActive = true;
			UpdateSelectedUnitTextY();
			SwitchCamera(TweenTime);
		}
	//}
}

simulated function UpdateSelectedUnitTextY()
{
	local UISquadSelect_ListItem_LW ListItem;
	local int Index;

	for(Index = 0; Index < m_kSlotList.ItemCount; ++Index)
	{
		ListItem = UISquadSelect_ListItem_LW(m_kSlotList.GetItem(Index));
		ListItem.UpdateSelectUnitTextY();
	}
	for(Index = 0; Index < m_kSlotList2.ItemCount; ++Index)
	{
		ListItem = UISquadSelect_ListItem_LW(m_kSlotList2.GetItem(Index));
		ListItem.UpdateSelectUnitTextY();
	}
}

simulated function UpdateData(optional bool bFillSquad)
{
	local XComGameStateHistory History;
	local int i;
	local int SlotIndex;	//Index into the list of places where a soldier can stand in the after action scene, from left to right
	local int SquadIndex;	//Index into the HQ's squad array, containing references to unit state objects
	local int PawnIndex;   // index into a pawn position, used to create pawns in the appropriate slot
	local int ListItemIndex;//Index into the array of list items the player can interact with to view soldier status and promote
	local int ListItemIndex2;//Index into the array of upper list items the player can interact with to view soldier status and promote
	local int ListX, ListWidth;
	local UISquadSelect_ListItem ListItem;
	local XComGameState_Unit UnitState;
	local XComGameState_MissionSite MissionState;
	local GeneratedMissionData MissionData;
	local bool bAllowWoundedSoldiers, bSpecialSoldierFound;
	local array<name> RequiredSpecialSoldiers;

	History = `XCOMHISTORY;
	ClearPawns();

	// update list positioning in case the number of total slots has changed since init was called
	if(SoldierSlotCount1 % 2 == 1)
		listWidth = (SoldierSlotCount1 + 1) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
	else
		listWidth = (SoldierSlotCount1) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
	ListX = Clamp((Movie.UI_RES_X / 2) - (ListWidth / 2), 10, Movie.UI_RES_X / 2);
	m_kSlotList.SetX(ListX);

	if(m_kSlotList2 != none)
	{
		if(SoldierSlotCount2 % 2 == 1)
			listWidth = (SoldierSlotCount2+1) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
		else
			listWidth = (SoldierSlotCount2) * (class'UISquadSelect_ListItem_LW'.default.width + LIST_ITEM_PADDING);
		ListX = Clamp((Movie.UI_RES_X / 2) - (ListWidth / 2), 10, Movie.UI_RES_X / 2);
		m_kSlotList2.SetX(ListX);
	}

	// get existing states
	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	MissionData = XComHQ.GetGeneratedMissionData(XComHQ.MissionRef.ObjectID);
	bAllowWoundedSoldiers = MissionData.Mission.AllowDeployWoundedUnits;
	RequiredSpecialSoldiers = MissionData.Mission.SpecialSoldiers;

	// add a unit to the squad if there is one pending
	if(PendingSoldier.ObjectID > 0 && m_iSelectedSlot != -1)
		XComHQ.Squad[m_iSelectedSlot] = PendingSoldier;

	// if this mission requires special soldiers, check to see if they already exist in the squad
	if (RequiredSpecialSoldiers.Length > 0)
	{
		for (i = 0; i < RequiredSpecialSoldiers.Length; i++)
		{
			bSpecialSoldierFound = false;
			for (SquadIndex = 0; SquadIndex < XComHQ.Squad.Length; SquadIndex++)
			{
				UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[SquadIndex].ObjectID));
				if (UnitState != none && UnitState.GetMyTemplateName() == RequiredSpecialSoldiers[i])
				{
					bSpecialSoldierFound = true;
					break;
				}
			}

			if (!bSpecialSoldierFound)
				break; // If a special soldier is missing, break immediately and reset the squad
		}

		// If no special soldiers are found, clear the squad, search for them, and add them
		if (!bSpecialSoldierFound)
		{
			UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add special soldier to squad");
			XComHQ = XComGameState_HeadquartersXCom(UpdateState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
			XComHQ.Squad.Length = 0;

			foreach History.IterateByClassType(class'XComGameState_Unit', UnitState)
			{
				// If this unit is one of the required special soldiers, add them to the squad
				if (RequiredSpecialSoldiers.Find(UnitState.GetMyTemplateName()) != INDEX_NONE)
				{
					UnitState = XComGameState_Unit(UpdateState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
					
					// safety catch: somehow Central has no appearance in the alien nest mission. Not sure why, no time to figure it out - dburchanowski
					if(UnitState.GetMyTemplate().bHasFullDefaultAppearance && UnitState.kAppearance.nmTorso == '')
					{
						`Redscreen("Special Soldier " $ UnitState.ObjectID $ " with template " $ UnitState.GetMyTemplateName() $ " has no appearance, restoring default!");
						UnitState.kAppearance = UnitState.GetMyTemplate().DefaultAppearance;
					}

					UpdateState.AddStateObject(UnitState);
					UnitState.ApplyBestGearLoadout(UpdateState); // Upgrade the special soldier to have the best possible gear
					
					if (XComHQ.Squad.Length < SoldierSlotCount) // Only add special soldiers up to the squad limit
					{
						XComHQ.Squad.AddItem(UnitState.GetReference());
					}
				}
			}

			StoreGameStateChanges();
		}
	}

	// fill out the squad as much as possible
	if(bFillSquad)
	{
		// create change states
		UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Fill Squad");
		XComHQ = XComGameState_HeadquartersXCom(UpdateState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));

		`LOG("UISquadSelect_LW: bFillSquad, SoldierSlotCount = " $ SoldierSlotCount,, 'LW_Toolbox');

		for(i = 0; i < SoldierSlotCount; i++)
		{
			if(XComHQ.Squad.Length == i || XComHQ.Squad[i].ObjectID == 0)
			{
				UnitState = GetBestDeployableSoldier(XComHQ, true, bAllowWoundedSoldiers);
				if(UnitState != none)
					XComHQ.Squad[i] = UnitState.GetReference();
			}
		}
		StoreGameStateChanges();

		SkulljackEvent();
	}

	// This method iterates all soldier templates and empties their backpacks if they are not already empty
	BlastBackpacks();

	// Everyone have their Xpad?
	ValidateRequiredLoadouts();

	// Clear Utility Items from wounded soldiers inventory
	if (!bAllowWoundedSoldiers)
	{
		MakeWoundedSoldierItemsAvailable();
	}

	// create change states
	CreatePendingStates();

	// Add slots in the list if necessary. 
	while( (m_kSlotList.itemCount + (m_kSlotList2 != none ? m_kSlotList2.itemCount : 0)) < GetTotalSlots() )
	{
		if((m_kSlotList2 == none) || (m_kSlotList.itemCount < SoldierSlotCount1))
			ListItem = UISquadSelect_ListItem(m_kSlotList.CreateItem(class'UISquadSelect_ListItem_LW').InitPanel());
		else
			ListItem = UISquadSelect_ListItem(m_kSlotList2.CreateItem(class'UISquadSelect_ListItem_LW').InitPanel());
	}

	ListItemIndex = 0;
	ListItemIndex2 = 0;

	// Disable first and last slots if user hasn't purchased upgrades to use them yet
	if(ShowExtraSlot1() && !UnlockedExtraSlot1())
	{
		switch(SoldierSlotCount)
		{
		case 1:
		case 2:
		case 3:
		case 4:
			UISquadSelect_ListItem(m_kSlotList.GetItem(0)).DisableSlot();
			break;
		case 5:
			UISquadSelect_ListItem(m_kSlotList.GetItem(m_kSlotList.ItemCount - 1)).DisableSlot();
			break;
		case 6:
			break;
		default:
			//UISquadSelect_ListItem(m_kSlotList2.GetItem(0)).DisableSlot();
			break;
		}
	}

	if(ShowExtraSlot2() && !UnlockedExtraSlot2())
	{
		switch(SoldierSlotCount)
		{
		case 1:
		case 2:
		case 3:
		case 4:
			UISquadSelect_ListItem(m_kSlotList.GetItem(m_kSlotList.ItemCount - 1)).DisableSlot();
			break;
		case 5:
			UISquadSelect_ListItem(m_kSlotList.GetItem(m_kSlotList.ItemCount - 1)).DisableSlot();
			break;
		case 6:
			break;
		default:
			//UISquadSelect_ListItem(m_kSlotList2.GetItem(m_kSlotList2.ItemCount - 1)).DisableSlot();
			break;
		}
	}

	// HAX: If we show one extra slot, we add the other slot and hide it to keep the list aligned with the pawns - sbatista
	//if(ShowExtraSlot1() && !ShowExtraSlot2())
	//{
 		//if(SoldierSlotCount == 4)
			//UISquadSelect_ListItem(m_kSlotList.GetItem(m_kSlotList.ItemCount - 1)).Hide();
	//}
	//update lower List
	for(SlotIndex = 0; SlotIndex < SlotListOrder.Length; ++SlotIndex)
	{
		SquadIndex = SlotListOrder[SlotIndex];
		PawnIndex = SlotListOrder[SlotIndex];

		// The slot list may contain more information/slots than available soldiers, so skip if we're reading outside the current soldier availability. 
		if( SquadIndex >= SoldierSlotCount1 )
			continue;

		if( SquadIndex < XComHQ.Squad.length && XComHQ.Squad[SquadIndex].ObjectID > 0 )
		{
			if (UnitPawns[SquadIndex] != none)
			{
				m_kPawnMgr.ReleaseCinematicPawn(self, UnitPawns[SquadIndex].ObjectID);
			}
			
			UnitPawns[SquadIndex] = CreatePawn(XComHQ.Squad[SquadIndex], SquadIndex);
		}

		// We want the slots to match the visual order of the pawns in the slot list.
		ListItem = UISquadSelect_ListItem(m_kSlotList.GetItem(ListItemIndex));
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[SquadIndex].ObjectID));
		if (RequiredSpecialSoldiers.Length > 0 && UnitState != none && RequiredSpecialSoldiers.Find(UnitState.GetMyTemplateName()) != INDEX_NONE)
			ListItem.UpdateData(SquadIndex, true, true, false, UnitState.GetSoldierClassTemplate().CannotEditSlots); // Disable customization or removing any special soldier required for the mission
		else
			ListItem.UpdateData(SquadIndex, bDisableEdit, bDisableDismiss, bDisableLoadout);
		++ListItemIndex;
	}

	// HAX: If we have an odd number of slots for lower list, add an extra slot and hide it to keep list aligned with pawns
	//if(m_kSlotList.ItemCount % 2 == 1)
 		//UISquadSelect_ListItem_LW(m_kSlotList.GetItem(m_kSlotList.ItemCount - 1)).Hide();

	//update upper List
	if(m_kSlotList2 != none)
	{
		for(SlotIndex = 0; SlotIndex < SlotListOrder2.Length; ++SlotIndex)
		{
			SquadIndex = SoldierSlotCount1 + SlotListOrder2[SlotIndex];
			PawnIndex = 6 + SlotListOrder2[SlotIndex];

			// The slot list may contain more information/slots than available soldiers, so skip if we're reading outside the current soldier availability. 
			if( SquadIndex >= SoldierSlotCount )
				continue;

			if( SquadIndex < XComHQ.Squad.length && XComHQ.Squad[SquadIndex].ObjectID > 0 )
			{
				if (UnitPawns[SquadIndex] != none)
				{
					m_kPawnMgr.ReleaseCinematicPawn(self, UnitPawns[PawnIndex].ObjectID);
				}
			
				UnitPawns[PawnIndex] = CreatePawn(XComHQ.Squad[SquadIndex], PawnIndex);
			}

			// We want the slots to match the visual order of the pawns in the slot list.
			ListItem = UISquadSelect_ListItem(m_kSlotList2.GetItem(ListItemIndex2));
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[SquadIndex].ObjectID));
			if (RequiredSpecialSoldiers.Length > 0 && UnitState != none && RequiredSpecialSoldiers.Find(UnitState.GetMyTemplateName()) != INDEX_NONE)
				ListItem.UpdateData(SquadIndex, true, true, false, UnitState.GetSoldierClassTemplate().CannotEditSlots); // Disable customization or removing any special soldier required for the mission
			else
				ListItem.UpdateData(SquadIndex, bDisableEdit, bDisableDismiss, bDisableLoadout);
			++ListItemIndex2;
		}
		// HAX: If we have an odd number of slots for lower list, add an extra slot and hide it to keep list aligned with pawns
		//if(m_kSlotList2.ItemCount % 2 == 1)
 			//UISquadSelect_ListItem_LW(m_kSlotList2.GetItem(m_kSlotList2.ItemCount - 1)).Hide();
	}

	StoreGameStateChanges();
	bDirty = false;

	if(m_bUpperRowActive)
		SwitchActiveRow(m_kSlotList2);
	else
		SwitchActiveRow(m_kSlotList);

	MissionState = XComGameState_MissionSite(History.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
	if (MissionState.GetMissionSource().RequireLaunchMissionPopupFn != none && MissionState.GetMissionSource().RequireLaunchMissionPopupFn(MissionState))
	{
		// If the mission source requires a unique launch mission warning popup which has not yet been displayed, show it now
		if (!MissionState.bHasSeenLaunchMissionWarning)
		{
			`HQPRES.UILaunchMissionWarning(MissionState);
		}
	}

	`XEVENTMGR.TriggerEvent('PostSquadSelect_UpdateData', self, self);
}

simulated function UpdateNavHelp()
{
	//local XComHeadquartersCheatManager CheatMgr;
	local XComGameState_LWToolboxOptions ToolboxOptions;
	local bool bOnSkippableMission;
	local XComGameState_MissionSite MissionState;

	LaunchButton.SetDisabled(!CanLaunchMission());
	LaunchButton.SetTooltipText(GetTooltipText());

	if( `HQPRES != none )
	{
		//CheatMgr = XComHeadquartersCheatManager(GetALocalPlayerController().CheatManager);
		`HQPRES.m_kAvengerHUD.NavHelp.ClearButtonHelp();
	
		if( !bNoCancel )
			`HQPRES.m_kAvengerHUD.NavHelp.AddBackButton(CloseScreen);

		if(CrossModTriggeredEvent('OnCheckStripItemsNavHelp', true))
			`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strStripItems, "", OnStripItems, false, m_strTooltipStripItems);

		if(CrossModTriggeredEvent('OnCheckStripGearNavHelp', true))
			`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strStripGear, "", OnStripGear, false, m_strTooltipStripGear);
		if(CrossModTriggeredEvent('OnCheckStripWeaponsNavHelp', true))
			`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strStripWeapons, "", OnStripWeapons, false, m_strTooltipStripWeapons);

		if (class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('T0_M5_WelcomeToEngineering') && CrossModTriggeredEvent('OnCheckBuildItemsNavHelp', true))
			`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strBuildItems, "", OnBuildItems, false, m_strTooltipBuildItems);

		if(CrossModTriggeredEvent('OnCheckClearSquadNavHelp', true))
			`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strClearSquad, "", OnClearSquad, false, m_strTooltipClearSquad);
		if(CrossModTriggeredEvent('OnCheckFillSquadNavHelp', true))
			`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strAutofillSquad, "", OnFillSquad, false, m_strTooltipAutofillSquad);

		MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));

		switch(MissionState.GetMissionSource().DataName)
		{
		case 'MissionSource_RecoverFlightDevice':
		case 'MissionSource_AvengerDefense':
		case 'MissionSource_AlienNetwork':
			bOnSkippableMission = false;
			break;
		default:
			bOnSkippableMission = true;
			break;
		}

		if(MissionState.GetMissionSource().bGoldenPath)
			bOnSkippableMission = false;

		//AlienHunters compatibility
		if(default.UnskippableMissionNames.Find(MissionState.GeneratedMission.Mission.MissionName) != -1)
			bOnSkippableMission = false;

		ToolboxOptions = GetToolboxOptions();
		if(bOnSkippableMission)
		{
			if(CrossModTriggeredEvent('OnCheckSimCombatNavHelp', ToolboxOptions.bEnableSimCombat))
				`HQPRES.m_kAvengerHUD.NavHelp.AddCenterHelp(m_strSimCombat, "", OnSimCombat, !CanLaunchMission(), m_strTooltipSimCombat);
		}
	}
}

simulated function bool CrossModTriggeredEvent(name EventName, bool bDefault)
{
	local LWTuple CheckStatusTuple;

	CheckStatusTuple = new class'LWTuple';
	CheckStatusTuple.Id = EventName;
	CheckStatusTuple.Data.Add(2);
	CheckStatusTuple.Data[0].kind = LWTVBool;
	CheckStatusTuple.Data[0].b = bDefault;
	`XEVENTMGR.TriggerEvent(EventName, CheckStatusTuple, self);
	return CheckStatusTuple.Data[0].b;
}

simulated function XComGameState_Unit GetBestDeployableSoldier(XComGameState_HeadquartersXCom XComHQState, optional bool bDontIncludeSquad=false, optional bool bAllowWoundedSoldiers = false)
{
	local array<XComGameState_Unit> DeployableSoldiers;
	local XComGameState_Unit UnitState;
	local LWTuple DeployableSoldiersTuple;
	local int idx, HighestRank;

	DeployableSoldiers = XComHQState.GetDeployableSoldiers(bDontIncludeSquad, bAllowWoundedSoldiers);

	DeployableSoldiersTuple = new class'LWTuple';
	DeployableSoldiersTuple.Id = 'DeployableSoldiers';
	DeployableSoldiersTuple.Data.Add(DeployableSoldiers.Length);
	for(idx = 0; idx < DeployableSoldiers.Length; idx++)
	{
		DeployableSoldiersTuple.Data[idx].kind = LWTVObject;
		DeployableSoldiersTuple.Data[idx].o = DeployableSoldiers[idx];
	}
	`XEVENTMGR.TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self);

	DeployableSoldiers.Length = 0;
	for(idx = 0; idx < DeployableSoldiersTuple.Data.Length; idx++)
	{
		if(DeployableSoldiersTuple.Data[idx].kind == LWTVObject)
		{
			UnitState = XComGameState_Unit(DeployableSoldiersTuple.Data[idx].o);
			if(UnitState != none)
			{
				DeployableSoldiers.AddItem(UnitState);
			}
		}
	}

	if(DeployableSoldiers.Length == 0)
	{
		return none;
	}

	HighestRank = 0;

	for(idx = 0; idx < DeployableSoldiers.Length; idx++)
	{
		if(DeployableSoldiers[idx].GetRank() > HighestRank)
		{
			HighestRank = DeployableSoldiers[idx].GetRank();
		}
	}

	for(idx = 0; idx < DeployableSoldiers.Length; idx++)
	{
		if(DeployableSoldiers[idx].GetRank() < HighestRank)
		{
			DeployableSoldiers.Remove(idx, 1);
			idx--;
		}
	}

	return (DeployableSoldiers[`SYNC_RAND(DeployableSoldiers.Length)]);
}

simulated function OnClearSquad()
{
	local XComGameStateHistory History;
	local int idx;
	local XComGameState_Unit UnitState;
	local GeneratedMissionData MissionData;
	local array<name> RequiredSpecialSoldiers;

	History = `XCOMHISTORY;
	MissionData = XComHQ.GetGeneratedMissionData(XComHQ.MissionRef.ObjectID);
	RequiredSpecialSoldiers = MissionData.Mission.SpecialSoldiers;

	for (idx = 0; idx < GetTotalSlots(); idx++)
	{
		m_iSelectedSlot = idx;
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[idx].ObjectID));
		if (UnitState != none && RequiredSpecialSoldiers.Find(UnitState.GetMyTemplateName()) != -1)
		{
		}
		else
		{
			ChangeSlot();
		}
	}
	LaunchButton.SetDisabled(!CanLaunchMission());
	UpdateData();
	SignalOnReceiveFocus();
}

simulated function OnFillSquad()
{
	UpdateData(true);
	LaunchButton.SetDisabled(!CanLaunchMission());
	UpdateData();  // for some reason this is needed or only some of the pawns will be correctly displayed
	SignalOnReceiveFocus();
}

//LWS keeping the patch 6 version, since no controller support
simulated function OnBuildItems()
{
	// This is a screen jump, but NOT a hotlink, so we DO NOT clear down to the HUD. 
	bDirty = true; // Force a refresh of the pawns when you come back, in case the user purchased new weapons or armor

	// Make sure the camera is set since we are leaving
	SnapCamera();

	// Wait a frame for camera set to complete
	SetTimer(0.1f, false, nameof(GoToBuildItemScreen));
}

//updated to use GetBestDeployableSoldier delegate from SquadSelect options
simulated function AddHiddenSoldiersToSquad(int NumSoldiersToAdd)
{
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local GeneratedMissionData MissionData;
	local bool bAllowWoundedSoldiers, bSquadModified;
	local int idx;
	
	History = `XCOMHISTORY;
	UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Extra Hidden Soldiers to Squad");

	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(UpdateState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	UpdateState.AddStateObject(XComHQ);

	MissionData = XComHQ.GetGeneratedMissionData(XComHQ.MissionRef.ObjectID);
	bAllowWoundedSoldiers = MissionData.Mission.AllowDeployWoundedUnits;
	
	// add extra soldiers to the squad if possible
	for (idx = MaxDisplayedSlots; idx < (MaxDisplayedSlots + NumSoldiersToAdd); idx++)
	{
		if (XComHQ.Squad.Length == idx || XComHQ.Squad[idx].ObjectID == 0)
		{
			UnitState = GetBestDeployableSoldier(XComHQ, true, bAllowWoundedSoldiers);
			if (UnitState != none)
			{
				UnitState = XComGameState_Unit(UpdateState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
				UpdateState.AddStateObject(UnitState);
				UnitState.ApplyBestGearLoadout(UpdateState);
				XComHQ.Squad[idx] = UnitState.GetReference();
				bSquadModified = true;
			}
		}
	}
	
	if (bSquadModified)
		`GAMERULES.SubmitGameState(UpdateState);
	else
		History.CleanupPendingGameState(UpdateState);
}

simulated function int GetTotalSlots()
{
	local int Result;

	Result = SoldierSlotCount;

	switch(SoldierSlotCount)
	{
	case 1:
	case 2:
	case 3:
	case 4:
		if(ShowExtraSlot1() && !UnlockedExtraSlot1()) Result++;
		if(ShowExtraSlot2() && !UnlockedExtraSlot2()) Result++;

		// HAX: If we show one extra slot, add the other slot to keep the list aligned with the pawns (it gets hidden in UpdateData) - sbatista
		//if(ShowExtraSlot1() && !ShowExtraSlot2()) Result++;
		break;
	case 5:
		if((ShowExtraSlot1() && !UnlockedExtraSlot1()) ||
		   (ShowExtraSlot2() && !UnlockedExtraSlot2())) 
		{
			Result++;
		}
		break;
	default:
		break;
	}

	return Result;
}

simulated function bool FrontRowSoldierHasPromotion()
{
	local int SquadIndex;
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	for(SquadIndex = 0; SquadIndex < SoldierSlotCount1; ++SquadIndex)
	{

		if( SquadIndex < XComHQ.Squad.length && XComHQ.Squad[SquadIndex].ObjectID > 0 )
		{
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[SquadIndex].ObjectID));
			if(UnitState.ShowPromoteIcon())
			{
				//`LOG("UISquadSelect_LW: Front Row Soldier has promotion",, 'LW_Toolbox');
				return true;
			}
		}
	}
	return false;
}

simulated function bool FrontRowSoldierHasHeavyWeapon()
{
	local int SquadIndex;
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	for(SquadIndex = 0; SquadIndex < SoldierSlotCount1; ++SquadIndex)
	{

		if( SquadIndex < XComHQ.Squad.length && XComHQ.Squad[SquadIndex].ObjectID > 0 )
		{
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[SquadIndex].ObjectID));
			if(UnitState.HasHeavyWeapon())
			{
				//`LOG("UISquadSelect_LW: Front Row Soldier has heavy weapon",, 'LW_Toolbox');
				return true;
			}
		}
	}
	return false;
}

simulated function SnapCamera()
{
	if(m_bUpperRowActive)
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Back, 0);
	else
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Front, 0);
}

simulated function SnapStartCamera()
{
	`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Start, 0);
}

simulated function SwitchCameraToEditSoldier(optional float Time = 0.0f)
{
	`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_EditSoldier, Time);
}

simulated function SwitchCamera(optional float Time = 0.0f, optional bool bForceFront = false)
{
	if(m_bUpperRowActive && !bForceFront)
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Back, Time);
	else
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Front, Time);
}

simulated function OnReceiveFocus()
{
	//Don't reset the camera during the launch sequence.
	//This case occurs, for example, when closing the "reconnect controller" dialog.
	//INS:
	if(bLaunched)
		return;
		
	SwitchCamera(0.5);

	super(UIScreen).OnReceiveFocus();
	m_bNoRefreshOnLoseFocus = false;

	UpdateNavHelp();

	if(bDirty) 
		UpdateData();
}

//LWS keeping patch 6 version
simulated function OnLoseFocus()
{
	super.OnLoseFocus();
	StoreGameStateChanges(); // need to save the state of the screen when we leave it
}

simulated function RefreshDisplay()
{
	local int SlotIndex, SquadIndex;
	local UISquadSelect_ListItem ListItem; 

	for( SlotIndex = 0; SlotIndex < SlotListOrder.Length; ++SlotIndex )
	{
		SquadIndex = SlotListOrder[SlotIndex];

		// The slot list may contain more information/slots than available soldiers, so skip if we're reading outside the current soldier availability. 
		if( SquadIndex >= SoldierSlotCount1 )
			continue;

		//We want the slots to match the visual order of the pawns in the slot list. 
		ListItem = UISquadSelect_ListItem(m_kSlotList.GetItem(SlotIndex));
		ListItem.UpdateData(SquadIndex);
	}
	for( SlotIndex = 0; SlotIndex < SlotListOrder2.Length; ++SlotIndex )
	{
		SquadIndex = SoldierSlotCount1 + SlotListOrder2[SlotIndex];

		// The slot list may contain more information/slots than available soldiers, so skip if we're reading outside the current soldier availability. 
		if( SquadIndex >= SoldierSlotCount2 )
			continue;

		//We want the slots to match the visual order of the pawns in the slot list. 
		ListItem = UISquadSelect_ListItem(m_kSlotList2.GetItem(SlotIndex));
		ListItem.UpdateData(SquadIndex);
	}
}

simulated function bool OnUnrealCommand(int cmd, int arg)
{
	local bool bHandled;

	// Only pay attention to presses or repeats; ignoring other input types
	// NOTE: Ensure repeats only occur with arrow keys
	if ( !CheckInputIsReleaseOrDirectionRepeat(cmd, arg) )
		return false;

	if(!bIsVisible)
		return true;

	bHandled = true;
	switch( cmd )
	{
		// OnAccept
		case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
			//OnAccept(); //TODO: activate this 
			//Movie.Pres.PlayUISound(eSUISound_MenuSelect);
			break;

		case class'UIUtilities_Input'.const.FXS_BUTTON_B:
		case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
		case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
			if(!bNoCancel)
			{
				CloseScreen();
				Movie.Pres.PlayUISound(eSUISound_MenuClose);
			}
			break;

		case class'UIUtilities_Input'.const.FXS_BUTTON_RBUMPER:
			OnStripGear();
			break;

		case class'UIUtilities_Input'.const.FXS_BUTTON_Y:
			OnLaunchMission(LaunchButton);
			break;

		case class'UIUtilities_Input'.const.FXS_BUTTON_START:
			`HQPRES.UIPauseMenu( ,true );
			break;
			
		case class'UIUtilities_Input'.const.FXS_DPAD_LEFT:
		case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_LEFT :
		case class'UIUtilities_Input'.const.FXS_ARROW_LEFT :
			bHandled = true; // added to prevent CTD from double Arrow Left: TTP 483
			break;

		default:
			bHandled = false;
			break;
	}

	return bHandled || super(UIScreen).OnUnrealCommand(cmd, arg);
}

state Cinematic_PawnsIdling 
{
	simulated event BeginState(name PreviousStateName)
	{
		StartPawnAnimation('CharacterCustomization', 'Gremlin_Idle');
	
	}
}

simulated function string GetTooltipText()
{
	local string Text;
	local XComGameState_MissionSite MissionState;

	Text = super.GetTooltipText();
	if(!HasBaseSoldiers())
		Text = m_strTooltipNeedsFrontRowSoldier;

	
	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
	if (MissionState.GetMissionSource().CanLaunchMissionFn != none && !MissionState.GetMissionSource().CanLaunchMissionFn(MissionState))
	{
		Text = MissionState.GetMissionSource().CannotLaunchMissionTooltip;
	}
	
	return Text;
}

simulated function bool CanLaunchMission()
{
	local bool CanLaunch;
	local XComGameState_MissionSite MissionState;

	CanLaunch = super.CanLaunchMission();
	
	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
	if (MissionState.GetMissionSource().CanLaunchMissionFn != none && !MissionState.GetMissionSource().CanLaunchMissionFn(MissionState))
	{
		return false;
	}
	
	if(CanLaunch)
		return HasBaseSoldiers();
}

simulated function bool HasBaseSoldiers()
{
	local int i, BaseSoldierSlots;

	// make sure there's at least one base-slot soldier
	BaseSoldierSlots = class'X2StrategyGameRulesetDataStructures'.static.GetMaxSoldiersAllowedOnMission();
	for(i = 0; i < BaseSoldierSlots; ++i)
	{
		if(XComHQ.Squad[i].ObjectID > 0)
			return true;
	}

	return false;
}
//------------------------------------------------------

//TODO: update this if it's actually used anywhere
//simulated function int GetSlotIndexForUnit(StateObjectReference UnitRef)
//{
	//local int SlotIndex;	//Index into the list of places where a soldier can stand in the after action scene, from left to right
	//local int SquadIndex;	//Index into the HQ's squad array, containing references to unit state objects
//
	//for(SlotIndex = 0; SlotIndex < SlotListOrder.Length; ++SlotIndex)
	//{
		//SquadIndex = SlotListOrder[SlotIndex];
		//if(SquadIndex < XComHQ.Squad.Length)
		//{
			//if(XComHQ.Squad[SquadIndex].ObjectID == UnitRef.ObjectID)
				//return SlotIndex;
		//}
	//}
//
	//return -1;
//}

DefaultProperties
{
	Package   = "/ package/gfxSquadList/SquadList";

	bCascadeFocus = false;
	bHideOnLoseFocus = true;
	bAutoSelectFirstNavigable = false;
	InputState = eInputState_Consume;

	m_strPawnLocationIdentifier = "PreM_UIPawnLocation_SquadSelect_";
	UIDisplayCam = "PreM_UIDisplayCam_SquadSelect";
	//UIDisplayCam_Front = "PreM_UIDisplayCam_SquadSelect";
	UIDisplayCam_Back = "PreM_UIDisplayCam_SquadSelect_Back";
	UIDisplayCam_EditSoldier = "Customize menu location";
	UIDisplayCam_Start="PreM_UIDisplayCam_SquadSelect_Start";

	//Refer to the points / camera setup in CIN_PreMission to understand this array
	SlotListOrder[0] = 4
	SlotListOrder[1] = 1
	SlotListOrder[2] = 0
	SlotListOrder[3] = 2
	SlotListOrder[4] = 3
	SlotListOrder[5] = 5

	//Refer to the points / camera setup in CIN_PreMission to understand this array
	SlotListOrder2[0] = 4
	SlotListOrder2[1] = 2
	SlotListOrder2[2] = 0
	SlotListOrder2[3] = 1
	SlotListOrder2[4] = 3
	SlotListOrder2[5] = 5

	ListHeight = 310.0f
	MaskHeight = 460.0f
	ListItemClipAmount = 211.0f
	UpperRowShiftAmount = 124.0f
	PromoteShiftAmount = 43.0f
	HeavyWeaponShiftAmount = 46.0f
	UpperRowDefaultY = -575.0f
	LowerRowDefaultY = -350.0f

	TweenTime = 0.3f
	TweenDelay = 0.0f

	InactiveAlpha = 50;

}

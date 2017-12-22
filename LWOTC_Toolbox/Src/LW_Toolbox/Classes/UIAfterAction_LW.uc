//---------------------------------------------------------------------------------------
//  FILE:    UIAfterAction_LW
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: This file extends the post-mission squad view to support larger squads.
//--------------------------------------------------------------------------------------- 

class UIAfterAction_LW extends UIAfterAction config(LW_Toolbox);

`include(LW_Toolbox\Src\LW_Toolbox.uci)

var bool m_bBackRowActive;
var UIList m_kSlotList2;
var string UIDisplayCam_Back;			//Name of the point that the camera rests at to display back row soldiers
var config float CameraTransitionTime;

// Constructor
simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super(UIScreen).InitScreen(InitController, InitMovie, InitName);

	//do this to mask NavHelp buttons when running a SimCombat/Autoresolve mission
	`HQPRES.m_kAvengerHUD.NavHelp.ClearButtonHelp();

	Navigator.HorizontalNavigation = true;
	Navigator.LoopSelection = true;

	// get existing states
	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	m_kMissionInfo = Spawn(class'UISquadSelectMissionInfo', self).InitMissionInfo();

	CreatePanels();
	UpdateData();
	UpdateMissionInfo();

	//Delay by a slight amount to let pawns configure. Otherwise they will have Giraffe heads.
	SetTimer(0.2f, false, nameof(StartPostMissionCinematic));

	//SoldierPicture_Head_Armory

	`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_WalkUpStart, 0.0f);
	XComHeadquartersController(`HQPRES.Owner).SetInputState('None');

	// Show header with "After Action" text
	`HQPRES.m_kAvengerHUD.FacilityHeader.SetText(class'UIFacility'.default.m_strAvengerLocationName, m_strAfterActionReport);
	`HQPRES.m_kAvengerHUD.FacilityHeader.Hide();
}

simulated function CreatePanels()
{
	local int i, listX, listWidth, listItemPadding;

	//create front row panels
	listWidth = 0;
	listItemPadding = 6;
	for (i = 0; i < Min(6, XComHQ.Squad.Length); ++i)
	{
		if (XComHQ.Squad[i].ObjectID > 0)
			listWidth += (class'UISquadSelect_ListItem'.default.width + listItemPadding);
	}
	listX = Clamp((Movie.UI_RES_X / 2) - (listWidth / 2), 100, Movie.UI_RES_X / 2);

	m_kSlotList = Spawn(class'UIList', self);
	m_kSlotList.InitList('', listX, -390, Movie.UI_RES_X, 310, true).AnchorBottomLeft();
	m_kSlotList.itemPadding = listItemPadding;

	//create back row panels
	if(XComHQ.Squad.Length > 6)
	{
		listWidth = 0;
		listItemPadding = 6;
		for (i = 6; i < XComHQ.Squad.Length; ++i)
		{
			if (XComHQ.Squad[i].ObjectID > 0)
				listWidth += (class'UISquadSelect_ListItem'.default.width + listItemPadding);
		}
		listX = Clamp((Movie.UI_RES_X / 2) - (listWidth / 2), 100, Movie.UI_RES_X / 2);

		m_kSlotList2 = Spawn(class'UIList', self);
		m_kSlotList2.InitList('', listX, -390, Movie.UI_RES_X, 310, true).AnchorBottomLeft();
		m_kSlotList2.itemPadding = listItemPadding;

		m_kSlotList2.Hide(); // hidden initially
	}
}

//function StartPostMissionCinematic()
//{
	//local int PawnIndex;
	//local XComLevelActor AvengerSunShade;	
	//local SkeletalMeshActor CineDummy;
	//local SkeletalMeshActor IterateActor;	
	//local XComGameState_MissionSite MissionState;
	//local XComGameStateHistory History;
		//
	//`GAME.GetGeoscape().m_kBase.SetAvengerCapVisibility(true);
	//`GAME.GetGeoscape().m_kBase.SetPostMissionSequenceVisibility(true);
//
	//XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).ClientSetCameraFade(false);
	//
	////Turn off the sunshade object that prevents the directional light from affecting the avenger side view
	//foreach AllActors(class'XComLevelActor', AvengerSunShade)
	//{		
		//if(AvengerSunShade.Tag == 'AvengerSunShade')
		//{
			//AvengerSunShade.StaticMeshComponent.bCastHiddenShadow = false;
			//AvengerSunShade.ReattachComponent(AvengerSunShade.StaticMeshComponent);
			//break;
		//}				
	//}
//
	//foreach AllActors(class'SkeletalMeshActor',   IterateActor)
	//{
		//if(IterateActor.Tag == 'Cin_PostMission1_Cinedummy')
		//{
			//CineDummy = IterateActor;
			//break;
		//}
		//else if(IterateActor.Tag == 'AvengerSideView_Dropship')
		//{
			//IterateActor.SetHidden(true); //Hide the skyranger visible during the ant farm side view...
		//}
	//}
//
	//`GAME.GetGeoscape().m_kBase.SetPreMissionSequenceVisibility(false); //make sure the pre-mission skyranger is hidden as well
	//
	////Link the cinematic pawns to the matinee
	//WorldInfo.MyKismetVariableMgr.RebuildVariableMap();
	//for(PawnIndex = 0; PawnIndex < XComHQ.Squad.Length; PawnIndex++)
	//{
		//if(XComHQ.Squad[PawnIndex].ObjectID > 0)
		//{
			//if(UnitPawnsCinematic[PawnIndex] != none)
			//{
				//UnitPawnsCinematic[PawnIndex].Mesh.bUpdateSkelWhenNotRendered = true;
				//UnitPawnsCinematic[PawnIndex].SetBase(CineDummy);				
				//UnitPawnsCinematic[PawnIndex].SetupForMatinee(, true);
				//SetPawnVariable(UnitPawnsCinematic[PawnIndex], string(PawnIndex+1));
			//}
		//}
	//}	
//
	//WorldInfo.MyLocalEnvMapManager.SetEnableCaptures(true);
//
	//Hide();
//
	//WorldInfo.RemoteEventListeners.AddItem(self);
//
	//History = `XCOMHISTORY;	
	//MissionState = XComGameState_MissionSite(History.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
//
	//if(!MissionState.GetMissionSource().bRequiresSkyrangerTravel)
	//{
		//`XCOMGRI.DoRemoteEvent('CIN_StartWithoutFlyIn');
	//}
	//else
	//{
		//`XCOMGRI.DoRemoteEvent('CIN_StartWithFlyIn');
	//}
//
	//`HQPRES.HideLoadingScreen();
//}

simulated function UpdateData()
{
	local bool bMakePawns;
	local int SlotIndex;	//Index into the list of places where a soldier can stand in the after action scene, from left to right
	local int SquadIndex;	//Index into the HQ's squad array, containing references to unit state objects
	local int ListItemIndex;//Index into the array of list items the player can interact with to view soldier status and promote
	local UIAfterAction_ListItem ListItem;	

	bMakePawns = UnitPawns.Length == 0;//We only need to create pawns if we have never had them before	

	//front row
	ListItemIndex = 0;
	for (SlotIndex = 0; SlotIndex < SlotListOrder.Length; ++SlotIndex)
	{
		SquadIndex = SlotListOrder[SlotIndex];
		if (XComHQ.Squad[SquadIndex].ObjectID > 0)
		{
			if (bMakePawns)
			{
				if (ShowPawn(XComHQ.Squad[SquadIndex]))
				{
					UnitPawns[SquadIndex] = CreatePawn(XComHQ.Squad[SquadIndex], SquadIndex, false);
					UnitPawns[SquadIndex].SetVisible(false);
					UnitPawnsCinematic[SquadIndex] = CreatePawn(XComHQ.Squad[SquadIndex], SquadIndex, true);
				}
			}

			if (m_kSlotList.itemCount > ListItemIndex)
			{
				ListItem = UIAfterAction_ListItem(m_kSlotList.GetItem(ListItemIndex));
			}
			else
			{
				ListItem = UIAfterAction_ListItem(m_kSlotList.CreateItem(class'UIAfterAction_ListItem')).InitListItem();
			}

			ListItem.UpdateData(XComHQ.Squad[SquadIndex]);

			++ListItemIndex;
		}
	}

	//back row
	ListItemIndex = 0;
	for (SlotIndex = 0; SlotIndex < SlotListOrder.Length; ++SlotIndex)
	{
		SquadIndex = 6 + SlotListOrder[SlotIndex];
		if (SquadIndex < XComHQ.Squad.Length)
		{	
			if (XComHQ.Squad[SquadIndex].ObjectID > 0)
			{
				if (bMakePawns)
				{
					if (ShowPawn(XComHQ.Squad[SquadIndex]))
					{
						UnitPawns[SquadIndex] = CreatePawn(XComHQ.Squad[SquadIndex], SquadIndex, false);
						UnitPawns[SquadIndex].SetVisible(false);
						UnitPawnsCinematic[SquadIndex] = CreatePawn(XComHQ.Squad[SquadIndex], SquadIndex, true);
					}
				}

				if (m_kSlotList2.itemCount > ListItemIndex)
				{
					ListItem = UIAfterAction_ListItem(m_kSlotList2.GetItem(ListItemIndex));
				}
				else
				{
					ListItem = UIAfterAction_ListItem(m_kSlotList2.CreateItem(class'UIAfterAction_ListItem')).InitListItem();
				}

				ListItem.UpdateData(XComHQ.Squad[SquadIndex]);

				++ListItemIndex;
			}
		}
	}

}

//simulated function UpdateMissionInfo()
//{
	//local GeneratedMissionData MissionData;
	//local XComGameState_MissionSite MissionState;
//
	//m_kMissionInfo.SetAnchor(class'UIUtilities'.const.ANCHOR_TOP_LEFT).SetY(50);
//
	//MissionData = XComHQ.GetGeneratedMissionData(XComHQ.MissionRef.ObjectID);
	//MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
//
	//m_kMissionInfo.UpdateData(MissionData.BattleOpName, MissionState.GetMissionObjectiveText(), "", "");
//}

//TODO: update this if it's actually used anywhere
//simulated function int GetSlotIndexForUnit(StateObjectReference UnitRef)
//{
	//local int SlotIndex;	//Index into the list of places where a soldier can stand in the after action scene, from left to right
	//local int SquadIndex;	//Index into the HQ's squad array, containing references to unit state objects
//
	//for (SlotIndex = 0; SlotIndex < SlotListOrder.Length; ++SlotIndex)
	//{
		//SquadIndex = SlotListOrder[SlotIndex];
		//if (SquadIndex < XComHQ.Squad.Length)
		//{	
			//if (XComHQ.Squad[SquadIndex].ObjectID == UnitRef.ObjectID)
				//return SlotIndex;
		//}
	//}
//
	//return -1;
//}

simulated function UpdateNavHelp()
{
	local UINavigationHelp NavHelp;
	NavHelp = `HQPRES.m_kAvengerHUD.NavHelp;
	NavHelp.ClearButtonHelp();
	NavHelp.AddContinueButton(OnContinue);
	if(m_bBackRowActive)
	{
		NavHelp.AddBackButton(OnBack);
	}
}

simulated function OnContinue()
{		
	local bool HasBackRowSoldiers;
	local int idx;

	class'XComGameStateContext_StrategyGameRule'.static.RemoveInvalidSoldiersFromSquad();

	HasBackRowSoldiers = false;
	if (XComHQ.Squad.Length > 6)
	{
		for (idx = 6; idx < XComHQ.Squad.Length; idx++)
		{
			if (XComHQ.Squad[idx].ObjectID > 0)
			{
				HasBackRowSoldiers = true;
				break;
			}
		}
	}

	if(m_bBackRowActive || !HasBackRowSoldiers)
	{
		//terminate
		UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("After Action");
		`XEVENTMGR.TriggerEvent('PostAfterAction',,,UpdateState);
		`GAMERULES.SubmitGameState(UpdateState);

		`GAME.GetGeoscape().m_kBase.SetAvengerCapVisibility(false);

		CloseScreen();

		`HQPRES.UIInventory_LootRecovered();
	}
	else
	{
		`TBTRACE("UIAfterAction_LW: Shifting camera to back row");
		m_bBackRowActive = true;
		UpdateNavHelp();
		m_kSlotList.Hide();
		m_kSlotList2.Show();
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Back, CameraTransitionTime);
	}

}

simulated function OnBack()
{	
	m_bBackRowActive = false;
	UpdateNavHelp();
	m_kSlotList2.Hide();
	m_kSlotList.Show();
	`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Default, CameraTransitionTime);
	
}

//simulated function bool OnUnrealCommand(int cmd, int arg)
//{
	//local bool bHandled;	
//
	//// Only pay attention to presses or repeats; ignoring other input types
	//// NOTE: Ensure repeats only occur with arrow keys
	//if ( !CheckInputIsReleaseOrDirectionRepeat(cmd, arg) )
		//return false;
//
	//bHandled = true;
//
	//switch( cmd )
	//{
		//// OnAccept
//`if(`notdefined(FINAL_RELEASE))
		//case class'UIUtilities_Input'.const.FXS_KEY_TAB:
//`endif
		//case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		////TEST//case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
		//case class'UIUtilities_Input'.const.FXS_BUTTON_B:
		//case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
		//case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
			//if( bRecievedShowHUDRemoteEvent )
			//{				
				////Only process continue once the player has seen the HUD
				//OnContinue();
			//}
			//else
			//{
				//bHandled = false;
			//}
			//break;
		//case class'UIUtilities_Input'.const.FXS_BUTTON_START:
			//`HQPRES.UIPauseMenu( ,true );
			//break;
		//default:
			//bHandled = false;
			//break;
	//}
//
	//return bHandled || super(UIScreen).OnUnrealCommand(cmd, arg);
//}

simulated function OnReceiveFocus()
{
	super(UIScreen).OnReceiveFocus();
	UpdateNavHelp();
	UpdateData();
	if(m_bBackRowActive)
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Back, 0.0f);  
	else
		`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Default, 0.0f);
}

//simulated function OnLoseFocus()
//{
	//super(UIScreen).OnLoseFocus();
	//XComHQPresentationLayer(Movie.Pres).m_kAvengerHUD.NavHelp.ClearButtonHelp();
//}

//simulated function OnRemoved()
//{
	//super(UIScreen).OnRemoved();
	//WorldInfo.RemoteEventListeners.RemoveItem(self);
	//ClearPawns();	
//}

//------------------------------------------------------

//simulated function bool ShowPawn(StateObjectReference UnitRef)
//{
	//local XComGameState_Unit Unit;
	//if(UnitRef.ObjectID > 0)
	//{
		//Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
		//return Unit.IsAlive() && !Unit.bCaptured; //At present, we show the pawn for all cases except death and capture
	//}
	//return false;
//}

//simulated function SetGremlinMatineeVariable(int idx, XComUnitPawn GremlinPawn)
//{
	//local array<SequenceVariable> OutVariables;
	//local SequenceVariable SeqVar;
	//local SeqVar_Object SeqVarPawn;
//
	//WorldInfo.MyKismetVariableMgr.GetVariable(name("Gremlin"$(idx+1)), OutVariables);
	//foreach OutVariables(SeqVar)
	//{
		//SeqVarPawn = SeqVar_Object(SeqVar);
		//if(SeqVarPawn != none)
		//{
			//SeqVarPawn.SetObjectValue(None);
			//SeqVarPawn.SetObjectValue(GremlinPawn);
		//}
	//}
//}

simulated function XComUnitPawn CreatePawn(StateObjectReference UnitRef, int index, bool bCinematic)
{
	local name LocationName;
	local PointInSpace PlacementActor;
	local XComGameState_Unit UnitState;
	local XComUnitPawn UnitPawn, GremlinPawn;
	local Vector ZeroVec;
	local Rotator ZeroRot;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));

	`TBTRACE("UIAfterAction_LW: Creating Pawn, Index=" $ index,, 'LW_Toolbox');

	if(!bCinematic)
	{
		LocationName = name(m_strPawnLocationIdentifier $ index);

		PlacementActor = GetPlacementActor(LocationName);

		UnitPawn = `HQPRES.GetUIPawnMgr().RequestPawnByState(self, UnitState, PlacementActor.Location, PlacementActor.Rotation);
		UnitPawn.GotoState('CharacterCustomization');

		UnitPawn.CreateVisualInventoryAttachments(`HQPRES.GetUIPawnMgr(), UnitState); // spawn weapons and other visible equipment

		GremlinPawn = `HQPRES.GetUIPawnMgr().GetCosmeticPawn(eInvSlot_SecondaryWeapon, UnitRef.ObjectID);
		if (GremlinPawn != none)
		{
			SetGremlinMatineeVariable(index, GremlinPawn);
			GremlinPawn.SetLocation(PlacementActor.Location);
			GremlinPawn.SetVisible(false);
		}
	}
	else
	{
		UnitPawn = UnitState.CreatePawn(self, ZeroVec, ZeroRot); //Create a throw-away pawn
		UnitPawn.CreateVisualInventoryAttachments(none, UnitState); // spawn weapons and other visible equipment
	}
		
	return UnitPawn;
}

//simulated function XComUnitPawn GetPawn(StateObjectReference UnitRef)
//{
	//local int i;
//
	//for(i = 0; i < XComHQ.Squad.Length; ++i)
	//{
		//if(XComHQ.Squad[i].ObjectID == UnitRef.ObjectID)
		//{
			//return UnitPawns[i];
		//}
	//}
//
	//return none;
//}

//simulated function SetPawn(StateObjectReference UnitRef, XComUnitPawn NewPawn)
//{
	//local int i;
//
	//for(i = 0; i < XComHQ.Squad.Length; ++i)
	//{
		//if(XComHQ.Squad[i].ObjectID == UnitRef.ObjectID)
		//{
			//UnitPawns[i] = NewPawn;
		//}
	//}	
//}

//simulated function name GetPawnLocationTag(StateObjectReference UnitRef, optional string PawnLocationItentifier = m_strPawnLocationIdentifier)
//{	
	//local int i;
//
	//for(i = 0; i < XComHQ.Squad.Length; ++i)
	//{
		//if(XComHQ.Squad[i].ObjectID == UnitRef.ObjectID)
		//{
			//return name(PawnLocationItentifier $ i);
		//}
	//}
//
	//return '';
//}

//simulated function string GetPromotionBlueprintTag(StateObjectReference UnitRef)
//{
	//local int i, HealTimeHours;
	//local XComGameState_Unit UnitState;
//
	//for(i = 0; i < XComHQ.Squad.Length; ++i)
	//{
		//if(XComHQ.Squad[i].ObjectID == UnitRef.ObjectID)
		//{
			//UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.Squad[i].ObjectID));
			//UnitState.GetWoundState(HealTimeHours);
			//if(UnitState.IsGravelyInjured(HealTimeHours))
				//return UIBlueprint_Prefix_Wounded $ i;
			//else
				//return UIBlueprint_Prefix $ i;
		//}
	//}
//
	//return "";
//}

//simulated function ClearPawns()
//{
	//local XComUnitPawn UnitPawn;
	//foreach UnitPawns(UnitPawn)
	//{
		//if(UnitPawn != none)
		//{
			//`HQPRES.GetUIPawnMgr().ReleasePawn(self, UnitPawn.ObjectID);
		//}
	//}
//}

//simulated function ResetUnitLocations()
//{
	//local int i;
	//local XComUnitPawn UnitPawn, GremlinPawn;
	//local PointInSpace PlacementActor;
//
	//for(i = 0; i < XComHQ.Squad.Length; ++i)
	//{
		//UnitPawn = UnitPawns[i];
		//PlacementActor = GetPlacementActor(GetPawnLocationTag(XComHQ.Squad[i]));
//
		//if(UnitPawn != none && PlacementActor != None)
		//{
			//UnitPawn.SetLocation(PlacementActor.Location);
			//UnitPawn.SetRotation(PlacementActor.Rotation);
			//GremlinPawn = `HQPRES.GetUIPawnMgr().GetCosmeticPawn(eInvSlot_SecondaryWeapon, UnitPawn.ObjectID);
			//if(GremlinPawn != none)
			//{
				//GremlinPawn.SetLocation(PlacementActor.Location);
				//GremlinPawn.SetRotation(PlacementActor.Rotation);
			//}
		//}
	//}
//}

simulated function OnPromote(StateObjectReference UnitRef)
{
	`HQPRES.UIArmory_Promotion(UnitRef);
	MovePawns_LW(UnitRef);
}

function MovePawns_LW(StateObjectReference UnitBeingPromoted)
{
	local int i;
	local XComUnitPawn UnitPawn, GremlinPawn;
	local PointInSpace PlacementActor;
	//local StateObjectReference UnitBeingPromoted;

	//if(`SCREENSTACK.IsInStack(class'UIArmory_Promotion'))
		//UnitBeingPromoted = UIArmory_Promotion(`SCREENSTACK.GetScreen(class'UIArmory_Promotion')).UnitReference;
//
	//if(UnitBeingPromoted == none)  // handle case with PerkPack
	//{
//
	//}

	for(i = 0; i < XComHQ.Squad.Length; ++i)
	{
		if(XComHQ.Squad[i] == UnitBeingPromoted)
			continue;

		PlacementActor = GetPlacementActor(GetPawnLocationTag(XComHQ.Squad[i], m_strPawnLocationSlideawayIdentifier));
		UnitPawn = UnitPawns[i];

		if(UnitPawn != none && PlacementActor != none)
		{
			UnitPawn.SetLocation(PlacementActor.Location);
			GremlinPawn = `HQPRES.GetUIPawnMgr().GetCosmeticPawn(eInvSlot_SecondaryWeapon, UnitPawn.ObjectID);
			if(GremlinPawn != none)
				GremlinPawn.SetLocation(PlacementActor.Location);
		}
	}
}

simulated function PointInSpace GetPlacementActor(name PawnLocationTag)
{
	local Actor TmpActor;
	local array<Actor> Actors;
	local XComBlueprint Blueprint;
	local PointInSpace PlacementActor;

	foreach WorldInfo.AllActors(class'PointInSpace', PlacementActor)
	{
		if (PlacementActor != none && PlacementActor.Tag == PawnLocationTag)
			break;
	}

	if(PlacementActor == none)
	{
		foreach WorldInfo.AllActors(class'XComBlueprint', Blueprint)
		{
			if (Blueprint.Tag == PawnLocationTag)
			{
				Blueprint.GetLoadedLevelActors(Actors);
				foreach Actors(TmpActor)
				{
					PlacementActor = PointInSpace(TmpActor);
					if(PlacementActor != none)
					{
						break;
					}
				}
			}
		}
	}

	return PlacementActor;
}

//During the after action report, the characters walk up to the camera - this state represents that time
//state Cinematic_PawnsWalkingUp
//{
	//simulated event BeginState(name PreviousStateName)
	//{
		//StartWalkAnimForPawns();
		//WalkUpEvent();
		//StartCameraMove();
	//}
//
	//function StartWalkAnimForPawns()
	//{
		//local int PawnIndex;
		//local XComGameState_Unit UnitState;
		//local XComGameStateHistory History;
		//local X2SoldierPersonalityTemplate PersonalityData;
		//local XComHumanPawn HumanPawn;
		//local XComUnitPawn GremlinPawn;
//
		//History = `XCOMHISTORY;
//
		//for(PawnIndex = 0; PawnIndex < XComHQ.Squad.Length; ++PawnIndex)
		//{
			//if(XComHQ.Squad[PawnIndex].ObjectID > 0)
			//{
				//UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[PawnIndex].ObjectID));
				//PersonalityData = UnitState.GetPersonalityTemplate();
//
				//UnitPawns[PawnIndex].EnableFootIK(false);
				//UnitPawns[PawnIndex].SetVisible(true);
//
				//HumanPawn = XComHumanPawn(UnitPawns[PawnIndex]);	
				//if(HumanPawn != none)
				//{
					//HumanPawn.GotoState('SquadLineup_Walkup');
					//GremlinPawn = `HQPRES.GetUIPawnMgr().GetCosmeticPawn(eInvSlot_SecondaryWeapon, HumanPawn.ObjectID);
					//if (GremlinPawn != none)
					//{
						//GremlinPawn.SetVisible(true);
						//GremlinPawn.GotoState('Gremlin_Walkup');
					//}
				//}
				//else
				//{
					////If not human, just play the idle
					//UnitPawns[PawnIndex].PlayFullBodyAnimOnPawn(PersonalityData.IdleAnimName, true);
				//}
			//}
		//}
	//}
//
	//function WalkUpEvent()
	//{
		//local XComGameStateHistory History;
		//local XComGameState_BattleData BattleData;
//
		//History = `XCOMHISTORY;
		//BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
//
		//UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("After Action Walk Up Event");
		//`XEVENTMGR.TriggerEvent('AfterActionWalkUp', , , UpdateState);
		//`GAMERULES.SubmitGameState(UpdateState);
//
		//if(BattleData.bGreatMission)
		//{
			//UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("After Action Great Mission Event");
			//`XEVENTMGR.TriggerEvent('AfterAction_GreatMission', , , UpdateState);
			//`GAMERULES.SubmitGameState(UpdateState);
			//return;
		//}
		//
		//if(BattleData.bToughMission)
		//{
			//UpdateState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("After Action Tough Mission Event");
			//`XEVENTMGR.TriggerEvent('AfterAction_ToughMission', , , UpdateState);
			//`GAMERULES.SubmitGameState(UpdateState);
			//return;
		//}
	//}
//
	//function StartCameraMove()
	//{
		//`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Default, 6.0f);
	//}
//}

//function RestoreCamera()
//{
	//`HQPRES.CAMLookAtNamedLocation(UIDisplayCam_Default, 6.0f);
//}

DefaultProperties
{
	Package   = "/ package/gfxSquadList/SquadList";

	InputState = eInputState_Consume;
	bHideOnLoseFocus = true;
	bAutoSelectFirstNavigable = false;
	
	m_strPawnLocationIdentifier = "Blueprint_AfterAction_Promote";
	m_strPawnLocationSlideawayIdentifier = "UIPawnLocation_SlideAway_";

	UIDisplayCam_WalkUpStart = "Cam_AfterAction_Start"; //Starting point for the slow truck downward that the after action report camera plays
	UIDisplayCam_Default = "Cam_AfterAction_End"; //Name of the point that the camera rests at in the after action report
	UIDisplayCam_Back ="Cam_AfterAction_Back"; //Name of the point that the camera rests at when viewing back row
	UIBlueprint_Prefix = "Blueprint_AfterAction_Promote" //Prefix for the name of the point used for editing soldiers in-place on the avenger deck
	UIBlueprint_Prefix_Wounded = "Blueprint_AfterAction_PromoteWounded"
	//CameraTransitionTime = 0.5f;

	//Refer to the points / camera setup in CIN_PostMission1 to understand this array
	SlotListOrder[0] = 4
	SlotListOrder[1] = 1
	SlotListOrder[2] = 0
	SlotListOrder[3] = 2
	SlotListOrder[4] = 3
	SlotListOrder[5] = 5

}

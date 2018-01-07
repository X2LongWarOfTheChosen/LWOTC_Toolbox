//---------------------------------------------------------------------------------------
//  FILE:    UIPersonnel_SoldierListItem_LW.uc
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: This is a replacement for SoldierListItem that allows displays stats, and provides hooks for tweaking things per-mod
//---------------------------------------------------------------------------------------
class UIPersonnel_SoldierListItem_LW extends UIPersonnel_SoldierListItem;

`include(LWOTC_Toolbox\Src\LW_Toolbox.uci)

var float IconXPos, IconYPos, IconXDelta, IconScale, IconToValueOffsetX, IconToValueOffsetY;
var float DisabledAlpha;
var int UIState;

var bool bIsFocussed;

//icons to be shown in the class area
var UIImage AimIcon, DefenseIcon;
var UIText AimValue, DefenseValue;

//icons to be shown in the name area
var UIImage HealthIcon, MobilityIcon, WillIcon, HackIcon, DodgeIcon; 
var UIText HealthValue, MobilityValue, WillValue, HackValue, DodgeValue;

//replacement for the soldier name so that it can be lined up to match the class name in font/position, and made horizontal autoscrolling
var UIScrollingText SoldierNameText; 

//replacement for the classname text so it can be shifted up to make room for icons
var UIScrollingText ClassNameText;

var string strUnitName, strClassName;

//delegate bool GetPersonnelStatus(XComGameState_Unit Unit, out string Status, out string TimeLabel, out string TimeValue, optional int MyFontSize = -1);

simulated function InitListItem(StateObjectReference initUnitRef)
{
	UIState = eUIState_Normal;
	super.InitListItem(initUnitRef);
	//PsiMarkup = Spawn(class'UIImage', self);
	//PsiMarkup.InitImage('PsiPromote', class'UIUtilities_Image'.const.PsiMarkupIcon);
	//PsiMarkup.Hide(); // starts off hidden until needed

}

simulated function UIButton SetDisabled(bool disabled, optional string TooltipText)
{
	super.SetDisabled(disabled, TooltipText);
	UIState = (IsDisabled ? eUIState_Disabled : eUIState_Normal);
	UpdateDisabled();
	UpdateItemsForFocus(false);
	return self;
}

simulated function UpdateData()
{
	local XComGameState_Unit Unit;
	local string UnitLoc, status, statusTimeLabel, statusTimeValue, classIcon, rankIcon, flagIcon;	
	local int iRank;
	local X2SoldierClassTemplate SoldierClass;
	
	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));

	// trigger now to add background elements
	`XEVENTMGR.TriggerEvent('OnSoldierListItemUpdate_Start', self, self);

	if(Unit.GetName(eNameType_Nick) == " ")
		strUnitName = CAPS(Unit.GetName(eNameType_First) @ Unit.GetName(eNameType_Last));
	else
		strUnitName = CAPS(Unit.GetName(eNameType_First) @ Unit.GetName(eNameType_Nick) @ Unit.GetName(eNameType_Last));

	iRank = Unit.GetRank();

	SoldierClass = Unit.GetSoldierClassTemplate();
	strClassName = Caps(SoldierClass != None ? SoldierClass.DisplayName : "");

	GetPersonnelStatusSeparateWrapper(Unit, status, statusTimeLabel, statusTimeValue);
	if( statusTimeValue == "" )
		statusTimeValue = "---";

	flagIcon = Unit.GetCountryTemplate().FlagImage;
	rankIcon = class'UIUtilities_Image'.static.GetRankIcon(iRank, SoldierClass.DataName);
	classIcon = SoldierClass.IconImage;

	// if personnel is not staffed, don't show location
	if( class'UIUtilities_Strategy'.static.DisplayLocation(Unit) )
		UnitLoc = class'UIUtilities_Strategy'.static.GetPersonnelLocation(Unit);
	else
		UnitLoc = "";

	AS_UpdateDataSoldier("  ", // leave blank
					"  ", // put name in top row to leave room for icons below
					Caps(`GET_RANK_ABBRV(Unit.GetRank(), SoldierClass.DataName)),
					rankIcon,
					"",
					classIcon,
					status,
					statusTimeValue $"\n" $ Class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(Class'UIUtilities_Text'.static.GetSizedText( statusTimeLabel, 12)),
					UnitLoc,
					flagIcon,
					IsDisabled,  
					Unit.ShowPromoteIcon(),
					false); // psi soldiers can't rank up via missions

	if(GetLanguage() == "JPN")
	{
		IconToValueOffsetY = -3.0;
	}

	AddClassColumnIcons(Unit);
	AddNameColumnIcons(Unit);

	if(SoldierNameText == none)
	{
		SoldierNameText = Spawn(class'UIScrollingText', self);
		SoldierNameText.bAnimateOnInit = false;
		SoldierNameText.InitScrollingText(,, 330, 174, 0);
	} 
	if(GetLanguage() == "JPN") SoldierNameText.SetY(-3);
	SoldierNameText.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(strUnitName, UIState));

	if(ClassNameText == none)
	{
		ClassNameText = Spawn(class'UIScrollingText', self);
		ClassNameText.bAnimateOnInit = false;
		ClassNameText.InitScrollingText(,, 120, 603, 0);
	} 
	if(GetLanguage() == "JPN") ClassNameText.SetY(-3);
	ClassNameText.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(strClassName, UIState));

	UpdateDisabled();

	// trigger now to allow overlaying icons/text/etc on top of other stuff
	`XEVENTMGR.TriggerEvent('OnSoldierListItemUpdate_End', self, self);

}

function AddNameColumnIcons(XComGameState_Unit Unit)
{
//var UIImage HealthIcon, MobilityIcon, WillIcon, HackIcon, DodgeIcon; 
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Dodge'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Hacking'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Health'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Mobility'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Strength'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Will'

	IconXPos = 174;

	if(HealthIcon == none)
	{
		HealthIcon = Spawn(class'UIImage', self);
		HealthIcon.bAnimateOnInit = false;
		HealthIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Health").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(HealthValue == none)
	{
		HealthValue = Spawn(class'UIText', self);
		HealthValue.bAnimateOnInit = false;
		HealthValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	
	}
	HealthValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_HP))), UIState));

	IconXPos += IconXDelta;

	if(MobilityIcon == none)
	{
		MobilityIcon = Spawn(class'UIImage', self);
		MobilityIcon.bAnimateOnInit = false;
		MobilityIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Mobility").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(MobilityValue == none)
	{
		MobilityValue = Spawn(class'UIText', self);
		MobilityValue.bAnimateOnInit = false;
		MobilityValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	}
	MobilityValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Mobility))), UIState));

	IconXPos += IconXDelta;

	if(WillIcon == none)
	{
		WillIcon = Spawn(class'UIImage', self);
		WillIcon.bAnimateOnInit = false;
		WillIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Will").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(WillValue == none)
	{
		WillValue = Spawn(class'UIText', self);
		WillValue.bAnimateOnInit = false;
		WillValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	}
	WillValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Will))), UIState));

	IconXPos += IconXDelta;

	if(HackIcon == none)
	{
		HackIcon = Spawn(class'UIImage', self);
		HackIcon.bAnimateOnInit = false;
		HackIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Hacking").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(HackValue == none)
	if(HackValue == none)
	{
		HackValue = Spawn(class'UIText', self);
		HackValue.bAnimateOnInit = false;
		HackValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	}
	HackValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Hacking))), UIState));

	IconXPos += IconXDelta;

	if(DodgeIcon == none)
	{
		DodgeIcon = Spawn(class'UIImage', self);
		DodgeIcon.bAnimateOnInit = false;
		DodgeIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Dodge").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(DodgeValue == none)
	{
		DodgeValue = Spawn(class'UIText', self);
		DodgeValue.bAnimateOnInit = false;
		DodgeValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	}
	DodgeValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Dodge))), UIState));

}

function AddClassColumnIcons(XComGameState_Unit Unit)
{
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Aim'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Defense'

	IconXPos = 600;

	if(AimIcon == none)
	{
		AimIcon = Spawn(class'UIImage', self);
		AimIcon.bAnimateOnInit = false;
		AimIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Aim").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(AimValue == none)
	{
		AimValue = Spawn(class'UIText', self);
		AimValue.bAnimateOnInit = false;
		AimValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	}
	AimValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Offense))), UIState));

	IconXPos += IconXDelta;

	if(DefenseIcon == none)
	{
		DefenseIcon = Spawn(class'UIImage', self);
		DefenseIcon.bAnimateOnInit = false;
		DefenseIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Defense").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(DefenseValue == none)
	{
		DefenseValue = Spawn(class'UIText', self);
		DefenseValue.bAnimateOnInit = false;
		DefenseValue.InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY);
	}
	DefenseValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Defense))), UIState));
}

simulated function UpdateItemsForFocus(bool Focussed)
{
//var UIText HealthValue, MobilityValue, WillValue, HackValue, DodgeValue;

	local XComGameState_Unit Unit;
	local bool bReverse;

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
	bIsFocussed = Focussed;
	bReverse = bIsFocussed && !IsDisabled;

	SoldierNameText.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(strUnitName, (bReverse ? -1 : UIState)));
	ClassNameText.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(strClassName, (bReverse ? -1 : UIState)));

	AimValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Offense))), (bReverse ? -1 : UIState)));
	DefenseValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Defense))), (bReverse ? -1 : UIState)));

	HealthValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_HP))), (bReverse ? -1 : UIState)));
	MobilityValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Mobility))), (bReverse ? -1 : UIState)));
	WillValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Will))), (bReverse ? -1 : UIState)));
	HackValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Hacking))), (bReverse ? -1 : UIState)));
	DodgeValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Dodge))), (bReverse ? -1 : UIState)));

	// trigger now to allow updating on when item is focussed (e.g. changing text color)
	`XEVENTMGR.TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);

}

simulated function UpdateDisabled()
{
	local float UpdateAlpha;

	UpdateAlpha = (IsDisabled ? DisabledAlpha : 1.0f);

	if(AimIcon == none)
		return;

	AimIcon.SetAlpha(UpdateAlpha);
	DefenseIcon.SetAlpha(UpdateAlpha);
	HealthIcon.SetAlpha(UpdateAlpha);
	MobilityIcon.SetAlpha(UpdateAlpha);
	WillIcon.SetAlpha(UpdateAlpha);
	HackIcon.SetAlpha(UpdateAlpha);
	DodgeIcon.SetAlpha(UpdateAlpha);

}

simulated function AS_UpdateDataSoldier(string UnitName,
								 string UnitNickname, 
								 string UnitRank, 
								 string UnitRankPath, 
								 string UnitClass, 
								 string UnitClassPath, 
								 string UnitStatus, 
								 string UnitStatusValue, 
								 string UnitLocation, 
								 string UnitCountryFlagPath,
								 bool bIsDisabled, 
								 bool bPromote, 
								 bool bPsiPromote)
{
	MC.BeginFunctionOp("UpdateData");
	MC.QueueString(UnitName);
	MC.QueueString(UnitNickname);
	MC.QueueString(UnitRank);
	MC.QueueString(UnitRankPath);
	MC.QueueString(UnitClass);
	MC.QueueString(UnitClassPath);
	MC.QueueString(UnitStatus);
	MC.QueueString(UnitStatusValue);
	MC.QueueString(UnitLocation);
	MC.QueueString(UnitCountryFlagPath);
	MC.QueueBoolean(bIsDisabled);
	MC.QueueBoolean(bPromote);
	MC.QueueBoolean(bPsiPromote);
	MC.EndOp();
}

simulated function OnMouseEvent(int Cmd, array<string> Args)
{
	switch(Cmd)
	{
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_IN:
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_OVER:
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_DRAG_OVER:
		UpdateItemsForFocus(true);
		break;
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_OUT:
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_DRAG_OUT:
		UpdateItemsForFocus(false);
		break;

	}

	Super(UIPanel).OnMouseEvent(Cmd, Args);
}

//intercepts the base game call to GetPersonnelStatusSeparate to handle replaced UISquadSelect and provide hooks for other mod custom update status
function GetPersonnelStatusSeparateWrapper(XComGameState_Unit Unit, out string Status, out string TimeLabel, out string TimeValue, optional int MyFontSize = -1)
{
	local EUIState eState; 
	local XComGameState_HeadquartersXCom HQState;
	//local XComGameState_LWToolboxOptions ToolboxOptions;
	//local delegate<GetPersonnelStatus> fnGetPersonnelStatus;
	local LWTuple PersonnelStrings;

	HQState = `XCOMHQ;

	if(Unit.IsMPCharacter())
	{
		Status = class'UIUtilities_Strategy'.default.m_strAvailableStatus;
		eState = eUIState_Good;
		Status = class'UIUtilities_Text'.static.GetColoredText(Status, eState, FontSize);
		return;
	}

	// soldiers get put into the hangar to indicate they are getting ready to go on a mission
	if(`HQPRES != none &&  `HQPRES.ScreenStack.IsInStack(class'UISquadSelect_LW') && HQState.IsUnitInSquad(Unit.GetReference()) )
	{
		Status = class'UIUtilities_Strategy'.default.m_strOnMissionStatus;
		eState = eUIState_Highlight;
		TimeLabel = class'UIUtilities_Text'.static.GetColoredText(TimeLabel, eUIState_Bad, MyFontSize);
		TimeValue = "";
		return;
	}

	//hook for mods to alter PersonnelStatus for soldiers -- these should fill out the class PersonnelReturnStatusFromEvent
	//ToolboxOptions = class'XComGameState_LWToolboxOptions'.static.GetToolboxOptions();
	//if (ToolboxOptions != none)
	//{
		//foreach ToolboxOptions.fnGetPersonnelStatusArray(fnGetPersonnelStatus)
		//{
			//if(fnGetPersonnelStatus != none)
			//{
				//if(fnGetPersonnelStatus(Unit, Status, TimeLabel, TimeValue, MyFontSize))
				//{
					//return;
				//}
			//}
		//}
	//}

	PersonnelStrings = new class'LWTuple';
	PersonnelStrings.Id = 'PersonnelStrings';
	`XEVENTMGR.TriggerEvent('OnSoldierListItem_GetPersonnelStatus', PersonnelStrings, self);
	if(PersonnelDataIsValid(PersonnelStrings))
	{
		Status = PersonnelStrings.Data[1].s;
		TimeLabel = PersonnelStrings.Data[2].s;
		TimeValue = PersonnelStrings.Data[3].s;
		return;
	}

	class'UIUtilities_Strategy'.static.GetPersonnelStatusSeparate(Unit, Status, TimeLabel, TimeValue, MyFontSize);
}

simulated function bool PersonnelDataIsValid(LWTuple PData)
{
	if(PData.Data.Length != 4) return false;
	if(PData.Data[0].kind != LWTVBool) return false;
	if(PData.Data[1].kind != LWTVString) return false;
	if(PData.Data[2].kind != LWTVString) return false;
	if(PData.Data[3].kind != LWTVString) return false;
	if(PData.Data[0].b == false) return false;
	return true;
}

defaultproperties
{
	IconToValueOffsetX = 26.0f;
	IconScale = 0.65f;
	IconYPos = 23.0f;
	IconXDelta = 65.0f;
	LibID = "SoldierListItem";
	DisabledAlpha = 0.5f;

	bAnimateOnInit = false;
}
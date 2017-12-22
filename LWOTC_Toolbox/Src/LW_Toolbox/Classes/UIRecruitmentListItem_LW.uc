//---------------------------------------------------------------------------------------
//  FILE:    UIRecruitmentListItem_LW.uc
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: This is a replacement for RecruitmentListItem that allows displays stats, and provides hooks for tweaking things per-mod
//---------------------------------------------------------------------------------------
class UIRecruitmentListItem_LW extends UIRecruitmentListItem;

`include(LW_Toolbox\Src\LW_Toolbox.uci)

//var localized string RecruitConfirmLabel; 

var UIScrollingText SoldierNameText;
var UIImage FlagImage;
var XComGameState_Unit CachedRecruit;

var UIImage AimIcon, DefenseIcon;
var UIText AimValue, DefenseValue;
var UIImage HealthIcon, MobilityIcon, WillIcon, HackIcon, DodgeIcon; 
var UIText HealthValue, MobilityValue, WillValue, HackValue, DodgeValue;

var float IconXPos, IconYPos, IconXDelta, IconScale, IconToValueOffsetX, IconToValueOffsetY;
var float DisabledAlpha;
var int UIState;

var string strSoldierNameHtmlSized;

var bool bIsFocussed;

simulated function InitRecruitItem(XComGameState_Unit Recruit)
{
	//local string ColoredName, strConfirm;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_HeadquartersResistance ResistanceHQ;

	InitPanel(); // must do this before adding children or setting data

	//HAX : Add Single click to list here so we don't have to override the screen
	List.OnItemClicked = UIRecruitSoldiers(Screen).OnRecruitSelected;

	CachedRecruit = Recruit;
	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	ResistanceHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();

	if(XComHQ.GetSupplies() < ResistanceHQ.GetRecruitSupplyCost())
		SetDisabled(true);

	UIState = (bDisabled ? eUIState_Disabled : eUIState_Normal);

	//ColoredName = class'UIUtilities_Text'.static.GetColoredText(Recruit.GetName(eNameType_Full), bDisabled ? eUIState_Disabled : eUIState_Normal);
	//AS_PopulateData(Recruit.GetCountryTemplate().FlagImage, ColoredName);

	strSoldierNameHtmlSized = class'UIUtilities_Text'.static.GetSizedText(Recruit.GetName(eNameType_Full), 22);

	SoldierNameText = Spawn(class'UIScrollingText', self);
	SoldierNameText.InitScrollingText(,, 240, 102, 4);
	SoldierNameText.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(strSoldierNameHtmlSized, UIState));
	if ( GetLanguage() == "JPN" )
		SoldierNameText.SetY(-1);

	FlagImage = Spawn(class'UIImage', self);
	FlagImage.InitImage(, Recruit.GetCountryTemplate().FlagImage).SetScale(0.6f).SetPosition(9, 9);

	//SetConfirmButtonStyle(eUIConfirmButtonStyle_Default, RecruitConfirmLabel, 0, 0);
	SetConfirmButtonStyle(eUIConfirmButtonStyle_None);

	if(GetLanguage() == "JPN")
	{
		IconToValueOffsetY = -3.0;
	}

	AddIcons(Recruit);

	// HAX: Undo the height override set by UIListItemString
	MC.ChildSetNum("theButton", "_height", 57);

	// trigger now to allow overriding disabled status, and to add background elements
	`XEVENTMGR.TriggerEvent('OnRecruitmentListItemInit', self, self);
}		

simulated function OnClickedConfirmButton(UIButton Button)
{
	local UIRecruitSoldiers RecruitScreen;
	RecruitScreen = UIRecruitSoldiers(Screen);
	RecruitScreen.OnRecruitSelected(RecruitScreen.List, RecruitScreen.List.GetItemIndex(self));
}

function AddIcons(XComGameState_Unit Unit)
{
//var UIImage HealthIcon, MobilityIcon, WillIcon, HackIcon, DodgeIcon; 
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Dodge'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Hacking'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Health'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Mobility'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Strength'
	//Texture2D'UILibrary_LWToolbox.StatIcons.Image_Will'

	IconXPos = 102;

	if(AimIcon == none)
	{
		AimIcon = Spawn(class'UIImage', self);
		AimIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Aim").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(AimValue == none)
		AimValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	AimValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Offense))), UIState));

	IconXPos += IconXDelta;

	if(DefenseIcon == none)
	{
		DefenseIcon = Spawn(class'UIImage', self);
		DefenseIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Defense").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(DefenseValue == none)
		DefenseValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	DefenseValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Defense))), UIState));

	IconXPos += IconXDelta;

	if(HealthIcon == none)
	{
		HealthIcon = Spawn(class'UIImage', self);
		HealthIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Health").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(HealthValue == none)
		HealthValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	HealthValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_HP))), UIState));

	IconXPos += IconXDelta;

	if(MobilityIcon == none)
	{
		MobilityIcon = Spawn(class'UIImage', self);
		MobilityIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Mobility").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(MobilityValue == none)
		MobilityValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	MobilityValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Mobility))), UIState));

	IconXPos += IconXDelta;

	if(WillIcon == none)
	{
		WillIcon = Spawn(class'UIImage', self);
		WillIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Will").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(WillValue == none)
		WillValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	WillValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Will))), UIState));

	IconXPos += IconXDelta;

	if(HackIcon == none)
	{
		HackIcon = Spawn(class'UIImage', self);
		HackIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Hacking").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(HackValue == none)
		HackValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	HackValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Hacking))), UIState));

	IconXPos += IconXDelta;

	if(DodgeIcon == none)
	{
		DodgeIcon = Spawn(class'UIImage', self);
		DodgeIcon.InitImage(, "UILibrary_LWToolbox.StatIcons.Image_Dodge").SetScale(IconScale).SetPosition(IconXPos, IconYPos);
	}
	if(DodgeValue == none)
		DodgeValue = UIText(Spawn(class'UIText', self).InitText().SetPosition(IconXPos + IconToValueOffsetX, IconYPos + IconToValueOffsetY));
	DodgeValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(Unit.GetCurrentStat(eStat_Dodge))), UIState));

}

simulated function UpdateItemsForFocus(bool Focussed)
{
	local bool bReverse;

	bIsFocussed = Focussed;
	bReverse = bIsFocussed && !bDisabled;
	SoldierNameText.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(strSoldierNameHtmlSized, (bReverse ? -1 : UIState)));
	AimValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_Offense))), (bReverse ? -1 : UIState)));
	DefenseValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_Defense))), (bReverse ? -1 : UIState)));

	HealthValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_HP))), (bReverse ? -1 : UIState)));
	MobilityValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_Mobility))), (bReverse ? -1 : UIState)));
	WillValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_Will))), (bReverse ? -1 : UIState)));
	HackValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_Hacking))), (bReverse ? -1 : UIState)));
	DodgeValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(string(int(CachedRecruit.GetCurrentStat(eStat_Dodge))), (bReverse ? -1 : UIState)));

	// trigger now to allow overriding disabled status, and to add background elements
	`XEVENTMGR.TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);
}

simulated function OnReceiveFocus()
{
	UpdateItemsForFocus(true);
	super.OnReceiveFocus();
}

simulated function OnLoseFocus()
{
	UpdateItemsForFocus(false);
	super.OnLoseFocus();
}

simulated function AS_PopulateData( string flagIcon, string recruitName )
{
	MC.BeginFunctionOp("populateData");
	MC.QueueString(flagIcon);
	MC.QueueString(recruitName);
	MC.EndOp();
}

defaultproperties
{
	width = 540;
	height = 57;
	LibID = "NewRecruitItem";

	IconToValueOffsetX = 26.0f;
	IconScale = 0.65f;
	IconYPos = 30.0f;
	IconXDelta = 65.0f;
	DisabledAlpha = 0.5f;
}
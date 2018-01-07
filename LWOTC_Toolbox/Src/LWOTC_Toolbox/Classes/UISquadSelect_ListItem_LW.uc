//---------------------------------------------------------------------------------------
//  FILE:    UISquadSelect_ListItem_LWExpandedSquadSize.uc
//  AUTHOR:  Amineri (Long War Studios)
//  PURPOSE: Adds capabilities to expand/contract SquadSelect list items to support displaying more items
//--------------------------------------------------------------------------------------- 

class UISquadSelect_ListItem_LW extends UISquadSelect_ListItem;

`include(LWOTC_Toolbox\Src\LW_Toolbox.uci)

var UIText SelectUnitText;
var UIText CurrentHealthText;

delegate AddSquadSelectListItemComponents(UISquadSelect_ListItem panel);

simulated function UIPanel InitPanel(optional name InitName, optional name InitLibID)
{
	super.InitPanel(InitName, InitLibID);

	SelectUnitText = Spawn(class'UIText', self).InitText();
	SelectUnitText.SetHtmlText(GetSelectUnitText(false));
	SelectUnitText.SetWidth(default.width);
	SelectUnitText.Hide();

	CurrentHealthText = Spawn(class'UIText', self);
	CurrentHealthText.bAnimateOnInit = false;
	CurrentHealthText.InitText();
	CurrentHealthText.SetY(285);
	CurrentHealthText.SetWidth(default.width-7);
	CurrentHealthText.Hide();

	return self;
}

simulated function UpdateHealthText(int CurrentHealth, int MaxHealth)
{
	local EUIState ColorState;
	local string HealthString;

	if(CurrentHealth < MaxHealth)
		ColorState = eUIState_Bad;
	else
		ColorState = eUIState_Normal;

	HealthString = class'UISoldierHeader'.default.m_strHealthLabel $ ": " $ CurrentHealth $ " / " $ MaxHealth;
	CurrentHealthText.SetHTMLText(class'UIUtilities_Text'.static.GetColoredText(HealthString, ColorState, 18, "RIGHT"));
}

simulated function UpdateData(optional int Index = -1, optional bool bDisableEdit, optional bool bDisableDismiss, optional bool bDisableLoadout, optional array<EInventorySlot> CannotEditSlotsList)
{
	local bool bCanPromote;
	local string ClassStr, NameStr;
	local int i, NumUtilitySlots, UtilityItemIndex, NumUnitUtilityItems;
	local float UtilityItemWidth, UtilityItemHeight;
	local UISquadSelect_UtilityItem UtilityItem;
	local array<XComGameState_Item> EquippedItems;
	local XComGameState_Unit Unit;
	local XComGameState_Item PrimaryWeapon, HeavyWeapon;
	local X2WeaponTemplate PrimaryWeaponTemplate, HeavyWeaponTemplate;
	local X2AbilityTemplate HeavyWeaponAbilityTemplate;
	local X2AbilityTemplateManager AbilityTemplateManager;
	//local XComGameState_LWToolboxOptions SquadSelectOptions;
	//local delegate <AddSquadSelectListItemComponents> fnAddSquadSelectListItemComponents;

	if(bDisabled)
		return;

	SlotIndex = Index != -1 ? Index : SlotIndex;

	bDisabledEdit = bDisableEdit;
	bDisabledDismiss = bDisableDismiss;
	bDisabledLoadout = bDisableLoadout;
	CannotEditSlots = CannotEditSlotsList;

	if( UtilitySlots == none )
	{
		UtilitySlots = Spawn(class'UIList', DynamicContainer).InitList(, 0, 138, 282, 70, true);
		UtilitySlots.bStickyHighlight = false;
		UtilitySlots.ItemPadding = 5;
	}

	if( AbilityIcons == none )
	{
		AbilityIcons = Spawn(class'UIPanel', DynamicContainer).InitPanel().SetPosition(4, 92);
		AbilityIcons.Hide(); // starts off hidden until needed
	}

	// -------------------------------------------------------------------------------------------------------------

	// empty slot
	if(GetUnitRef().ObjectID <= 0)
	{
		//AS_SetEmpty(m_strSelectUnit);
		AS_SetEmpty("");
		AS_SetUnitHealth(-1, -1);
		SelectUnitText.Show();
		CurrentHealthText.Hide();

		AbilityIcons.Remove();
		AbilityIcons = none;

		DynamicContainer.Hide();
	}
	else
	{
		Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(GetUnitRef().ObjectID));
		bCanPromote = (Unit.ShowPromoteIcon());

		SelectUnitText.Hide();
		UtilitySlots.Show();
		DynamicContainer.Show();
		//Backpack controlled separately by the heavy weapon info. 

		NumUtilitySlots = 2;
		if(Unit.HasGrenadePocket()) NumUtilitySlots++;
		if(Unit.HasAmmoPocket()) NumUtilitySlots++;
		
		UtilityItemWidth = (UtilitySlots.GetTotalWidth() - (UtilitySlots.ItemPadding * (NumUtilitySlots - 1))) / NumUtilitySlots;
		UtilityItemHeight = UtilitySlots.Height;

		if(UtilitySlots.ItemCount != NumUtilitySlots)
			UtilitySlots.ClearItems();

		for(i = 0; i < NumUtilitySlots; ++i)
		{
			if(i >= UtilitySlots.ItemCount)
			{
				UtilityItem = UISquadSelect_UtilityItem(UtilitySlots.CreateItem(class'UISquadSelect_UtilityItem').InitPanel());
				UtilityItem.SetSize(UtilityItemWidth, UtilityItemHeight);
				UtilityItem.CannotEditSlots = CannotEditSlotsList;
				UtilitySlots.OnItemSizeChanged(UtilityItem);
			}
		}

		NumUnitUtilityItems = Unit.GetCurrentStat(eStat_UtilityItems); // Check how many utility items this unit can use

		UtilityItemIndex = 0;

		UtilityItem = UISquadSelect_UtilityItem(UtilitySlots.GetItem(UtilityItemIndex++));
		if (NumUnitUtilityItems > 0)
		{
			EquippedItems = class'UIUtilities_Strategy'.static.GetEquippedItemsInSlot(Unit, eInvSlot_Utility);
			if (bDisableLoadout)
				UtilityItem.SetDisabled(EquippedItems.Length > 0 ? EquippedItems[0] : none, eInvSlot_Utility, 0, NumUtilitySlots);
			else
				UtilityItem.SetAvailable(EquippedItems.Length > 0 ? EquippedItems[0] : none, eInvSlot_Utility, 0, NumUtilitySlots);
		}
		else
			UtilityItem.SetLocked(m_strNoUtilitySlots); // If the unit has no utility slots allowed, lock the slot

		if(class'XComGameState_HeadquartersXCom'.static.GetObjectiveStatus('T0_M5_EquipMedikit') == eObjectiveState_InProgress)
		{
			// spawn the attention icon externally so it draws on top of the button and image 
			Spawn(class'UIPanel', UtilityItem).InitPanel('attentionIconMC', class'UIUtilities_Controls'.const.MC_AttentionIcon)
			.SetPosition(2, 4)
			.SetSize(70, 70); //the animated rings count as part of the size. 
		} else if(GetChildByName('attentionIconMC', false) != none) {
			GetChildByName('attentionIconMC').Remove();
		}

		UtilityItem = UISquadSelect_UtilityItem(UtilitySlots.GetItem(UtilityItemIndex++));
		if(Unit.HasExtraUtilitySlot())
		{
				if (bDisableLoadout)
				UtilityItem.SetDisabled(EquippedItems.Length > 1 ? EquippedItems[1] : none, eInvSlot_Utility, 1, NumUtilitySlots);
			else
				UtilityItem.SetAvailable(EquippedItems.Length > 1 ? EquippedItems[1] : none, eInvSlot_Utility, 1, NumUtilitySlots);
		}
		else
			UtilityItem.SetLocked(NumUnitUtilityItems > 0 ? m_strNeedsMediumArmor : m_strNoUtilitySlots);

		if(Unit.HasGrenadePocket())
		{
			UtilityItem = UISquadSelect_UtilityItem(UtilitySlots.GetItem(UtilityItemIndex++));
			EquippedItems = class'UIUtilities_Strategy'.static.GetEquippedItemsInSlot(Unit, eInvSlot_GrenadePocket); 
			if (bDisableLoadout)
				UtilityItem.SetDisabled(EquippedItems.Length > 0 ? EquippedItems[0] : none, eInvSlot_GrenadePocket, 0, NumUtilitySlots);
			else
				UtilityItem.SetAvailable(EquippedItems.Length > 0 ? EquippedItems[0] : none, eInvSlot_GrenadePocket, 0, NumUtilitySlots);
		}

		if(Unit.HasAmmoPocket())
		{
			UtilityItem = UISquadSelect_UtilityItem(UtilitySlots.GetItem(UtilityItemIndex++));
			EquippedItems = class'UIUtilities_Strategy'.static.GetEquippedItemsInSlot(Unit, eInvSlot_AmmoPocket);
			if (bDisableLoadout)
				UtilityItem.SetDisabled(EquippedItems.Length > 0 ? EquippedItems[0] : none, eInvSlot_AmmoPocket, 0, NumUtilitySlots);
			else
				UtilityItem.SetAvailable(EquippedItems.Length > 0 ? EquippedItems[0] : none, eInvSlot_AmmoPocket, 0, NumUtilitySlots);
		}
		
		// Don't show class label for rookies since their rank is shown which would result in a duplicate string
		if(Unit.GetRank() > 0)
			ClassStr = class'UIUtilities_Text'.static.GetColoredText(Caps(Unit.GetSoldierClassTemplate().DisplayName), eUIState_Faded, 17);
		else
			ClassStr = "";

		PrimaryWeapon = Unit.GetItemInSlot(eInvSlot_PrimaryWeapon);
		if(PrimaryWeapon != none)
		{
			PrimaryWeaponTemplate = X2WeaponTemplate(PrimaryWeapon.GetMyTemplate());
		}

		NameStr = Unit.GetName(eNameType_Last);
		if (NameStr == "") // If the unit has no last name, display their first name instead
		{
			NameStr = Unit.GetName(eNameType_First);
		}

		// TUTORIAL: Disable buttons if tutorial is enabled
		if(bDisableEdit)
			MC.FunctionVoid("disableEdit");
		if(bDisableDismiss)
			MC.FunctionVoid("disableDismiss");

		AS_SetFilled( class'UIUtilities_Text'.static.GetColoredText(Caps(class'X2ExperienceConfig'.static.GetRankName(Unit.GetRank(), Unit.GetSoldierClassTemplateName())), eUIState_Normal, 18),
					  class'UIUtilities_Text'.static.GetColoredText(Caps(NameStr), eUIState_Normal, 22),
					  class'UIUtilities_Text'.static.GetColoredText(Caps(Unit.GetName(eNameType_Nick)), eUIState_Header, 28),
					  Unit.GetSoldierClassTemplate().IconImage, class'UIUtilities_Image'.static.GetRankIcon(Unit.GetRank(), Unit.GetSoldierClassTemplateName()),
					  class'UIUtilities_Text'.static.GetColoredText(m_strEdit, bDisableEdit ? eUIState_Disabled : eUIState_Normal),
					  class'UIUtilities_Text'.static.GetColoredText(m_strDismiss, bDisableDismiss ? eUIState_Disabled : eUIState_Normal),
					  class'UIUtilities_Text'.static.GetColoredText(PrimaryWeaponTemplate.GetItemFriendlyName(PrimaryWeapon.ObjectID), bDisableLoadout ? eUIState_Disabled : eUIState_Normal),
					  class'UIUtilities_Text'.static.GetColoredText(class'UIArmory_loadout'.default.m_strInventoryLabels[eInvSlot_PrimaryWeapon], bDisableLoadout ? eUIState_Disabled : eUIState_Normal),
					  class'UIUtilities_Text'.static.GetColoredText(GetHeavyWeaponName(), bDisableLoadout ? eUIState_Disabled : eUIState_Normal),
					  class'UIUtilities_Text'.static.GetColoredText(GetHeavyWeaponDesc(), bDisableLoadout ? eUIState_Disabled : eUIState_Normal),
					  (bCanPromote ? m_strPromote : ""), Unit.IsPsiOperative() || (Unit.HasPsiGift() && Unit.GetRank() < 2), ClassStr);

		//AS_SetUnitHealth(class'UIUtilities_Strategy'.static.GetUnitCurrentHealth(Unit), class'UIUtilities_Strategy'.static.GetUnitMaxHealth(Unit));
		AS_SetUnitHealth(-1, -1);

		UpdateHealthText(class'UIUtilities_Strategy'.static.GetUnitCurrentHealth(Unit), class'UIUtilities_Strategy'.static.GetUnitMaxHealth(Unit));
		CurrentHealthText.Show();

		PsiMarkup.SetVisible(Unit.HasPsiGift());

		HeavyWeapon = Unit.GetItemInSlot(eInvSlot_HeavyWeapon);
		if(HeavyWeapon != none)
		{
			HeavyWeaponTemplate = X2WeaponTemplate(HeavyWeapon.GetMyTemplate());

			// Only show one icon for heavy weapon abilities
			if(HeavyWeaponTemplate.Abilities.Length > 0)
			{
				AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
				HeavyWeaponAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate(HeavyWeaponTemplate.Abilities[0]);
				if(HeavyWeaponAbilityTemplate != none)
					Spawn(class'UIIcon', AbilityIcons).InitIcon(, HeavyWeaponAbilityTemplate.IconImage, false);
			}

			AbilityIcons.Show();
			AS_HasHeavyWeapon(true);
		}
		else
		{
			AbilityIcons.Hide();
			AS_HasHeavyWeapon(false);
		}
	}

	//hook for mods to add extra things to the ItemList
	`XEVENTMGR.TriggerEvent('OnUpdateSquadSelect_ListItem', self, self);

}

simulated function string GetSelectUnitText(bool Focussed)
{
	local string HtmlString;

	if(Focussed)
		HtmlString = class'UIUtilities_Text'.static.GetColoredText(m_strSelectUnit, , 26, "CENTER");
	else
		HtmlString = class'UIUtilities_Text'.static.GetColoredText(m_strSelectUnit, eUIState_Normal, 26, "CENTER");
	HtmlString = class'UIUtilities_Text'.static.AddFontInfo(HtmlString, false, true); //, false, 26);
	return HtmlString;
}

simulated function OnClickedDismissButton()
{
	local UISquadSelect SquadScreen;
	local XComGameState_HeadquartersXCom XComHQ;

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	if(!XComHQ.IsObjectiveCompleted('T0_M3_WelcomeToHQ') || bDisabledDismiss)
	{
		class'UIUtilities_Sound'.static.PlayNegativeSound();
		return;
	}

	SquadScreen = UISquadSelect(screen);
	SquadScreen.m_iSelectedSlot = SlotIndex;
	ChangeSlot();
	UpdateData(); // passing no params clears the slot
}

simulated function OnClickedEditUnitButton()
{
	local UISquadSelect SquadScreen;
	local XComGameState_HeadquartersXCom XComHQ;

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	if(!XComHQ.IsObjectiveCompleted('T0_M3_WelcomeToHQ') || bDisabledEdit)
	{
		class'UIUtilities_Sound'.static.PlayNegativeSound();
		return;
	}

	SquadScreen = UISquadSelect(screen);
	SquadScreen.m_iSelectedSlot = SlotIndex;
	
	if( XComHQ.Squad[SquadScreen.m_iSelectedSlot].ObjectID > 0 )
	{
		SquadScreen.bDirty = true;
		SquadScreen.SnapCamera();
		//SquadScreen.SwitchCameraToEditSoldier(1.167);
		SetTimer(0.73, false, nameof(LaunchUIMainMenu));
		//SetTimer(1.167, false, nameof(ActivateSoldierUI));
		`HQPRES.UIArmory_MainMenu(XComHQ.Squad[SquadScreen.m_iSelectedSlot],, 'PreM_SwitchToSoldier', , 'PreM_CustomizeUI_Off', 'PreM_SwitchToLineup');
		//`HQPRES.UIArmory_MainMenu(XComHQ.Squad[SquadScreen.m_iSelectedSlot],, 'PreM_SwitchToSoldier', 'PreM_GoToLineup', 'PreM_CustomizeUI_Off', 'PreM_SwitchToLineup');
		//`HQPRES.UIArmory_MainMenu(XComHQ.Squad[SquadScreen.m_iSelectedSlot], 'PreM_CustomizeUI', 'PreM_SwitchToSoldier', 'PreM_GoToLineup', 'PreM_CustomizeUI_Off', 'PreM_SwitchToLineup');
		//`XCOMGRI.DoRemoteEvent('PreM_GoToSoldier');
	}
}

simulated function ActivateSoldierUI()
{
	`XCOMGRI.DoRemoteEvent('PreM_CustomizeUI');
}

simulated function LaunchUIMainMenu()
{
	`XCOMGRI.DoRemoteEvent('CIN_CharacterLighting_ON');
	//`XCOMGRI.DoRemoteEvent('PreM_CustomizeUI');
	`XCOMGRI.DoRemoteEvent('PreM_SwitchToSoldier');
}

simulated function ChangeSlot(optional StateObjectReference UnitRef)
{
	local UISquadSelect SquadScreen;
	SquadScreen = UISquadSelect(Screen);

	SquadScreen.ChangeSlot(UnitRef);

	//add a SignalOnReceiveFocus so that any UIScreenListeners on the parent screen can update based on soldier changes
	SquadScreen.SignalOnReceiveFocus();
}

simulated function OnMouseEvent(int Cmd, array<string> Args)
{
	local string CallbackTarget;

	Super(UIPanel).OnMouseEvent(Cmd, Args);

	if(bDisabled) return;

	switch(Cmd)
	{
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_IN:
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_OVER:
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_DRAG_OVER:
		SelectUnitText.SetHtmlText(GetSelectUnitText(true));
		break;
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_OUT:
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_DRAG_OUT:
		SelectUnitText.SetHtmlText(GetSelectUnitText(false));
		break;

	case class'UIUtilities_Input'.const.FXS_L_MOUSE_UP:
		SelectUnitText.SetHtmlText(GetSelectUnitText(false));

		CallbackTarget = Args[Args.Length - 2]; // -2 to account for bg within ButtonControls

		switch(CallbackTarget)
		{
		case "promoteButtonMC":         OnClickedPromote(); break;
		case "primaryWeaponButtonMC":   OnClickedPrimaryWeapon(); break;
		case "heavyWeaponButtonMC":     OnClickedHeavyWeapon(); break;
		case "dismissButtonMC":         OnClickedDismissButton(); break;
		case "selectUnitButtonMC": OnClickedSelectUnitButton(); break;
		case "editButtonMC":            OnClickedEditUnitButton(); break;
		case "bondIconMC":              OnClickBondIcon(none); break;
		}
		break;
	}
}
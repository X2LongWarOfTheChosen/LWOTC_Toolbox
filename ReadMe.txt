Long War Toolbox
By Long War Studios

This is a mod for XCOM2 that adds a number of gameplay options that players may select in the game's options menu during campaigns as well as a few quality-of-life improvements.

INSTRUCTIONS FOR INSTALLATION 
Steam Workshop: Subscribe to the mod in the Long War Studios workshop page.

Manual/Nexus: From the zip archive, place the folder LW_Toolbox and its contents into your version of the C:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods folder.

To play:
Check the LW_Toolbox mod in the launcher. 

The automatic changes this mod makes includes several options to the squad select UI. They are:

MAKE WEAPONS AVAILABLE: Unequips primary weapons from all soldiers not selected for the mission.

CLEAR SQUAD: Removes all soldiers from the squad.

AUTOFILL SQUAD: Automatically fills any empty squad slots with the highest-ranking available soldier.

In addition, the soldier list UI has been reworked to display soldier stats.

All additional options may be selected in the Toolbox tab in the Options menu (typically accessed by hitting the Escape key). After starting a campaign, open the escape menu, select EDIT OPTIONS; then select the LW TOOLBOX option. NOTE: These options will not be present in the shell, only in campaigns.

The options are:

SET CAMERA ROTATION (degrees): This allows the player to control the increment by which the camera rotates using the rotate buttons and any associated hotkeys.

SELECT DEFAULT SQUADSIZE: This allows the player to set the maximum number of soldiers who can be in a squad. Guerrilla Tactics School bonuses, once completed, will be added to this number. The UI and mission deployment code will will now support up to 12-soldier squads. NOTE: The mod does not balance around any increased squad sizes selected by the player.

DAMAGE ROULETTE: This allows the player to modify the randomness of all weapon damage (alien and XCOM) in the game by a common percentage. Off means the game will use baseline mechanics. The 25% setting means that damage with vary by +/- 25% of the weapon's base damage. This will override any weapon-specific ini settings.

NOT CREATED EQUALLY: This subjects all soldiers to a process that randomizes their initial stats (via a random series of configurable “trades” of stats). This takes effect immediately (even mid-mission). Turning it off reverts soldiers to base stats. The soldiers randomized stats are remembered, so successive turning on and off is not an exploit. This option may be used in the Avenger at any time, or during the first turn of a tactical mission, presuming no one has been wounded. (In addition to creating an easy exploit, toggling a soldier's stats in a mission could kill that solder if they are wounded and trade away some of their hit points.)

HIDDEN POTENTIAL: This randomizes stats when soldiers level-up. Note: Easter Egg special soldiers will not have randomized stats from leveling up.

RED FOG: This enables an option in which wounds affect the stats offense, mobility, hacking and will stats. The player selects who RED FOG affects – XCOM, aliens, both, or none. A few aliens (set in LW_Toolbox.ini) are immune to this, because it would render them ineffective.

USE LINEAR RED FOG PENALTIES (INSTEAD OF QUADRATIC): The default functionality of Red Fog applies penalties in a fashion that light wounds cause very small penalties, while heavy wounds cause much larger ones. A linear application means that the effect isn’t as pronounced – a light/moderate wound causes a greater penalty than the same wound in the quadratic formula.

ALLOW COMBAT AUTO-RESOLVE: This will activate a button in the squad select UI that lets the player automatically resolve a tactical combat with the currently selected squad instead of going on a mission.

---------------------------------------------
-----------------CREDITS---------------------
---------------------------------------------

Technical Lead: Rachel "Amineri" Norman
Programmer: Jonathan "tracktwo" Emmett
Design Lead: John Lumpkin

---------------------------------------------
----------------PERMISSIONS------------------
---------------------------------------------

Modders are free to incorporate any code or other assets from this mod in their own, provided credit is given to Long War Studios in the appropriate places in mod releases.

---------------------------------------------
---------------COMPATIBILITY-----------------
---------------------------------------------

Classes replaced by this mod (will not be generally compatible with other mods that replace the same classes):
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

Notes:
- XComTacticalInput
Used to implement player-selectable camera rotation angles.

- UIOptionsPCScreen
Used to implement in-game mod configuration opions. 
Other mods can utilize this interface by creating a class extends XComGameState_LWModOptions and invoking CreateModSettingsState to add it to the CampaignSettings.

- UISquadSelect
- UIAfterAction
Used to implement larger squad interfaces.
Have added the following hooks so that other mods that need to make changes can do so.
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // allows mods to remove soldiers that cannot be deployed on current mission
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	// allows mods to make any adjustments after Squad Select initialization
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  // allows mods to modify (remove or add) soldiers when SquadSelect is initting
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   // called from UISquadSelect_ListItem_LW in Update, allows mods to add things to individual list items

- X2TacticalGameRuleset
Used to expand deployable area for units beyond 3x3 tile grid allowed by base-game code.

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
Used to implement display of soldier stats when viewing/recruiting soldiers
Have added the following hooks so that other mods that need to make changes can do so.
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  // called from UIPersonnel_SoldierListItem_LW.Update, allows updating background elements
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  // called from UIPersonnel_SoldierListItem_LW.Update, allows layering UI elements over existing elements
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  // called from UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus, allowing altering items when list item is focussed or not
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // called from UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper, allowing overriding Personnel Status
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   // called from UIRecruitmentListItem_LW.InitRecruitItem, allowing additional elements to be modded in
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  // called from UIRecruitmentListItem_LW.UpdateItemsForFocus, allowing elements to be updated when item is focussed
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // called from UIPersonnel_SquadSelect.UpdateList, allows overriding Disabled status of a list item 

This mod makes changes to the X2StrategyElement_DefaultRewards templates 'Reward_Soldier', 'Reward_Rookie' and 'Reward_CouncilSoldier'.
The GenerateRewardFn delegate is overwritten in all three cases and so will not be compatible with another mod that makes similar changes.
The replacement functions add the following hooks that Toolbox and other mods can make use of:
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  // Allows intercepting newly created soldiers so that modifications can be made to them. Note this doesn't handle initial solders created at campaign start
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState );   // Allows intercepting each soldier rank-up when reward soldiers are generated. Use in conjuntion with 'PromotionEvent' and 'PsiTrainingCompleted' to catch all such events.

---------------------------------------------
------------ NOTES FOR MODDERS --------------
---------------------------------------------

Other mods can make use of the LW Toolbox override of UIOptionsPCScreen to define their own in-game configurable options. Each mod that registers will show up as an additional tab in the Options Menu. This is a scrollable list, if many mods configure options in this way.

Steps to hook up your mod to LW Toolbox :

1) Copy the XComGameState_LWModOptions.uc class file into your mod, in a separate folder under /Src/LW_XCGS_ModOptions/Classes/
2) Add config line "+ModEditPackages=LW_XCGS_ModOptions" (to match the new folder in Src) to XComEngine.ini, section [UnrealEd.EditorEngine]
3) Create an extension of XComGameState_LWModOptions to implement your own mod options, following the example laid out with XComGameState_LWToolboxOptions
4) In X2DownloadableContentInfo extension, add calls to CreateModSettingsState, following the example in X2DownloadableContentInfo_LWToolbox
5) When LW Toolbox mod is present, it will find the ModOptions gamestate and populate the mod options automatically

Notes on implementing XComGameState_LWModOptions extension:
The new Src folder (LW_XCGS_ModOptions) will result in a second LW_XCGS_ModOptions.u file being compiled into your mod's script folder. This is normal, and allows the ModOptions component and code to operate when LW Toolbox isn't present. A mod that implements the interface can be installed BEFORE LW Toolbox is installed, and the Options will work once Toolbox is installed.

-- InitComponent() :
 A spot to perform any initialization desired. Note this only happens when the gamestate is first created, and won't update with code/mod updates.

 -- GetTabText() : 
Provides the text to display in the UIOptionsPCScreen. Should generally at least be localized.

-- InitModOptions() : 
This method is run whenever UIOptionsPCScreen is created/initialized. Allows caching of current settings or anything else that needs to happen at that point.

-- SetModOptionsEnabled() : 
The primary interface between ModOptions and UIOptionsPCScreen. Passes an array of UIMechaItem to be filled out by the ModOptions, which UIOptionsPCScreen then displays.

-- HasAnyValueChanged() : 
Request to ModOptions if any options have changed. Used to display warning when leaving UIOptionsPCScreen without having saved option changes.

-- ApplyModSettings() : 
Called when user selects "Save and Exit," prompts ModOptions to apply any user-selected options previously selected.

-- RestorePreviousModSettings() : 
Called when user exits options without "Save and Exit." ModOptions should revert to the options state from when user entered UIOptionsPCScreen.

-- CanResetModSettings() : 
Query as to whether the mod defines a default mod setting. Used to place the "Reset Mod Options" button (or not). Default to false, so leaving this alone will remove the Reset feature from your options.

-- ResetModSettings() : 
Callback from "Reset Mod Options" button to reset the current mod tab to defaults. Should not save options -- that will be handled when user exits and selects "Save and Exit". Can only be called if CanResetModSettings() is overridden to return true.

--------------------------------------------------

OPTIONAL:

Toolbox makes use of a generic LW_Tuple data structure for passing data back and forth using the X2EventManager. If your mod wants to RegisterForEvent for one of these EventIDs, you'll want to include the LW_Tuple package :

1) Copy the LWTuple.uc class file into your mod, in a separate folder under /Src/LW_Tuple/Classes/
2) Add config line "+ModEditPackages=LW_Tuple" (to match the new folder in Src) to XComEngine.ini, section [UnrealEd.EditorEngine]
3) Use the LWTuple class in your code

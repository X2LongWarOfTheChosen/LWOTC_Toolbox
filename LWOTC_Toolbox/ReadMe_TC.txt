Long War工具箱
Long War Studios製作

這是讓玩家可在XCOM 2的戰役選單內中，加入了一些增加遊戲性的選項，以提升遊戲體驗。

安裝指示 
Steam工作坊：在Long War Studios工作坊頁面訂閱該模組。

手動/相關：解壓Zip檔案，將LW_Toolbox資料夾和其中的內容複製到你安裝路徑下，譬如C:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods。

遊玩：
在啟動器內啟用LW_Toolbox模組。 

該模組會自動在小隊選擇UI內自動加入一些選項，詳細如下：

使武器可用：卸下未選擇入該任務的所有士兵的主武器。

清空小隊：移除小隊的所有士兵。

自動填補小隊：自動將可選擇中最高等級的士兵填補小隊的空位。

另外，士兵清單的UI將顯示士兵的能力值了。

選項選單內的工具箱標籤中所有其他選項都會被選擇。在開始戰役後，打開暫停選單，選擇編輯選項；然後選擇LW工具箱選項。注意：這些選項不會在外部選單中出現，僅會出現在戰役中。

選項包含：

設置鏡頭旋轉（角度）：這會讓玩家可以使用旋轉按鈕和其他相關熱鍵自行控制調整鏡頭的旋轉。

選擇預設小隊規模：這個選項可以讓玩家設定一個小隊內的最大人數。遊擊戰術學院的加成一旦完成，也會加入到這些人數內。UI和任務部屬程式碼現在能支持最多12名的士兵小隊。注意：該模組不會根據玩家選擇的小隊規模進行平衡性調整。

傷害輪盤：這會讓玩家以一個隨機的百分比數字對所有武器傷害進行調整（包含外星人和XCOM成員）。關閉則會使用遊戲的基礎機制。25%的設置意味著傷害將會在+/-25%的武器基礎傷害範圍內進行波動。這會覆蓋所有關於武器的ini設定。

龍生九子：這會讓所有士兵的基礎能力值進行隨機設置（透過一系列的資料隨機配置）。此功能一開啟便會立即生效（即便在任務中）。關閉此選項士兵將會恢復其基礎數值。士兵的隨機能力值將會儲存，因此連續進行打開和關閉並不會使亂數產生變化。該選項可在復仇者號內，或僅在戰術任務的第一回合內，並且沒有人受傷時可啟用。（請注意，在任務中開啟該選項將可能會導致受傷的士兵被殺死或者使他們損失一定的生命值。）

隱藏潛力：在升級後士兵們會隨機提升能力值。注意：特殊彩蛋士兵不會在升級後隨機提升能力值。

紅色迷霧：這會使受傷影響進攻、移動、駭客和意志的能力值。玩家可選擇受紅色迷霧影響的對象——XCOM、外星人，兩者或都不受影響。一些外星人（在LW_Toolbox.ini中設置）會對此免疫，因為這會使它們失去戰鬥能力。

使用線性紅霧懲罰（而不是平方）：預設的紅霧功能中，輕傷會造成很小的懲罰，而重傷會造成巨大的懲罰。線性的懲罰意味著效果不會像之前的差別那麼明顯——輕傷/一般受傷會比在二次方程式下的受傷計算中，受到稍多一點的懲罰。

允許戰鬥自動處理：這會在小隊選擇UI下新增一個按鈕，可以讓玩家所選擇的現有小隊自動處理戰鬥過程，而不是前往任務。

---------------------------------------------
-------------------製作人員---------------------
---------------------------------------------

技術主管：Rachel "Amineri" Norman
程式員：Jonathan "tracktwo" Emmett
設計主管：John Lumpkin

---------------------------------------------
--------------------權限----------------------
---------------------------------------------

模組製作者可以自由地將該模組中的任何程式碼或組件運用到他們自己的模組中，只要在模組發布的適當區域內註明Long War Studios的製作人員。

---------------------------------------------
--------------------相容性---------------------
---------------------------------------------

被該模組替換的組別（一般和其他替換相同組別的模組不相容）：
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

注意：
- XComTacticalInput
用於使用玩家自選的鏡頭旋轉角度。

- UIOptionsPCScreen
用於使用遊戲內模組的配置選項。 
其他模組可以透過創建一個組別擴展XComGameState_LWModOptions然後調用CreateModSettingsState將該功能加入CampaignSettings。

- UISquadSelect
- UIAfterAction
用於使用更大的小隊介面。
已加入了以下外掛代碼，讓其他模組可以進行更改。
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); //允許模組移除目前任務無法部署的士兵。
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	//允許模組在小隊選擇初始化後進行任何調整。
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  //當SquadSelect在初始化時允許模組調整（移除或增加）士兵。
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   //調用UISquadSelect_ListItem_LW，允許模組對個人列表物品中添加項目。

- X2TacticalGameRuleset
用於擴展部署區域，使其在遊戲原始程式碼允許下擴展3X3的區域。

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
用於在查看/招募士兵是可顯示士兵能力值。
已加入了以下外掛代碼，以讓其他模組可以進行更改。
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  //調用UIPersonnel_SoldierListItem_LW.Update，允許更新背景元素。
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  //調用UIPersonnel_SoldierListItem_LW.Update，允許將UI元素置於現有元素上層。
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  //調用UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus，允許在列表物品被選定時調整物品。
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); //調用UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper，允許覆蓋個人能力值。
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   //調用UIRecruitmentListItem_LW.InitRecruitItem，允許模組添加額外元素。
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  //調用UIRecruitmentListItem_LW.UpdateItemsForFocus，允許在物品被選定時更新元素。
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); //調用UIPersonnel_SquadSelect.UpdateList，允許覆蓋物品的禁用狀態。

該模組會對X2StrategyElement_DefaultRewards範本，'Reward_Soldier'，'Reward_Rookie'和'Reward_CouncilSoldier'進行更改。
GenerateRewardFn在所有三個案例中被覆蓋，因此不會相容其他對此進行類似更改的模組。
替代功能已加入如下外掛代碼、工具箱和其他模組皆可利用：
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  //允許介入新創建的士兵，可以對他們進行修改。注意這無法處理戰役開始時創建的初始士兵。
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState );   //當獎勵的士兵生成時，允許介入每個士兵的升級過程。連同'PromotionEvent'和'PsiTrainingCompleted'可以一同抓取所有事件。

---------------------------------------------
----------------- 模組製作者注意 -----------------
---------------------------------------------

其他模組可以利用LW Toolbox，覆蓋UIOptionsPCScreen來定義他們自己的遊戲內配置選項。對其作出的改變都會在選項選單中以新標籤的形式出現。這是一個可滾動的列表，就和許多模組配置選項的方式類似。

以下是將你的模組掛在到LW工具箱的步驟：

1) 將XComGameState_LWModOptions.uc的class檔案複製到你的模組內，放在單獨的資料夾/Src/LW_XCGS_ModOptions/Classes/之中。
2) 在XComEngine.ini，[UnrealEd.EditorEngine]區域內加入配置文本"+ModEditPackages=LW_XCGS_ModOptions"。（用於和在Src下的新資料夾做配對）
3) 創建一個XComGameState_LWModOptions的擴充以添加你自己的模組選項，遵照XComGameState_LWToolboxOptions的範例。
4) 在X2DownloadableContentInfo下，加入CreateModSettingsState的調用，遵照X2DownloadableContentInfo_LWToolbox內的範例。
5) 當LW工具箱模組運行後，它就會找到ModOptions gamestate並自動展示模組選項。

添加XComGameState_LWModOptions擴充的注意點：
新的Src目錄(LW_XCGS_ModOptions)將會花費一點時間將LW_XCGS_ModOptions.u檔案整合入你的模組腳本目錄。這是正常的，並且能允許ModOptions內容和程式碼能在LW工具箱不存在的時候運行。添加了這個介面的模組可以在LW工具箱安裝前運行，並且在工具箱安裝後選項將會立刻啟用。

-- InitComponent() :
 可進行任何初始化。注意這只會在gamestate首次創建時發生，並且不會隨著程式碼/模組更新一同更新。

-- GetTabText() : 
提供在UIOptionsPCScreen中顯示的文本。一般應該進行當地語系化。

-- InitModOptions() : 
無論何時UIOptionsPCScreen被創建/初始化時，該步驟會被運行。允許對當前的設定進行快取或進行任何當前需要的動作。

-- SetModOptionsEnabled() : 
這是ModOptions和UIOptionsPCScreen之間的初始化介面。傳遞由ModOptions填寫的UIMechaItem數列，然後UIOptionsPCScreen將其顯示。

-- HasAnyValueChanged() : 
向ModOptions進行請求，如果有任何選項發生改變。當離開UIOptionsPCScreen時沒有進行儲存選項改變時，用作警告的顯示。

-- ApplyModSettings() : 
當使用者選擇「儲存並退出」時調用，讓ModOptions應用任何使用者之前選擇的選項更改。

-- RestorePreviousModSettings() : 
當使用者在沒有「儲存並退出」而退出選項時調用。ModOptions應當恢復至使用者進入UIOptionsPCScreen時的選項狀態。

-- CanResetModSettings() : 
詢問是否模組定義了一個預設的模組設定。用來防止「重置目前模組」按鈕（或沒有）。預設是false，因此不管它則會在你的選項中移除重置功能。

-- ResetModSettings() : 
相應「重置目前模組」按鈕以重置目前模組標籤到預設選項不應當儲存選項 -- 那應當是在使用者退出並選擇「儲存並退出」時發生。僅能在CanResetModSettings()被覆蓋並設定為true的時候被調用。

--------------------------------------------------

可選：

工具箱使用的是利用X2EventManager的一般LW_Tuple資料結構來傳輸資料。如果你的模組想要為其中一個EventIDs進行RegisterForEvent，你需要包含LW_Tuple包：

1) 將LWTuple.uc的class檔案複製到你的模組內，放在單獨的資料夾/Src/LW_Tuple/Classes/之中。
2) 在XComEngine.ini，[UnrealEd.EditorEngine]區域內加入配置文本"+ModEditPackages=LW_Tuple"。（用於和在Src下的新資料夾做配對）
3) 在你的程式碼中使用LWTuple class。

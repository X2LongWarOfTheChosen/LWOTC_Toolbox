Long War工具箱
Long War Studios制作

这是为XCOM 2加入了一些玩家可在游戏内战役的选项菜单内选择的游戏性选项，同时也提升了一定的游戏体验。

安装指示 
Steam创意工坊：在Long War Studios创意工坊页面订阅该模组。

手动/相关：解压Zip档案，将LW_Toolbox文件夹和其中的内容复制到你安装路径下，比如C:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods。

游玩：
在启动器内启用LW_Toolbox模组。 

该模组会自动在小队选择UI内自动加入一些选项，详细如下：

使武器可用：解除未选择入该任务的所有士兵的主武器。

清空小队：移除小队的所有士兵。

自动填补小队：自动用可用的最高等级士兵填补小队的空槽。

另外，士兵列表的UI将显示士兵的数值了。

选项菜单内的工具箱标签的所有其他选项都会被选择。在开始战役后，打开暂停菜单，选择编辑选项；然后选择LW工具箱选项。注意：这些选项不会在外部菜单中出现，仅会在战役中出现。

选项包含：

设置镜头旋转（角度）：这会让玩家可以使用旋转按钮和其他相关热键自行控制调整镜头的旋转。

选择默认小队规模：这会让玩家可以设定一个小队内的最大人数。游击战术学校的奖励一旦完成，也会加入到这些人数内。UI和任务部署代码现在能支持最多12名士兵的小队了。注意：该模组不会根据玩家选择的小队规模进行平衡性调整。

伤害轮盘：这会让玩家可以用一个百分比数对所有武器伤害进行随机性调整（外星人和XCOM）。关闭意味着游戏会使用基础的机制。25%的设置意味着伤害将会在+/-25%的武器基础伤害的范围内进行波动。这会覆盖任何关于武器的ini设置。

龙生九子：这会让所有士兵对其基础数值进行随机（通过一系列的数据随机配置）。这会立刻生效（即便在任务中）。关闭此选项士兵将会恢复其基础数值。士兵随机的数值将会保存，因此连续进行打开和关闭不会使随机数变化。该选项可在复仇者号内，或仅在战术任务的第一回合内启用，并且仅限在没有人受伤时可用。（请注意，在任务中开启该选项将可能会导致受伤的士兵被杀死或者使他们损失一定的生命值。）

隐藏潜力：在升级后士兵们会随机提升数值。注意：特殊彩蛋士兵不会在升级后随机提升数值。

红色迷雾：这会使受伤影响进攻，移动，黑客和意志数值。玩家可选择受红色迷雾影响的对象——XCOM，外星人，两者或都不受影响。一些外星人（在LW_Toolbox.ini中设置）会对此免疫，因为这会使它们失去战斗能力。

使用线性红雾惩罚（而不是平方）：默认的红雾功能中，轻伤会造成很小的惩罚，而重伤会造成更加巨大的惩罚。线性的惩罚意味着效果不会如之前那么区分明显——轻伤/一般的受伤会比在二次方程式下的受伤计算下，受到惩罚更为严重一些。

允许战斗自动处理：这会在小队选择UI下新增一个按钮，可以让玩家用现有选择的小队自动处理战斗过程，而不是前往任务。

---------------------------------------------
-------------------制作人员---------------------
---------------------------------------------

技术主管：Rachel "Amineri" Norman
程序员：Jonathan "tracktwo" Emmett
设计主管：John Lumpkin

---------------------------------------------
--------------------权限----------------------
---------------------------------------------

模组制作者可以自由地将该模组中的任何代码或组件运用到他们自己的模组中去，只要在模组发布的适当区域内注明Long War Studios的制作人员。

---------------------------------------------
--------------------兼容性---------------------
---------------------------------------------

被该模组替换的组别（一般和其他替换相同组别的模组不兼容）：
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
用于使用玩家自选的镜头旋转角度。

- UIOptionsPCScreen
用于使用游戏内模组配置选项。 
其他模组可以通过创建一个组别扩展XComGameState_LWModOptions然后调用CreateModSettingsState将该功能加入CampaignSettings。

- UISquadSelect
- UIAfterAction
用于使用更大的小队界面。
已加入了以下外挂代码，以让其他模组可以进行更改。
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); //允许模组移除目前任务无法部署的士兵。
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	//允许模组在小队选择初始化后进行任何调整。
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  //当SquadSelect在初始化时允许模组调整（移除或增加）士兵。
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   //调用UISquadSelect_ListItem_LW，允许模组对个人列表物品中添加项目。

- X2TacticalGameRuleset
用于扩展部署区域，使其在游戏源代码允许下扩展3X3的区域。

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
用于在查看/招募士兵是可显示士兵数值。
已加入了以下外挂代码，以让其他模组可以进行更改。
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  //调用UIPersonnel_SoldierListItem_LW.Update，允许更新背景元素。
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  //调用UIPersonnel_SoldierListItem_LW.Update，允许将UI元素置于现有元素上层。
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  //调用UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus，允许在列表物品选定时调整物品。
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); //调用UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper，允许覆盖个人数值。
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   //调用UIRecruitmentListItem_LW.InitRecruitItem，允许模组添加额外元素。
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  //调用UIRecruitmentListItem_LW.UpdateItemsForFocus，允许在物品选定使更新元素。
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); //调用UIPersonnel_SquadSelect.UpdateList，允许覆盖物品的禁用状态。 

该模组会对X2StrategyElement_DefaultRewards模板，'Reward_Soldier'，'Reward_Rookie'和'Reward_CouncilSoldier'进行更改。
GenerateRewardFn在所有三个案例中被覆盖，因此不会兼容其他对此进行类似更改的模组。
替代功能已加入如下外挂代码，工具箱和其他模组皆可利用：
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  //允许介入新创建的士兵，以可以对他们进行修改。注意这无法处理战役开始时创建的初始士兵
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState );   //当奖励士兵生成时，允许介入每个士兵的升级进程。连同'PromotionEvent'和'PsiTrainingCompleted'可以一同抓取所有事件。

---------------------------------------------
----------------- 模组制作者注意 -----------------
---------------------------------------------

其他模组可以利用LW Toolbox，覆盖UIOptionsPCScreen来定义他们自己的游戏内配置选项。对其作出的改变都会在选项菜单中以新标签的形式出现。这是一个可滚动的列表，就和许多模组配置选项的方式类似。

以下是将你的模组挂载到LW工具箱的步骤：

1) 将XComGameState_LWModOptions.uc class文件复制到你的模组内，放在单独的文件夹/Src/LW_XCGS_ModOptions/Classes/下。
2) 在XComEngine.ini，[UnrealEd.EditorEngine]区域内加入配置文本"+ModEditPackages=LW_XCGS_ModOptions"。（用于和在Src下的新文件夹配对）
3) 创建一个XComGameState_LWModOptions的扩展以添加你自己的模组选项，遵照XComGameState_LWToolboxOptions的样本。
4) 在X2DownloadableContentInfo下，加入CreateModSettingsState的调用，遵照X2DownloadableContentInfo_LWToolbox内的样本。
5) 当LW工具箱模组运行后，它就会找到ModOptions gamestate并自动展示模组选项。

添加XComGameState_LWModOptions扩展的注意点：
新的Src目录(LW_XCGS_ModOptions)将会花费一点时间将LW_XCGS_ModOptions.u文件整合入你的模组脚本目录。这是正常的，并能允许ModOptions内容和代码能在LW工具箱不存在的时候运行。添加了这个界面的模组可以在LW工具箱安装前运行，并且在工具箱安装后选项将会立刻工作。

-- InitComponent() :
 可进行任何初始化。注意这只会在gamestate首次创建时发生，并且不会随着代码/模组更新一同更新。

-- GetTabText() : 
提供在UIOptionsPCScreen中显示的文本。一般应当进行本地化。

-- InitModOptions() : 
无论何时UIOptionsPCScreen被创建/初始化时，该步骤会被运行。允许进行当前设定的缓存或任何当前需要进行的活动。

-- SetModOptionsEnabled() : 
这是ModOptions和UIOptionsPCScreen之间的初始化界面。传递由ModOptions填写的UIMechaItem数列，然后UIOptionsPCScreen将其显示。

-- HasAnyValueChanged() : 
向ModOptions进行请求，如果有任何选项发生改变。当离开UIOptionsPCScreen时没有进行保存选项改变时，用作警告的显示。

-- ApplyModSettings() : 
当用户选择“保存并退出”时调用，让ModOptions应用任何用户之前选择的选项更改。

-- RestorePreviousModSettings() : 
当用户在没有“保存并退出”而退出选项时调用。ModOptions应当恢复至用户进入UIOptionsPCScreen时的选项状态。

-- CanResetModSettings() : 
询问是否模组定义了一个默认的模组设定。用来防止“重置目前模组”按钮（或没有）。默认是false，因此不管它则会在你的选项中移除重置功能。

-- ResetModSettings() : 
相应“重置目前模组”按钮以重置目前模组标签到默认选项不应当保存选项 -- 那应当是在用户退出并选择“保存并退出”时发生。仅能在CanResetModSettings()被覆盖并设定为true的时候被调用。

--------------------------------------------------

可选：

工具箱使用的是利用X2EventManager的一般LW_Tuple数据结构来传输数据。如果你的模组想要为其中一个EventIDs进行RegisterForEvent，你需要包括入LW_Tuple包：

1) 将LWTuple.uc class文件复制到你的模组内，放在单独的文件夹/Src/LW_Tuple/Classes/下。
2) 在XComEngine.ini，[UnrealEd.EditorEngine]区域内加入配置文本"+ModEditPackages=LW_Tuple"。（用于和在Src下的新文件夹配对）
3) 在你的代码中使用LWTuple class。

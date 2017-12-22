Long Warツールボックス
著作：Long War Studios

XCOM2用の本MODには、キャンペーン中にゲーム内オプションメニューにて選択可能な多数の追加ゲームプレイオプションの他に、快適性に関するいくつかの改善も含まれます。

インストール説明
Steam ワークショップ：Long War StudiosのワークショップページでMODを購入してください。

マニュアル/ネクサス：ZIP書庫内から、LW_Toolboxフォルダおよびその中身をご使用中のC:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Modsフォルダに移してください。

プレイするには：
ランチャー内のLW_Toolbox modをチェックしてください。

本MODにて自動変更される事項には、部隊選択UIにおける以下のオプションも含まれます：

武器を使用可能にする：ミッションに選択されていない兵士のメイン武器を装備から外します。

部隊クリア：部隊から全兵士を外します。

部隊自動編成：部隊の空きスロットに利用可能な最高ランクの兵士を自動配置します。

さらに、兵士リストUIが改訂され、兵士の能力値が表示されるようになりました。

追加オプションはすべて「オプション」メニューのツールボックスタブから選択可能です（通常、Escキーを押すことでアクセスできます）。キャンペーン開始後、Escメニューを開いて「オプションを編集」を選んでから、「LW TOOLBOX」オプションを選択してください。注意：これらのオプションはキャンペーン内にのみ表示され、シェルには表示されません。

対象となるオプション：

カメラ回転設定（角度）：回転ボタンおよび関連づけられたホットキーを用いて、カメラが回転する角度を調節することができます。

デフォルト部隊サイズ選択：1部隊に割り当て可能な兵士の最大数を設定することができます。ゲリラ戦訓練施設ボーナスを取得後は、この数字に加算されます。UIとミッションの配置用コードが最大12人の部隊まで対応できるようになります。注意：このMODはプレイヤーの選択によって増加した部隊サイズに合わせてバランスを調整するものではありません。

ダメージ・ルーレット：ゲーム内のすべての武器（エイリアンおよびXCOM）のダメージ乱数を共通のパーセンテージで調節することができます。「オフ」にするとベースラインメカニクスを使用します。25%に設定すると、武器の基礎ダメージの+/- 25%の範囲でダメージが変化します。また、武器に固有のini設定はすべて上書きされます。

能力格差：すべての兵士を対象として、（ランダム選択された一連の設定可能な能力値のトレードによって）初期能力値がランダム化されます。効果は（ミッション中であっても）即座に現われます。オプションを無効化すれば、兵士は基礎能力値に戻ります。兵士のランダム化された能力値は記憶されるため、連続で有効化/無効化しても不当な使用とはなりません。本オプションはアヴェンジャー内ならいつでも使用できます。また、負傷者がいない場合に限り、戦闘ミッションの最初のターン中にも使用可能です。（ミッション中に兵士の能力値を変更できると、簡単に有利な状況を作れるだけでなく、兵士が負傷しており、さらにトレードによってHPを失うと、死亡してしまうことがあり得るため。）

潜在能力解放：兵士のレベルアップ時の能力値上昇をランダム化します。注意：隠し要素のスペシャル兵士はレベルアップ時にランダム化を受けません。

赤い霧：負傷によって攻撃力、機動力、ハッキング、および意志力の能力値に影響を及ぼすオプションを有効化します。赤い霧が影響を及ぼす対象は、XCOM、エイリアン、またはその両方を任意に選択できます。少数のエイリアン（LW_Toolbox.iniで設定）は無力化してしまうため、この設定の影響を受けません。

赤い霧の2次曲線的ペナルティではなく直線的ペナルティの使用：デフォルト設定では、赤い霧によるペナルティは軽傷ではごくわずかですが、重傷では非常に大きくなります。一方、直線的ペナルティを適用した場合、効果はそれほど顕著になりません。ただし、軽傷/中程度の負傷では、2次曲線的ペナルティを適用した場合よりむしろ大きなペナルティが科せられます。

戦闘の自動解決を許可：部隊選択UI内に、ミッションに出撃することなしに、現在選択中の部隊で戦術戦闘を自動的に解決するボタンが有効化されます。

---------------------------------------------
-------------------クレジット---------------------
---------------------------------------------

テクニカルリード：Rachel "Amineri" Norman
プログラマー：Jonathan "tracktwo" Emmett
デザインリード：John Lumpkin

---------------------------------------------
-------------------使用許可---------------------
---------------------------------------------

MOD製作者は、各自が発表するMODの適切な場所にLong War Studiosをクレジット表記する場合に限り、本MODのコードまたはその他資産を自由に活用することが許可されます。

---------------------------------------------
--------------------互換性---------------------
---------------------------------------------

本MODにて置き換えられたクラス（同じクラスを置き換えるMODとは一般的に互換性がありません）：
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
プレイヤーが選択可能なカメラ回転角の実装に使用。

- UIOptionsPCScreen
ゲーム内MOD設定オプションの実装に使用。
XComGameState_LWModOptionsを拡張するクラスを作成し、CreateModSettingsStateを呼び出してCampaignSettingsに追加することにより、他のMODでもこのインターフェースを利用できます。

- UISquadSelect
- UIAfterAction
拡大部隊インターフェースの実装に使用。
変更が必要なMODに変更を加えられるように、以下のフックを追加しました。
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // MODにて、現在のミッションに派遣できない兵士を外せるようになります
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self); // MODにて、部隊選択の初期化後にあらゆる調整を行えるようになります
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  // MODにて、部隊選択の初期化時に兵士を修正（除去または追加）できるようになります
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   // アップデート内のUISquadSelect_ListItem_LWから呼び出し。MODにて、個々のリストアイテムに追加を行えるようになります

- X2TacticalGameRuleset
基本ゲームコードにて許可される3x3タイルグリッドを超えてユニットを配置可能なエリアを拡大するのに使用。

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
兵士の閲覧/採用の際に兵士の能力値表示を実装するのに使用。
変更が必要なMODに変更を加えられるように、以下のフックを追加しました。
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  // UIPersonnel_SoldierListItem_LW.Updateから呼び出し。バックグラウンド要素のアップデートを可能にします。
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  // UIPersonnel_SoldierListItem_LW.Updateから呼び出し。既存のUI要素上にレイヤー要素を表示可能にします
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  // UIPersonnel_SoldierListItem_LW.UpdateItemsForFocusから呼び出し。リストアイテムのフォーカスの有無に応じて、アイテムの変更を可能にします
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapperから呼び出し。要員ステータスの上書きを可能にします
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   // UIRecruitmentListItem_LW.UpdateItemsForFocusから呼び出し。追加要素へのMODの適用を可能にします
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  // UIRecruitmentListItem_LW.UpdateItemsForFocusから呼び出し。アイテムのフォーカス時に要素のアップデートを可能にします
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // UIPersonnel_SquadSelect.UpdateListから呼び出し。リストアイテムの無効ステータスの上書きを可能にします

本MODはX2StrategyElement_DefaultRewardsテンプレートの「Reward_Soldier」、「Reward_Rookie」および「Reward_CouncilSoldier」に変更を加えます。
GenerateRewardFnデリゲートは3つのケースすべてにおいて上書きされるため、類似する変更を行う他のMODとは互換性がありません。
置き換え機能では、ツールボックスおよびその他のMODが利用可能な以下のフックが追加されます。
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  // 新規作成した兵士をインターセプトして修正を加えることが可能となります。注意：キャンペーン開始時に作成された初期兵士は対象となりません
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState );   // 報酬の兵士が作成される際に、各兵士のランクアップのインターセプトが可能となります。同種のイベントをすべてインターセプトするためには、「PromotionEvent」および「PsiTrainingCompleted」と併用してください。

---------------------------------------------
-------------- MOD製作者の方へ注記事項 --------------
---------------------------------------------

その他のMODは、Long WarツールボックスのUIOptionsPCScreen上書きを活用して、MOD独自のゲーム内設定可能オプションを規定できます。登録されたMODは、オプションメニュー内に追加タブとして表示されます。多数のMODにてオプションが構成される場合、このリストはスクロール可能となります。

Long WarツールボックスにMODを紐付けする手順：

1) XComGameState_LWModOptions.ucクラスファイルを、MODの/Src/LW_XCGS_ModOptions/Classes/内の別個のフォルダにコピーしてください
2) XComEngine.iniのセクション[UnrealEd.EditorEngine]に「+ModEditPackages=LW_XCGS_ModOptions」と（Src内の新規フォルダに合わせるため）追記してください
3) XComGameState_LWModOptionsを拡張して、XComGameState_LWToolboxOptionsに記述された例に従い、MODのオプションを実装してください
4) X2DownloadableContentInfoを拡張して、X2DownloadableContentInfo_LWToolboxの例に従い、CreateModSettingsStateにコールを追加してください
5) Long WarツールボックスのMODが存在する場合、ModOptionsのゲームステートが検出され、MODオプションが自動的に反映されます

XComGameState_LWModOptionsを拡張する際の注記：
新たなSrcフォルダ（LW_XCGS_ModOptions）によって、第2のLW_XCGS_ModOptions.uファイルがお使いのMODのスクリプトフォルダにコンパイルされます。これは正常な現象であり、Long Warツールボックスが存在しない場合にModOptionsのコンポーネントおよびコードを動作可能とするものです。インターフェースを実装するMODをLong Warツールボックスのインストール以前にインストール可能となり、ツールボックスをインストールすればオプションが機能するようになります。

-- InitComponent() :
あらゆる初期化を実行します。注意：ゲームステートが最初に作成された際にのみ実行されます。コード/MODのアップデートでは更新されません。

-- GetTabText() : 
UIOptionsPCScreenに表示するテキストを提供します。たいていの場合、最低限ローカライズが必要となります。

-- InitModOptions() : 
UIOptionsPCScreenの作成/初期化時に実行されるメソッドです。現在の設定のキャッシングなど、実行時に必要な処理を可能とします。

-- SetModOptionsEnabled() : 
ModOptionsとUIOptionsPCScreen間のメインインターフェース。ModOptionsによって書き込まれるUIMechaItemの配列を受け取り、UIOptionsPCScreenへ表示させます。

-- HasAnyValueChanged() : 
いずれかのオプション変更時のModOptionsへのリクエスト。オプション変更を保存せずにUIOptionsPCScreenを終了する際、警告を表示するために使用されます。

-- ApplyModSettings() : 
「保存して終了」が選択された際に呼び出され、以前に選択されたすべてのユーザー選択オプションを適用するようModOptionsに促します。

-- RestorePreviousModSettings() : 
「保存して終了」せずにオプションを終了した際に呼び出されます。ModOptionsによって、ユーザーがUIOptionsPCScreenに入った時点のオプション状態が復元されます。

-- CanResetModSettings() : 
MODがデフォルトのMOD設定を定義するかどうかに関するクエリ。「現在のMODをリセット」ボタンの設置/非設置を決定します。デフォルトでfalseのため、そのままならオプションからリセット機能が除去されます。

-- ResetModSettings() : 
「現在のMODをリセット」ボタンからコールバックされ、現在のMODタブをデフォルトにリセットします。ユーザーが退出時に「保存して終了」を選択するまで、オプションの保存は行いません。CanResetModSettings()がTRUEを戻すように上書きされている場合にのみ呼び出されます。

--------------------------------------------------

任意オプション：

ツールボックスは一般的なLW_Tupleデータ構造を利用して、 X2EventManager用いたデータの双方向送信を行います。MODがEventIDのためにRegisterForEventが必要な場合、LW_Tupleパッケージを含めてください：

1) LWTuple.ucクラスファイルをMODの/Src/LW_Tuple/Classes/内の別個のフォルダにコピーしてください
2) XComEngine.iniのセクション[UnrealEd.EditorEngine]に「+ModEditPackages=LW_Tuple」と（Src内の新規フォルダに合わせるため）追記してください
3) コード内でLWTupleクラスを使用してください

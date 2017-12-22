Long War Toolbox
par Long War Studios

Ce mod pour XCOM 2 vient ajouter différentes options de jeu à sélectionner dans le menu pendant la campagne, ainsi que quelques améliorations notables.

INSTRUCTIONS D'INSTALLATION 
Steam Workshop : abonnez-vous au mod sur le Workshop de Long War Studios.

Manuelle/Nexus : ouvrez l'archive et copiez le répertoire LW_Toolbox ainsi que son contenu dans votre version du dossier C:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods.

Pour jouer :
Cochez le mod LW_Toolbox dans le Launcher. 

Ce mod modifie automatiquement certains éléments, et notamment plusieurs options de l'interface de sélection de l'escouade. En voici la liste :

RENDRE ARMES DISPO. : retire les armes principales de tous les soldats non sélectionnés pour la mission.

VIDER ESCOUADE : retire tous les soldats de l'escouade.

REMPLIR ESCOUADE AUTO. : remplit automatiquement tous les emplacements vides de l'escouade avec le soldat le plus haut gradé disponible.

L'interface de la liste des soldats a également été retravaillée pour lui permettre d'afficher leurs statistiques.

Toutes les autres options peuvent être sélectionnées via l'onglet Toolbox, dans le menu Options (accessible en appuyant sur la touche Échap). Une fois votre campagne lancée, appuyez sur la touche Échap, sélectionnez MODIFIER LES OPTIONS, puis LW TOOLBOX. REMARQUE : ces options ne sont présentes que lors des campagnes.

Les options sont :

ROTATION CAMÉRA (DEGRÉS) : permet de contrôler le degré de rotation de la caméra via les boutons de rotation et toutes touches associées.

TAILLE ESCOUADE PAR DÉFAUT : permet de définir le nombre maximum de soldats inclus dans l'escouade. Les bonus de l'institut de guérilla, une fois terminés, sont ajoutés à ce chiffre. L'interface et le code de déploiement en mission sont désormais compatibles avec des escouades pouvant inclure jusqu'à douze soldats. REMARQUE : le mod n'a pas d'impact sur les escouades de plus grande taille sélectionnées par le joueur.

ROULETTE DÉGÂTS : les dégâts des armes d'XCOM et des extraterrestres varient d'un même pourcentage par rapport à leurs dégâts de base. Si cette option est désactivée, le jeu utilisera les mécaniques de base. Sélectionnez "25%" pour que les dégâts infligés varient de +/-25% par rapport aux dégâts de base de l'arme. Cette option écrasera les paramètres d'armes spécifiés dans le fichier INI.

CRÉATION ALÉATOIRE : Les statistiques initiales des soldats sont définies de façon aléatoire, selon une certaine base. Ces modifications sont à effet immédiat, même en cours de mission. Si cette option n'est pas sélectionnée, les valeurs seront celles par défaut. Ces statistiques aléatoires sont gardées en mémoire, et rien n'interdit d'en profiter en désactivant et réactivant plusieurs fois cette option. Elle peut être utilisée à tout moment à bord du Talion, ou lors du premier tour d'une mission tactique à condition que personne n'ait été blessé. (Il est aussi à noter que modifier les statistiques d'un soldat en cours de mission peut résulter dans la mort de celui-ci s'il est blessé et que la modification entraîne une réduction des PV.)

POTENTIEL CACHÉ : les statistiques des soldats augmentent de façon aléatoire lorsqu'ils gagnent un niveau. Remarque : les soldats "Easter Egg" spéciaux ne sont pas concernés par cette modification.

BROUILLARD ROUGE : si cette option est activée, les blessures ont un impact sur les statistiques d'attaque, de mobilité, de piratage et de volonté. Il est possible de choisir qui est affecté par le BROUILLARD ROUGE (XCOM, extraterrestres, les deux ou personne). Quelques extraterrestres, définis dans le fichier 'LW_Toolbox.ini', y sont insensibles car ils deviendraient de fait incapables d'agir.

PÉNALITÉS DE BROUILLARD ROUGE LINÉAIRES (ET NON QUADRATIQUES) : par défaut, les pénalités infligées par le brouillard rouge sont limitées en cas de blessure légère, et importantes en cas de blessure grave. Si l'application est LINÉAIRE, l'effet sera moins prononcé, et une blessure légère à modérée entraînera une plus grande pénalité qu'avec la formule quadratique.

RÉSOLUTION AUTOMATIQUE DES COMBATS : affiche un bouton dans l'interface de sélection de l'escouade permettant de résoudre automatiquement un combat tactique avec l'escouade sélectionnée, plutôt que de partir en mission.

---------------------------------------------
-----------------CRÉDITS---------------------
---------------------------------------------

Responsable technique : Rachel "Amineri" Norman
Programmation : Jonathan "tracktwo" Emmett
Responsable conception : John Lumpkin

---------------------------------------------
----------------AUTORISATIONS------------------
---------------------------------------------

Les créateurs de mods sont libres d'intégrer tout type de code ou de données extrait de ce mod dans le leur, à condition de citer Long War Studios lors de la diffusion du mod.

---------------------------------------------
---------------COMPATIBILITÉ-----------------
---------------------------------------------

Les classes remplacées par ce mod (généralement non compatible avec les autres mods remplaçant les mêmes classes) :
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

Remarques :
- XComTacticalInput
Permet d'implémenter des angles de rotation de caméra pouvant être sélectionnés.

- UIOptionsPCScreen
Permet d'implémenter des options de configuration de mod dans le jeu. 
D'autres mods peuvent utiliser cette interface en créant une extension de classe XComGameState_LWModOptions et en invoquant CreateModSettingsState pour l'ajouter à CampaignSettings.

- UISquadSelect
- UIAfterAction
Permet d'implémenter une interface pour les escouades de grande taille.
Ajout des accroches suivantes pour permettre aux autres mods d'effectuer des modifications en cas de besoin.
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // permet aux mods de retirer les soldats ne pouvant pas être déployés pour la mission actuelle
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	// permet aux mods de faire des réglages après l'initialisation du choix de l'escouade
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  // permet aux mods de retirer ou d'ajouter des soldats au lancement de SquadSelect
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   // lié à UISquadSelect_ListItem_LW.Update, permet aux mods d'ajouter des éléments aux entrées de liste individuelles

- X2TacticalGameRuleset
Permet d'élargir une zone déployable pour les unités au-delà de la grille de base de 3 cases sur 3.

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
Permet d'implémenter l'affichage des statistiques du soldat lors de la consultation et du recrutement des soldats.
Ajout des accroches suivantes pour permettre aux autres mods d'effectuer des modifications en cas de besoin.
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  // lié à UIPersonnel_SoldierListItem_LW.Update, permet de mettre à jour des éléments de décor
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  // lié à UIPersonnel_SoldierListItem_LW.Update, permet d'ajouter des éléments d'interface par-dessus des éléments déjà existants
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  // lié à UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus, permet de modifier des éléments quel que soit l'état de la liste
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // lié à UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper, permet d'écraser le statut du personnel
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   // lié à UIRecruitmentListItem_LW.InitRecruitItem, permet de modifier des éléments supplémentaires
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  // lié à UIRecruitmentListItem_LW.UpdateItemsForFocus, permet de mettre à jour des éléments mis en évidence
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // lié à UIPersonnel_SquadSelect.UpdateList, permet d'écraser le statut Désactivé d'un élément de liste 

Ce mod apporte des modifications aux templates 'Reward_Soldier', 'Reward_Rookie' et 'Reward_CouncilSoldier' de X2StrategyElement_DefaultRewards.
Le fichier délégué GenerateRewardFn est écrasé dans ces trois cas, et ne sera donc pas compatible avec un autre mod procédant à des modifications similaires.
Les fonctions de remplacement viennent ajouter les accroches suivantes, utilisables aussi bien par Toolbox que par d'autres mods :
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  // permet d'intercepter les soldats récemment créés de façon à pouvoir les modifier (à l'exception des premiers soldats créés au démarrage de la campagne)
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState );   // permet d'intercepter chaque changement de niveau de soldat à la génération des soldats bonus. À utiliser avec 'PromotionEvent' et 'PsiTrainingCompleted' pour faire en sorte de ne rater aucune occurrence.

---------------------------------------------
------------ REMARQUES POUR LES CRÉATEURS DE MODS --------------
---------------------------------------------

Il est tout à fait possible pour d'autres mods de profiter de la prise de contrôle d'UIOptionsPCScreen par LW Toolbox pour définir leurs propres options de jeu à configurer. Chaque mod enregistré apparaîtra dans un nouvel onglet du menu Options. Il s'agit d'une liste à faire défiler, si plusieurs mods choisissent de configurer leurs options ainsi.

Marche à suivre pour connecter votre mod à LW Toolbox :

1) Copiez le fichier de classe XComGameState_LWModOptions.uc dans votre mod, dans un dossier distinct, sous /Src/LW_XCGS_ModOptions/Classes/.
2) Ajoutez la ligne de config '+ModEditPackages=LW_XCGS_ModOptions' (de façon à correspondre au nouveau dossier dans 'Src') au fichier XComEngine.ini, section [UnrealEd.EditorEngine].
3) Créez une extension de XComGameState_LWModOptions pour intégrer les options de votre mod, en prenant pour exemple XComGameState_LWToolboxOptions.
4) Dans l'extension X2DownloadableContentInfo, ajoutez des liens vers CreateModSettingsState, en prenant pour exemple X2DownloadableContentInfo_LWToolbox.
5) Si le mod LW Toolbox est présent, il trouvera le gamestate ModOptions et remplira automatiquement les options du mod.

Remarques sur l'intégration de l'extension XComGameState_LWModOptions :
Le nouveau dossier 'Src' (LW_XCGS_ModOptions) entraînera la compilation d'un deuxième fichier LW_XCGS_ModOptions.u dans le répertoire de script de votre mod. Cette action est normale : elle permet aux composants et au code de ModOptions de fonctionner en l'absence de LW Toolbox. Vous pouvez installer un mod intégrant l'interface AVANT LW Toolbox, et les options fonctionneront une fois Toolbox installé.

-- InitComponent() :
 Permet d'effectuer une initialisation. Attention, ne peut se produire qu'à la création du gamestate, et aucune mise à jour n'est possible via code ou autre.

 -- GetTabText() : 
Fournit le texte à afficher dans UIOptionsPCScreen. La localisation est vivement conseillée.

-- InitModOptions() : 
Utilisé à la création ou à l'initialisation d'UIOptionsPCScreen. Permet de mettre en cache les paramètres actuels ou toute autre chose devant se produire à ce moment précis.

-- SetModOptionsEnabled() : 
Interface principale entre ModOptions et UIOptionsPCScreen. Fait passer une série d'UIMechaItem à remplir par ModOptions, puis à afficher par UIOptionsPCScreen.

-- HasAnyValueChanged() : 
Envoie une requête à ModOptions pour vérifier si des modifications sont survenues. Permet d'afficher un avertissement si l'utilisateur quitte UIOptionsPCScreen sans avoir sauvegardé ses modifications.

-- ApplyModSettings() : 
Appelé lorsque l'utilisateur sélectionne "Sauvegarder et quitter". Demande à ModOptions d'appliquer toute option choisie par l'utilisateur et préalablement sélectionnée.

-- RestorePreviousModSettings() : 
Appelé lorsque l'utilisateur quitte les options sans sauvegarder. ModOptions reprend les options telles qu'elles étaient lorsque l'utilisateur a ouvert UIOptionsPCScreen.

-- CanResetModSettings() : 
Demande si le mod définit un paramètre par défaut. Permet de placer (ou non) le bouton "Reset Mod Options" ("Réinitialiser options du mod"). "Faux" par défaut, donc sans action de votre part, l'option "Réinitialiser" n'apparaîtra pas dans votre menu.

-- ResetModSettings() : 
Rappel du bouton "Reset Mod Options" ("Réinitialiser options du mod") permettant de rendre ses valeurs par défaut au mod sélectionné. N'est pas conçu pour sauvegarder les options. Pour sauvegarder, l'utilisateur doit sélectionner "Sauvegarder et quitter" en sortant. Ne peut être appelé que si CanResetModSettings() a été modifié en "Vrai".

--------------------------------------------------

FACULTATIF :

Toolbox utilise une structure de données LW_Tuple générique pour faire transiter les données via X2EventManager. Si votre mod a besoin de 'RegisterForEvent' pour l'un de ces 'EventIDs', vous devrez inclure le paquet LW_Tuple :

1) Copiez le fichier de classe LWTuple.uc dans votre mod, dans un dossier distinct, sous /Src/LW_Tuple/Classes/.
2) Ajoutez la ligne de config '+ModEditPackages=LW_Tuple' (de façon à correspondre au nouveau dossier dans 'Src') au fichier XComEngine.ini, section [UnrealEd.EditorEngine].
3) Utilisez la classe LWTuple dans votre code.

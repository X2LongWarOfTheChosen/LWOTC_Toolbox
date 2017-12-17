Long War Toolbox
von Long War Studios

Dies ist ein Mod für XCOM 2, der das Optionsmenü um eine Reihe zusätzlicher Spieloptionen erweitert, die der Spieler während der Kampagne wählen kann, und Komfortverbesserungen einführt.

INSTALLATIONSANLEITUNG
Steam Workshop: Abonniere den Mod auf der Long War Studios-Workshop-Seite.

Manuell/Nexus: Platziere den Ordner LW_Toolbox und seinen Inhalt aus dem ZIP-Archiv in deine Version des C:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods-Ordners.

Um zu spielen:
Aktiviere den LW_Toolbox-Mod im Startprogramm.

Die automatischen Veränderungen, die dieser Mod vornimmt, umfassen mehrere Optionen für die Steuerung der Trupp-Auswahl. Das sind:

WAFFEN FREIGEBEN: Entfernt Primärwaffen von allen Soldaten, die nicht für die Mission ausgewählt wurden.

TRUPP LÖSCHEN: Entfernt alle Soldaten aus dem Trupp.

TRUPP AUTOM. FÜLLEN: Füllt automatisch alle leeren Trupp-Plätze mit einem verfügbaren Soldaten des höchsten Rangs.

Außerdem wurde die Soldatenliste überarbeitet. Sie zeigt jetzt die Werte der Soldaten an.

Alle zusätzlichen Optionen können auf der Toolbox-Registerkarte im Optionsmenü (der Zugriff erfolgt für gewöhnlich über das Drücken der Esc-Taste) ausgewählt werden. Nach dem Beginn einer Kampagne muss das Optionsmenü aufgerufen, dann OPTIONEN BEARBEITEN und anschließend die LW TOOLBOX-Option ausgewählt werden. HINWEIS: Diese Optionen sind nicht im Hauptmenü verfügbar, sondern nur während einer laufenden Kampagne.

Die Optionen sind:

KAMERA-ROTATION (IN GRAD) FESTLEGEN: So kann der Spieler das Ausmaß steuern, um das die Kamera sich dreht, wenn er die Tasten zum Drehen der Kamera und alle damit verbundenen Tastenkombinationen verwendet.

STANDARD-TRUPPGRÖSSE: So kann der Spieler die maximale Anzahl an Soldaten festlegen, die zu einem Trupp gehören können. Guerillataktik-Schule-Boni werden nach Abschluss dieser Anzahl hinzugefügt. Der Code für die Benutzeroberfläche und Einsatzvobereitung unterstützt nun Trupps mit bis zu 12 Soldaten. HINWEIS: Der Mod gleicht keine vom Spieler ausgewählten erhöhten Truppgrößen aus.

SCHADENSROULETTE: So kann der Spieler die Zufälligkeit von Waffenschäden (Alien und XCOM) im Spiel um einen bestimmten Prozentsatz anpassen. Aus bedeutet, dass das Spiel die Grundmechanik verwendet. Die 25%-Einstellung bedeutet, dass Schaden um +/- 25% des Basisschadens der Waffe variiert. Dies überschreibt alle für Waffen spezifischen INI-Einstellungen.

DIE WELT IST UNGERECHT: Dies unterwirft alle Soldaten einem Prozess, der ihre Ausgangswerte zufällig festlegt (über einen zufälligen, konfigurierbaren "Austausch" von Werten). Es wird sofort angewendet (selbst mitten in der Mission). Das Abschalten setzt Soldaten auf ihre Basiswerte zurück. Die zufällig erstellten Werte der Soldaten werden gespeichert, so dass das ununterbrochene Ein- und Ausschalten nicht ausgenutzt werden kann. Diese Option kann in der Avenger jederzeit angewendet werden oder während der ersten Runde taktischer Missionen, falls niemand verwundet wurde. (Das Ein- und Ausschalten der Werte eines Soldaten während einer Mission kann nicht nur leicht ausgenutzt werden, sondern es kann diesen Soldaten töten, wenn er verletzt ist und einige seiner Trefferpunkte eingetauscht werden.)

VERBORGENES POTENZIAL: Dies ordnet die Werte zufällig an, wenn Soldaten im Level aufsteigen. Hinweis: Besondere Easter Egg-Soldaten erhalten keine zufällig angeordneten Werte beim Levelaufstieg.

ROTER NEBEL: Dies aktiviert eine Option, in der Verletzungen die Werte Offensiv, Mobilität, Hacken und Wille beeinflussen. Der Spieler wählt aus, wen ROTER NEBEL beeinflusst – XCOM, Aliens, beide oder keine. Einige Aliens (in der Datei LW_Toolbox..ini festgelegt) sind dagegen immun, weil es sie unwirksam machen würde.

LINEARE ROTER-NEBEL-ABZÜGE VERWENDEN (ANSTELLE VON QUADRATISCHEN): Die Standard-Funktionalität von Roter Nebel wendet Strafen in einer Weise an, dass leichte Verletzungen sehr kleine Strafen verursachen, während schwere Verletzungen weitaus größere verursachen. Eine lineare Anwendung bedeutet, dass der Effekt nicht so ausgeprägt ist - eine leichte/mittlere Verletzung verursacht eine größere Strafe als die gleiche in der quadratischen Formel.

AUTOMATISCHE KAMPFENTSCHEIDUNG ZULASSEN: Dies aktiviert eine Schaltfläche in der Steuerung für die Trupp-Auswahl, mit der der Spieler taktische Kämpfe mit dem aktuellen Trupp automatisch entscheiden kann, statt auf eine Mission zu gehen.

---------------------------------------------
-----------------CREDITS---------------------
---------------------------------------------

Technical Lead: Rachel "Amineri" Norman
Programmer: Jonathan "tracktwo" Emmett
Design Lead: John Lumpkin

---------------------------------------------
------------------RECHTE---------------------
---------------------------------------------

Modder dürfen sämtlichen Code sowie andere Ressourcen dieses Mods für eigene Projekte verwenden, solange Long War Studios an den entsprechenden als Autor genannt wird.

---------------------------------------------
---------------KOMPATIBILITÄT----------------
---------------------------------------------

Durch diesen Mod ersetzte Klassen (ist prinzipiell nicht kompatibel mit anderen Mods, die die gleichen Klassen ersetzen):
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

Hinweise:
- XComTacticalInput
Wird für den Einbau des durch den Spieler wählbaren Kamerarotationswinkels benutzt.

- UIOptionsPCScreen
Wird für den Einbau der Mod-Konfigurations-Optionen im Spiel benutzt.
Andere Mods können dieses Interface benutzen, indem sie eine Klasse erstellen, die sich auf XComGameState_LWModOptions ausweitet und sie mithilfe von CreateModSettingsState zu CampaignSettings hinzufügen können.

- UISquadSelect
- UIAfterAction
Wird für den Einbau größerer Trupp-Interfaces benutzt.
Folgende Hooks hinzugefügt, damit andere Mods, die Änderungen vornehmen müssen, das auch tun können.
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // Ermöglicht es Mods, Soldaten zu entfernen, die in der aktuellen Mission nicht eingesetzt werden können.
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	// Ermöglicht es Mods, beliebige Anpassungen nach der Trupp-Auswahl-Initialisierung durchzuführen.
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState) // Ermöglicht es Mods, Soldaten zu modifizieren (entfernen oder hinzufügen), wenn SquadSelect initialisiert wird.
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self) // Aufgerufen von UISquadSelect_ListItem_LW im Update, ermöglicht es Mods, Dinge zu individuellen Listen-Objekten hinzufügen.

- X2TacticalGameRuleset
Wird benutzt, um den Einsatzbereich für Einheiten über das durch den Spielcode erlaubte 3x3 Feldgitter zu erweitern.

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
Wird für den Einbau einer Anzeige von Werten der Soldaten beim Ansehen/Rekrutieren von Soldaten benutzt.
Folgende Hooks hinzugefügt, damit andere Mods, die Änderungen vornehmen müssen, das auch tun können.
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self); // Aufgerufen von UIPersonnel_SoldierListItem_LW.Update, ermöglicht die Aktualisierung von Hintergrundelementen.
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self); // Aufgerufen von UIPersonnel_SoldierListItem_LW.Update, ermöglicht das Schichten von Steuerungselementen über bereits existierende Elemente.
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self); // Aufgerufen von UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus, ermöglicht das Verändern von Objekten, wenn ein Listen-Objekt fokussiert ist oder nicht.
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // Aufgerufen von UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper, ermöglicht das Überschreiben des Personalstatus.
	-- TriggerEvent('OnRecruitmentListItemInit', self, self); // Aufgerufen von UIRecruitmentListItem_LW.InitRecruitItem, ermöglicht den Einbau von zusätzlichen Elementen.
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self); // Aufgerufen von UIRecruitmentListItem_LW.UpdateItemsForFocus, ermöglicht die Aktualisierung von Elementen, wenn das Objekt fokussiert ist.
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // Aufgerufen von UIPersonnel_SquadSelect.UpdateList, ermöglicht das Überbrücken des Deaktiviert-Status eines Listen-Objekts.

Dieser Mod verändert die X2StrategyElement_DefaultRewards-Vorlagen 'Reward_Soldier', 'Reward_Rookie' und 'Reward_CouncilSoldier'.
Der GenerateRewardFn-Delegate wird in allen drei Fällen überschrieben und ist daher nicht mit anderen Mods kompatibel, die ähnliche Veränderungen hervorrufen.
Die Ersatzfunktionen fügen die folgenden Hooks hinzu, die Toolbox und andere Mods nutzen können:
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState ); // Ermöglicht das Abfangen von neu erstellten Soldaten, so dass Anpassungen an ihnen vorgenommen werden können. Die zum Kampagnenbeginn erstellten Soldaten sind davon nicht betroffen.
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState ); // Ermöglicht das Abfangen des Rangaufstiegs bei jedem Soldaten, wenn Belohnungssoldaten generiert werden. Am besten in Verbindung mit 'PromotionEvent' und 'PsiTrainingCompleted' benutzen, um all jene Ereignisse zu erwischen.

---------------------------------------------
----------- HINWEISE FÜR MODDER -------------
---------------------------------------------

Andere Mods können mithilfe der LW Toolbox-Version von UIOptionsPCScreen ihre eigenen im Spiel konfigurierbaren Optionen erstellen. Jeder registrierte Mod wird als zusätzliche Registerkarte im Optionsmenü angezeigt. Eine scrollbare Liste wird verwendet, wenn viele Mods ihre Optionen auf diese Art konfigurieren.

So bindest du deinen Mod in LW Toolbox ein:

1) Kopiere die Datei XComGameState_LWModOptions.uc in einem separaten Verzeichnis unter /Src/LW_XCGS_ModOptions/Classes/ in deinen Mod
2) Füge der Datei XComEngine.ini im Abschnitt [UnrealEd.EditorEngine] die Zeile "+ModEditPackages=LW_XCGS_ModOptions" (zur Angabe des neuen Verzeichnisses in Src) hinzu
3) Erstelle eine Erweiterung von XComGameState_LWModOptions, um deine eigenen Mod-Optionen zu implementieren; folge dabei dem Beispiel von XComGameState_LWToolboxOptions
4) Füge der Erweiterung X2DownloadableContentInfo Aufrufe der Funktion CreateModSettingsState hinzu; folge dabei dem Beispiel in X2DownloadableContentInfo_LWToolbox
5) Wenn der LW Toolbox-Mod aktiv ist, findet er den ModOptions-Gamestate und füllt die Mod-Optionen automatisch auf

Hinweise zur Implementierung der Erweiterung XComGameState_LWModOptions:
Das neue Src-Verzeichnis Src (LW_XCGS_ModOptions) führt dazu, dass eine zweite LW_XCGS_ModOptions.u-Datei ins Script-Verzeichnis deines Mods kompiliert wird. Dies ist beabsichtigt und ermöglicht der ModOptions-Komponente und dem dazugehörigen Code die Ausführung, wenn LW Toolbox nicht aktiv ist. Ein Mod, der das Interface implementiert, kann VOR LW Toolbox installiert werden und die Optionen funktionieren dann, sobald LW Toolbox installiert wurde.

-- InitComponent() :
Hierüber kannst du alle benötigten Initialisierungen vornehmen. Wird nur aufgerufen, wenn der Gamestate zum ersten Mal erstellt wird und nicht durch folgende Code-/Mod-Updates aktualisiert.

 -- GetTabText() : 
Gibt den Text zurück, der von UIOptionsPCScreen angezeigt wird. Sollte im Allgemeinen wenigstens lokalisiert werden.

-- InitModOptions() : 
Diese Methode wird aufgerufen, wenn UIOptionsPCScreen erstellt/initialisiert wurde. Ermöglicht das Cachen der aktuellen Einstellungen und andere Dinge, die zu diesem Zeitpunkt passieren sollen.

-- SetModOptionsEnabled() : 
Das primäre Interface zwischen ModOptions und UIOptionsPCScreen. Übergibt ein Array des Typs UIMechaItem, das von ModOptions aufgefüllt und anschließend von UIOptionsPCScreen angezeigt wird.

-- HasAnyValueChanged() : 
Anfrage an ModOptions, ob sich irgendwelche Optionen geändert haben. Wird verwendet, um eine Warnung anzuzeigen, wenn UIOptionsPCScreen verlassen wird, ohne dass Änderungen an den Optionen gespeichert wurden.

-- ApplyModSettings() : 
Wird aufgerufen, wenn der Benutzer "Speichern und verlassen" wählt, und lässt ModOptions alle vom Benutzer gewählten Optionen übernehmen.

-- RestorePreviousModSettings() : 
Wird aufgerufen, wenn der Benutzer die Optionen ohne "Speichern und verlassen" verlässt und lässt ModOptions sämtliche Optionen auf den Zustand zurücksetzen, den sie zum Zeitpunkt des Aufrufs von UIOptionsPCScreen hatten.

-- CanResetModSettings() : 
Fragt ab, ob der Mod Standardeinstellungen vorgibt. Wird verwendet, um die Schaltfläche "Mod-Optionen zurücksetzen" anzuzeigen (oder eben nicht). Standardmäßig false, sodass deine Optionen nicht über eine Reset-Funktion verfügen, solange du den Wert nicht änderst.

-- ResetModSettings() : 
Callback-Funktion der Schaltfläche "Mod-Optionen zurücksetzen", um die Registerkarte des Mods auf die Standardwerte zurückzusetzen. Sollte die Optionen nicht speichern -- dies passiert erst, wenn der Benutzer die Optionen verlässt und "Speichern und verlassen" wählt. Kann nur aufgerufen werden, wenn CanResetModSettings() überschrieben wurde und true zurückgibt.

--------------------------------------------------

OPTIONAL:

Toolbox verwendet eine generische LW_Tuple-Datenstruktur, um Daten über den X2EventManager auszutauschen. Wenn dein Mod sich über RegisterForEvent für eine dieser EventIDs registrieren soll, musst du das Paket LW_Tuple inkludieren:

1) Kopiere die Klassendatei LWTuple.uc in einem separaten Verzeichnis unter /Src/LW_Tuple/Classes/ in deinen Mod
2) Füge der Datei XComEngine.ini im Abschnitt [UnrealEd.EditorEngine] die Zeile "+ModEditPackages=LW_Tuple" (zur Angabe des neuen Verzeichnisses in Src) hinzu
3) Verwende die LWTuple-Klasse in deinem Code

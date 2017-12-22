Long War Toolbox
Di Long War Studios

Questo è un mod per XCOM 2 che aggiunge una serie di opzioni selezionabili nel menu di gioco durante le campagne, oltre ad alcune migliorie di carattere generale.

ISTRUZIONI PER L'INSTALLAZIONE 
Steam Workshop: iscriviti al mod nella pagina del workshop di Long War Studios.

Manuale/Nexus: dall'archivio zip, posiziona la cartella LW_Toolbox e i suoi contenuti nella tua versione della cartella C:\Programmi (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods folder.

Per giocare:
Spunta LW_Toolbox mod nel launcher. 

Le modifiche automatiche apportate da questo mod includono varie opzioni nell'interfaccia della selezione della squadra. Esse sono:

RENDI ARMI DISPONIBILI: rimuove le armi principali dai soldati non selezionati per la missione.

RIMUOVI SQUADRA: rimuove tutti i soldati dalla squadra.

RIEMPIMENTO AUTOMATICO SQUADRA: riempie automaticamente gli slot liberi della squadra con i soldati disponibili di grado più alto.

L'interfaccia della lista dei soldati è stata inoltre rivista per mostrare le statistiche dei giocatori.

Tutte le opzioni aggiuntive possono essere selezionate nella sezione Toolbox del menu Opzioni (accessibile tramite il tasto ESC). Dopo aver avviato una campagna, apri il menu di ESC, seleziona MODIFICA OPZIONI e seleziona l'opzione LW TOOLBOX. NOTA: queste opzioni non saranno presenti nella shell, solo nelle campagne.

Le opzioni sono:

IMPOSTA ROTAZIONE VISUALE (gradi): consente di controllare gli incrementi con cui ruota la visuale quando si usano i tasti per la rotazione e le scorciatoie associate.

SELEZIONA DIMENSIONI SQUADRA PREDEFINITE: consente di impostare il numero massimo di soldati presenti in una squadra. I bonus della scuola di guerriglia, una volta completati, verranno aggiunti a questo numero. L'interfaccia e il codice di schieramento della missione ora supportano squadre da 12 soldati. NOTA: questo mod non è bilanciato sulle dimensioni della squadra modificate dal giocatore.

ROULETTE DANNI: consente di modificare la casualità dei danni di tutte le armi (aliene e XCOM) di una percentuale comune. "No" indica che il gioco userà le meccaniche base. L'impostazione a 25% significa che i danni varieranno di +/- 25% dei danni base dell'arma. Ha la priorità su tutte le impostazioni di inizializzazione specifiche delle armi.

NON SIAMO TUTTI UGUALI: sottopone tutti i soldati a un processo che rende le statistiche casuali (tramite una serie configurabile di "scambi" casuali di statistiche). Ha effetto immediato (anche durante le missioni). Disattivare l'opzione fa tornare i soldati alle statistiche base. Le statistiche casuali dei soldati vengono ricordate, quindi non è possibile attivare e disattivare l'opzione a proprio vantaggio. L'opzione può essere usata in qualunque momento sull'Avenger o durante il primo turno di una missione tattica, a patto che nessuno sia stato ferito. (Oltre a creare possibili casi di abuso, cambiare le statistiche di un soldato ferito potrebbe farlo morire, nel caso si trovi con meno punti vita).

POTENZIALE NASCOSTO: rende casuali le statistiche dell'aumento di livello dei soldati. Nota: ai soldati speciali degli Easter Egg non si applica la casualità nell'aumento delle statistiche.

NEBBIA ROSSA: abilita un'opzione per la quale le ferite influenzano le statistiche di Attacco, Mobilità, Violazione e Volontà. Il giocatore può selezionare le unità influenzate da NEBBIA ROSSA: le unità XCOM, quelle aliene o nessuna. Alcuni alieni (impostati in LW_Toolbox.ini) sono immuni, perché perderebbero di efficacia.

USA PENALITÀ NEBBIA ROSSA LINEARI (INVECE CHE ESPONENZIALI): la funzionalità predefinita della Nebbia rossa si applica in modo che le ferite leggere portino a piccole penalità e che quelle pesanti portino penalità molto più grandi. L'applicazione lineare dà un effetto meno pronunciato: una ferita leggera/moderata porta a una penalità più grande, rispetto alla formula esponenziale.

CONSENTI SOLUZIONE AUTOMATICA COMBATTIMENTI: attiva un pulsante nell'interfaccia di selezione della squadra che consente al giocatore di risolvere automaticamente un combattimento tattico con la squadra selezionata, senza andare in missione.

---------------------------------------------
-----------------RICONOSCIMENTI---------------------
---------------------------------------------

Capo tecnico: Rachel "Amineri" Norman
Programmatore: Jonathan "tracktwo" Emmett
Capo progettazione: John Lumpkin

---------------------------------------------
----------------PERMESSI------------------
---------------------------------------------

I modder possono incorporare il codice e gli asset di questo mod nei propri mod, a patto che li attribuiscano a Long War Studios nelle sezioni appropriate.

---------------------------------------------
---------------COMPATIBILITÀ-----------------
---------------------------------------------

Classi sostituite da questo mod (in generale non sarà compatibile con gli altri mod che sostituiscono le stesse classi):
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

Note:
- XComTacticalInput
Serve a implementare gradi di rotazione della visuale selezionabili.

- UIOptionsPCScreen
Serve a implementare opzioni di configurazione all'interno del gioco. 
Gli altri mod possono usare questa interfaccia creando un'estensione della classe XComGameState_LWModOptions e richiamando CreateModSettingsState per aggiungerlo a CampaignSettings.

- UISquadSelect
- UIAfterAction
Serve a implementare interfacce più grandi per la squadra.
Sono stati aggiunti i seguenti elementi in modo che gli altri mod che devono apportare modifiche possano farlo.
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // consente ai mod di rimuovere i soldati che non possono essere impiegati nella missione attuale
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	// permette ai mod di apportare modifiche dopo l'inizializzazione della selezione della squadra
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  // permette ai mod di modificare (rimuovere o aggiungere) soldati durante l'inizializzazione della selezione della squadra
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   // chiamato da UISquadSelect_ListItem_LW in Update, consente ai mod di aggiungere elementi alle liste individuali di oggetti

- X2TacticalGameRuleset
Serve a espandere l'area di schieramento delle unità oltre la griglia 3x3 consentita dal codice del gioco base.

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
Serve a implementare la visualizzazione delle statistiche dei giocatori quando si esaminano o si reclutano i soldati.
Sono stati aggiunti i seguenti elementi in modo che gli altri mod che devono apportare modifiche possano farlo.
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  // chiamato da UIPersonnel_SoldierListItem_LW.Update, consente l'aggiornamento degli elementi in background
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  // chiamato da UIPersonnel_SoldierListItem_LW.Update, consente l'applicazione di elementi dell'interfaccia sopra elementi esistenti
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  // chiamato da UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus, consente la modifica degli elementi, con l'elemento della lista evidenziato o no
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // chiamato da UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper, consente l'override dello stato del personale
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   // chiamato da UIRecruitmentListItem_LW.InitRecruitItem, consente l'inserimento di elementi aggiuntivi
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  // chiamato da UIRecruitmentListItem_LW.UpdateItemsForFocus, consente l'aggiornamento degli elementi quando sono evidenziati
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // chiamato da UIPersonnel_SquadSelect.UpdateList, consente l'override dello stato disabilitato di un elemento in una lista 

Questo mod apporta modifiche ai seguenti modelli di X2StrategyElement_DefaultRewards: 'Reward_Soldier', 'Reward_Rookie' e 'Reward_CouncilSoldier'.
GenerateRewardFn viene sovrascritto in tutti e tre i casi, quindi non ci sarà compatibilità con altri mod che apportano modifiche simili.
Le funzioni sostitutive aggiungono i seguenti elementi, utilizzabili da Toolbox e da altri mod:
	-- TriggerEvent('SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  // Permette di intercettare i soldati appena creati, per poterli modificare. Nota: non si applica ai soldati iniziali, generati a inizio campagna
	-- TriggerEvent('RankUpEvent', NewUnitState, NewUnitState, NewGameState );   // Permette di intercettare ogni aumento di livello dei soldati, quando vengono generati i soldati premio. Da usare insieme a 'PromotionEvent' e 'PsiTrainingCompleted' per intervenire su tutti questi eventi.

---------------------------------------------
------------ NOTE PER I MODDER --------------
---------------------------------------------

Altri mod possono usare l'override di LW Toolbox su UIOptionsPCScreen per definire le loro opzioni di gioco configurabili. Ogni mod registrato apparirà come una sezione aggiuntiva nel menu delle opzioni. È una lista a scorrimento, nel caso ci siano molti mod che configurano le opzioni in questo modo.

Come collegare il proprio mod a LW Toolbox:

1) Copia la classe XComGameState_LWModOptions.uc nel tuo mod, in una cartella separata, sotto /Src/LW_XCGS_ModOptions/Classes/
2) Aggiungi la stringa di configurazione "+ModEditPackages=LW_XCGS_ModOptions" (corrispondente alla nuova cartella in Src) a XComEngine.ini, nella sezione [UnrealEd.EditorEngine]
3) Crea un'estensione di XComGameState_LWModOptions per implementare le tue opzioni nel mod, seguendo l'esempio di XComGameState_LWToolboxOptions
4) Nell'estensione X2DownloadableContentInfo, aggiungi chiamate a CreateModSettingsState, seguendo l'esempio di X2DownloadableContentInfo_LWToolbox
5) Quando il mod LW Toolbox è presente, troverà lo stato di gioco ModOptions e popolerà automaticamente le opzioni del mod

Note sull'implementazione dell'estensione XComGameState_LWModOptions:
La nuova cartella Src (LW_XCGS_ModOptions) farà compilare un secondo file LW_XCGS_ModOptions.u nella cartella degli script del mod. È normale e consente ai componenti e al codice di ModOptions di funzionare quando LW Toolbox non è presente. Un mod che implementa l'interfaccia può essere installato PRIMA di LW Toolbox. Le opzioni funzioneranno dopo l'installazione di Toolbox.

-- InitComponent() :
 Un punto per eseguire qualunque inizializzazione. Si verifica solo quando viene creato lo stato e non cambia con l'aggiornamento del codice o del mod.

 -- GetTabText() : 
Fornisce del testo da visualizzare in UIOptionsPCScreen. Solitamente dovrebbe essere almeno localizzato.

-- InitModOptions() : 
Questo metodo viene eseguito alla creazione/inizializzazione di UIOptionsPCScreen. Consente il caching delle impostazioni attuali o di qualunque cosa debba verificarsi in quel punto.

-- SetModOptionsEnabled() : 
L'interfaccia primaria tra ModOptions e UIOptionsPCScreen. Passa un array di UIMechaItem per lo riempimento con ModOptions, poi visualizzato da UIOptionsPCScreen.

-- HasAnyValueChanged() : 
Chiede a ModOptions se sono cambiate delle opzioni. Si usa per visualizzare avvisi all'uscita da UIOptionsPCScreen quando non si sono salvate le modifiche.

-- ApplyModSettings() : 
Si chiama quando l'utente seleziona "Salva ed esci," dice a ModOptions di applicare le opzioni selezionate dall'utente.

-- RestorePreviousModSettings() : 
Si chiama quando l'utente esce senza selezionare "Salva ed esci." ModOptions dovrebbe riportare lo stato delle opzioni a quello precedente all'ingresso dell'utente in UIOptionsPCScreen.

-- CanResetModSettings() : 
Richiesta per sapere se il mod definisce un'impostazione predefinita. Si usa per piazzare o meno il pulsante "Ripristina opzioni mod." Il valore predefinito è falso, quindi non intervenire sul parametro rimuoverà la funzione di ripristino dalle opzioni.

-- ResetModSettings() : 
Risposta dal pulsante "Ripristina opzioni mod," per ripristinare ai valori predefiniti la sezione del mod attuale. Non dovrebbe salvare le opzioni, dovrebbe essere gestito quando gli utenti selezionano "Salva ed esci." Può essere chiamata solo se CanResetModSettings() ha un override per rispondere vero.

--------------------------------------------------

FACOLTATIVO:

Toolbox usa una struttura dati generica di LW_Tuple per lo scambio di dati con X2EventManager. Se il tuo mod vuole RegisterForEvent per uno di questi EventID, includi il pacchetto LW_Tuple:

1) Copia la classe LWTuple.uc nel tuo mod, in una cartella separata, sotto /Src/LW_Tuple/Classes/
2) Aggiungi la stringa di configurazione "+ModEditPackages=LW_Tuple" (corrispondente alla nuova cartella in Src) a XComEngine.ini, nella sezione [UnrealEd.EditorEngine]
3) Usa la classe LWTuple nel tuo codice

Narzędzia Long War
Stworzone przez Long War Studios

To mod do XCOM 2 dodający nowe opcje rozgrywki, które gracze mogą wybrać w menu opcji gry podczas kampanii. Wprowadza on również kilka drobnych poprawek jakościowych.

INSTRUKCJA INSTALACJI 
Steam Workshop: subskrybuj mod na stronie Long War Studios.

Ręcznie/Nexus: rozpakuj archiwum zip, umieść folder LW_Toolbox i jego zawartość w twojej wersji ścieżki C:\Program Files (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods.

Aby zagrać:
Zaznacz mod LW_Toolbox w programie startowym. 

Automatyczne zmiany wprowadzane przez ten mod to, między innymi, kilka opcji interfejsu wyboru drużyny. Oto one:

UDOSTĘPNIJ BROŃ: usunięcie broni głównej wszystkich żołnierzy, których nie wybrano do aktualnej misji.

WYCZYŚĆ DRUŻYNĘ: usunięcie wszystkich żołnierzy z drużyny.

UZUPEŁNIENIE DRUŻYNY: automatyczne zapełnianie wolnych miejsc w drużynie żołnierzami o najwyższych poziomach.

Ponadto interfejs listy żołnierzy został zmodyfikowany tak, by pokazywał ich statystyki.

W zakładce narzędzi w menu opcji (domyślnie otwieranym klawiszem Escape) można wybrać dodatkowe opcje. Po uruchomieniu kampanii otwórz menu opcji, wybierz EDYTUJ OPCJE, a następnie kliknij NARZĘDZIA LW. UWAGA: Te opcje będą dostępne tylko w kampaniach.

Te opcje to:

USTALENIE OBROTU KAMERY (w stopniach): pozwala graczowi sterować zakresem obracania się kamery za pomocą przycisków obracania i przypisanych klawiszy skrótu.

WYBIERZ DOMYŚLNY ROZMIAR DRUŻYNY: pozwala graczowi określić maksymalną liczbę żołnierzy w drużynie. Premie ze szkoły działań partyzanckich, po jej ukończeniu, zostaną dodane do tej liczby. Kod interfejsu i desantu w misji obsługuje teraz drużyny złożone z 12 żołnierzy. UWAGA: mod nie jest zrównoważony dla większych rozmiarów drużyny wybranych przez gracza.

RULETKA OBRAŻEŃ: pozwala graczowi zmodyfikować losowość obrażeń każdej broni w grze (obcych i XCOM) o ten sam odsetek. Wyłączenie tej opcji spowoduje korzystanie z podstawowej mechaniki. Ustawienie 25% oznacza, że obrażenia będą oscylować wokół +/- 25% podstawowych obrażeń broni. Wszelkie inne ustawienia broni w pliku startowym zostaną zastąpione.

NIE WSZYSCY SĄ RÓWNI: ta opcja daje wszystkim żołnierzom losowo ustalone statystyki początkowe (za pomocą serii możliwych do ustalenia „wymian” w statystykach). Zmiana zaczyna działać automatycznie (nawet w trakcie misji). Jej wyłączenie przywraca podstawowe statystyki wszystkich żołnierzy. Losowo określone statystyki zostają zapamiętane, więc późniejsze włączanie i wyłączanie tej opcji nie jest luką w mechanice. Tej opcji można użyć w każdej chwili w Avengerze albo w pierwszej turze misji taktycznej, ale pod warunkiem, że nikt nie został ranny. (Oprócz stworzenia luki przełączanie statystyk żołnierza podczas misji mogłoby go zabić, gdyby był ranny i zostałaby wylosowana zamiana punktów zdrowia).

UKRYTY POTENCJAŁ: losowe rozwijanie statystyk awansujących żołnierzy. Uwaga: statystyki sekretnych żołnierzy nie będą rosnąć losowo.

CZERWONA MGŁA: uruchomienie tej opcji powoduje, że rany wpływają na statystyki celności, mobilności, hakowania i woli. Gracz określa, na kogo to działa – XCOM, obcych, obie strony albo nikogo. Część obcych (określonych w LW_Toolbox.ini) jest odporna na to działanie, ponieważ inaczej nie mogłaby funkcjonować.

ZASTOSOWANIE LINIOWYCH KAR ZA CZERWONĄ MGŁĘ (ZAMIAST KWADRATOWYCH): domyślne działanie czerwonej mgły przydziela kary tak, że lekkie rany powodują bardzo niewielkie kary, a poważne rany o wiele większe. Zastosowanie liniowych kar oznacza, że efekt jest inny – lekka/średnia rana powoduje większą karę niż ta sama rana w formule kwadratowej.

ZGODA NA AUTOMATYCZNE ROZSTRZYGNIĘCIE WALKI: aktywacja przycisku w interfejsie wyboru drużyny pozwalającego graczowi automatycznie rozstrzygnąć walkę taktyczną aktualnie wybranej drużyny, bez konieczności przechodzenia misji.

---------------------------------------------
-----------------AUTORZY---------------------
---------------------------------------------

Kierownik techniczna: Rachel "Amineri" Norman
Programista: Jonathan "tracktwo" Emmett
Kierownik projektowania: John Lumpkin

---------------------------------------------
----------------ZEZWOLENIA------------------
---------------------------------------------

Moderzy mogą wykorzystywać dowolny kod i inne materiały z tego modu pod warunkiem, że zaznaczą w odpowiednich miejscach opublikowanego modu, że wykorzystali materiały Long War Studios.

---------------------------------------------
---------------KOMPATYBILNOŚĆ-----------------
---------------------------------------------

Klasy zastępowane przez ten mod (zazwyczaj mod nie będzie kompatybilny z innymi modami zastępującymi te same klasy):
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

Uwagi:
- XComTacticalInput
Służy do wprowadzenia wybieranego przez gracza zakresu ruchu kamery.

- UIOptionsPCScreen
Służy do wprowadzania opcji konfiguracji modu w grze. 
Inne mody mogą wykorzystywać ten interfejs, tworząc rozszerzenia klasy XComGameState_LWModOptions i korzystając z CreateModSettingsState, aby dodać go do CampaignSettings.

- UISquadSelect
- UIAfterAction
Służy do wprowadzenia większych interfejsów drużyny.
Dodano następujące punkty zaczepienia, pozwalające innym modom wprowadzać zmiany.
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // pozwala modom usuwać żołnierzy, których nie można wysłać na aktualną misję.
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	// pozwala modom wprowadzać zmiany po uruchomieniu wyboru drużyny.
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState); // pozwala modom zmieniać, usuwać lub dodawać żołnierzy podczas uruchamiania wyboru drużyny.
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self); // wywołane z UISquadSelect_ListItem_LW przy aktualizacji, pozwala modom dodawać elementy do indywidualnych przedmiotów z listy.

- X2TacticalGameRuleset
Służy do powiększania obszaru wystawiania jednostek poza siatkę 3x3 pól używaną przez podstawowy kod gry.

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
Służy do wprowadzenia wyświetlania statystyk żołnierza podczas oglądania/rekrutacji żołnierzy.
Dodano następujące punkty zaczepienia, pozwalające innym modom wprowadzać zmiany.
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  // wywoływane z UIPersonnel_SoldierListItem_LW.Update, pozwala aktualizować elementy tła.
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self); // wywoływane z UIPersonnel_SoldierListItem_LW.Update, pozwala nakładać elementy na istniejący interfejs.
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self); // wywoływane z UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus, pozwala zmieniać przedmioty, nawet gdy lista przedmiotów nie jest zaznaczona.
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // wywoływane z UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper, pozwala zastępować status personelu.
	-- TriggerEvent('OnRecruitmentListItemInit', self, self); // wywoływane z UIRecruitmentListItem_LW.InitRecruitItem, pozwala modom dodawać nowe elementy.
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self); // wywoływane z UIRecruitmentListItem_LW.UpdateItemsForFocus, pozwala aktualizować elementy w czasie zaznaczenia przedmiotu.
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // wywoływane z UIPersonnel_SquadSelect.UpdateList, pozwala zastępować status wyłączenia przedmiotu z listy. 

Ten mod zmienia w X2StrategyElement_DefaultRewards szablony „Reward_Soldier”, „Reward_Rookie” i „Reward_CouncilSoldier”.
Odnośnik GenerateRewardFn zostaje zastąpiony we wszystkich trzech przypadkach, przez co nie będzie kompatybilny z innymi modami wprowadzającymi podobne zmiany.
Funkcje zastępowania wprowadzają następujące punkty zaczepienia, z których mogą korzystać narzędzia i inne mody:
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState ); // pozwala przechwytywać nowo stworzonych żołnierzy, aby wprowadzić w nich modyfikacje. Nie dotyczy to początkowych żołnierzy stworzonych przed rozpoczęciem kampanii.
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState ); // pozwala przechwytywać każdy awans żołnierza, gdy generowane są nagrody żołnierzy. Należy używać go w połączeniu z „PromotionEvent” i „PsiTrainingCompleted”, aby wychwycić wszystkie zdarzenia tego rodzaju.

---------------------------------------------
------------ UWAGI DLA MODERÓW --------------
---------------------------------------------

Inne mody mogą korzystać z narzędzi LW zastępujących UIOptionsPCScreen, żeby zdefiniować własne konfigurowalne opcje w grze. Każdy zarejestrowany mod będzie widoczny jako dodatkowa zakładka w menu opcji. Listę można przewijać, jeśli wiele modów konfiguruje w ten sposób opcje.

Czynności konieczne do połączenia twojego modu z narzędziami LW:

1) Skopiuj plik klasy XComGameState_LWModOptions.uc do swojego modu, do folderu /Src/LW_XCGS_ModOptions/Classes/
2) Dodaj linijkę konfiguracyjną „+ModEditPackages=LW_XCGS_ModOptions” (odpowiadającą nowemu folderowi w Src) do XComEngine.ini, w sekcji [UnrealEd.EditorEngine]
3) Stwórz rozszerzenie XComGameState_LWModOptions, żeby wprowadzić własne opcje modu, zgodnie z przykładem przedstawionym z XComGameState_LWToolboxOptions
4) W rozszerzeniu X2DownloadableContentInfo dodaj wywołania do CreateModSettingsState, zgodnie z przykładem podanym w X2DownloadableContentInfo_LWToolbox
5) Gdy działa mod narzędzi LW, wyszuka on stan gry ModOptions i automatycznie zapełni opcje modu

Informacje o wprowadzaniu rozszerzenia XComGameState_LWModOptions:
Nowy folder Src (LW_XCGS_ModOptions) spowoduje, że drugi plik LW_XCGS_ModOptions.u zostanie skompilowany do twojego folderu skryptu modu. To normalne i pozwala komponentom oraz kodowi ModOptions działać, gdy narzędzie LW nie jest dostępne. Mod wprowadzający ten interfejs można zainstalować zanim zostanie zainstalowane narzędzie LW, a opcje zaczną działać po zainstalowaniu narzędzi.

-- InitComponent() :
 Miejsce do przeprowadzenia wymaganego uruchomienia. Pamiętaj, że dochodzi do tego tylko, gdy zostanie po raz pierwszy stworzony stan gry, a aktualizacja nie następuje, gdy aktualizowany jest kod lub mod.

 -- GetTabText() : 
Dostarcza tekst wyświetlany w UIOptionsPCScreen. Ogólnie powinno się go przynajmniej zlokalizować.

-- InitModOptions() : 
Tej metody używa się przy tworzeniu/uruchamianiu UIOptionsPCScreen. Umożliwia przechowywanie aktualnych ustawień i wszystkiego, co musi się w danej chwili wydarzyć.

-- SetModOptionsEnabled() : 
Główny interfejs pomiędzy ModOptions i UIOptionsPCScreen. Przekazuje macierz UIMechaItem do zapełnienia przez ModOptions, wyświetlaną później przez UIOptionsPCScreen.

-- HasAnyValueChanged() : 
Zapytanie do ModOptions o ewentualną zmianę jakichkolwiek opcji. Służy do wyświetlania ostrzeżenia podczas opuszczania UIOptionsPCScreen bez zapisania zmian.

-- ApplyModSettings() : 
Uruchamiane gdy użytkownik wybierze „zapisz i wyjdź”. Sprawia, że ModOptions wprowadza wybrane przez użytkownika opcje.

-- RestorePreviousModSettings() : 
Uruchamiane gdy użytkownik wychodzi, nie korzystając z opcji „zapisz i wyjdź”. ModOptions powinno przywrócić opcje z chwili wejścia użytkownika do UIOptionsPCScreen.

-- CanResetModSettings() : 
Zapytanie, czy mod określa domyślne ustawienie. Służy do umieszczenia przycisku „resetuj opcje modu”. Domyślnie wyłączone, więc zostawiając to w ten sposób, usuwamy z menu opcji funkcję resetowania.

-- ResetModSettings() : 
Odwołanie z przycisku „resetuj opcje modu”, żeby przywrócić ustawienia domyślne w aktualnej zakładce modu. Nie powinno zapisywać opcji – to stanie się, gdy użytkownik wyjdzie, wybierając opcję „zapisz i wyjdź”. Można użyć, tylko jeśli CanResetModSettings() jest włączone.

--------------------------------------------------

OPCJONALNE:

Narzędzie używa ogólnej struktury danych LW_Tuple do przekazywania danych za pomocą X2EventManager. Jeśli twój mod ma skorzystać z RegisterForEvent dla jednego z tych EventID, musisz zastosować pakiet LW_Tuple:

1) Skopiuj plik klasy LWTuple.uc do swojego modu, do folderu /Src/LW_Tuple/Classes/
2) Dodaj linijkę konfiguracyjną „+ModEditPackages=LW_Tuple” (dopasowaną do nowego folderu w Src) do XComEngine.ini, do sekcji [UnrealEd.EditorEngine]
3) Użyj klasy LWTuple w swoim kodzie.

Herramientas de Long War
Por Long War Studios

Este mod para XCOM 2 añade una serie de opciones de juego que los jugadores pueden seleccionar en el menú de opciones durante las campañas, además de unas cuantas mejoras para facilitaros la vida.

INSTRUCCIONES DE INSTALACIÓN 
Steam Workshop: suscríbete al mod en la página de Steam Workshop de Long War Studios.

Manual/Nexus: desde el archivo comprimido, coloca la carpeta LW_Toolbox y sus contenidos en tu versión de la carpeta C:\Archivos de programa (x86)\Steam\steamapps\common\XCOM 2\XComGame\Mods.

Para jugar:
Activa el mod LW_Toolbox en el programa de inicio. 

Los cambios automáticos que produce este mod incluyen varias opciones de la interfaz de selección del pelotón. Estas son:

DEJAR ARMAS DISPONIBLES: quita las armas principales de todos los soldados no seleccionados para la misión.

ELIMINAR PELOTÓN: elimina a todos los soldados del pelotón.

AUTOCOMPLETAR PELOTÓN: rellena de forma automática cualquier espacio de pelotón vacío con el soldado disponible de rango más alto.

Además, se ha diseñado de nuevo la interfaz de la lista de soldados para que muestre atributos de los soldados.

Todas las opciones adicionales se pueden seleccionar en la pestaña Herramientas, en el menú Opciones (accesible normalmente mediante la tecla Escape). Después de iniciar una campaña, abre el menú con la tecla Esc, elige EDITAR OPCIONES y después la opción HERRAMIENTAS DE LW. NOTA: Estas opciones no estarán disponibles en el shell, solo en las campañas.

Las opciones son:

ROTACIÓN DE LA CÁMARA (grados): permite al jugador controlar el incremento de la rotación de la cámara usando los botones de rotación y cualquier tecla de acceso rápido vinculada.

SELECCIONAR TAMAÑO DE PELOTÓN POR DEFECTO: permite al jugador elegir el número máximo de soldados que pueden formar parte de un pelotón. Una vez completadas, las bonificaciones de la escuela de tácticas de guerrilla se añadirán a dicho número. Ahora, la interfaz y el código de despliegue de la misión ofrecerán soporte para pelotones de hasta 12 soldados. NOTA: este mod no equilibra ningún tamaño aumentado de pelotón seleccionado por el jugador.

RULETA DE DAÑOS: permite al jugador modificar el carácter aleatorio del daño de todas las armas (alienígenas y de XCOM) según un porcentaje común. "Desactivar" significa que el juego empleará una mecánica de base. El ajuste "25%" significa que el daño variará en un +/- 25% del daño básico del arma. Esta opción anula cualquier otra configuración del archivo ini específica de las armas.

NO CREADOS IGUALES: esta opción somete a todos los soldados a un proceso que aleatoriza sus atributos iniciales (a través de una serie aleatoria de "intercambios" de atributos configurables). Esto es efectivo de inmediato (incluso en mitad de una misión). Al desactivar la opción, los soldados vuelven a sus atributos básicos. Los atributos aleatorios de los soldados son recordados, por lo que no es posible abusar de este sistema mediante activaciones y desactivaciones sucesivas. Esta opción se puede usar en el Avenger en cualquier momento, o durante el primer turno de una misión táctica, suponiendo que nadie haya resultado herido (además de permitir el abuso de esta función, cambiar los atributos de un soldado en una misión podría matarlo si está herido y ve reducidos sus puntos de salud).

POTENCIAL OCULTO: aleatoriza los atributos cuando los soldados suben de nivel. Nota: los soldados especiales de huevo de Pascua no tendrán atributos aleatorios al subir de nivel.

NIEBLA ROJA: habilita una opción mediante la cual las heridas afectan a los atributos de ataque, movilidad, pirateo y voluntad. El jugador elige a quién le afecta la NIEBLA ROJA: XCOM, alienígenas, ambos o ninguno. Algunos alienígenas (establecidos en el archivo LW_Toolbox.ini) son inmunes a esto, ya que de otro modo se volverían ineficaces.

USAR PENALIZACIONES DE NIEBLA ROJA LINEALES (EN LUGAR DE CUADRÁTICAS): la funcionalidad por defecto de niebla roja aplica penalizaciones, de forma que las heridas leves provocan penalizaciones muy pequeñas, mientras que las graves producen penalizaciones muy grandes. Una aplicación linear hace que el efecto no sea tan marcado: una herida leve/moderada provoca una penalización mayor que la misma herida en la fórmula cuadrática.

PERMITIR RESOLVER AUTOMÁTICAMENTE EL COMBATE: esta opción activa un botón en la interfaz de selección de pelotón que permite al jugador resolver de forma automática un combate táctico con el pelotón seleccionado en ese momento en vez de iniciar una misión.

---------------------------------------------
-----------------CRÉDITOS---------------------
---------------------------------------------

Jefa de diseño técnico: Rachel "Amineri" Norman
Programador: Jonathan "tracktwo" Emmett
Jefe de diseño: John Lumpkin

---------------------------------------------
----------------PERMISOS------------------
---------------------------------------------

Los modders tienen libertad para incorporar cualquier código o recursos de este mod a los suyos, siempre que reconozcan el mérito a Long War Studios en los lugares apropiados de las publicaciones de mods.

---------------------------------------------
---------------COMPATIBILIDAD-----------------
---------------------------------------------

Clases reemplazadas por este mod (en general no será compatible con otros mods que reemplacen las mismas clases):
- XComTacticalInput
- UIOptionsPCScreen
- UISquadSelect
- UIAfterAction
- X2TacticalGameRuleset
- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem

Notas:
- XComTacticalInput
Se usa para implementar ángulos de rotación de la cámara seleccionables por el jugador.

- UIOptionsPCScreen
Se usa para implementar opciones de configuración de mods en el juego. 
Otros mods pueden utilizar esta interfaz mediante la creación de una extensión de clase XComGameState_LWModOptions y la invocación de CreateModSettingsState para añadirlo a CampaignSettings.

- UISquadSelect
- UIAfterAction
Se usa para implementar interfaces de pelotón mayores.
Se han añadido los siguientes ganchos para que los demás mods que necesiten hacer cambios puedan hacerlo.
	-- TriggerEvent('OnValidateDeployableSoldiers', DeployableSoldiersTuple, self); // permite que los mods retiren soldados que no puedan ser parte del despliegue de la misión actual.
	-- TriggerEvent('PostSquadSelectInit', XComHQ, self);	// permite que los mods realicen ajustes tras iniciar la selección de pelotón.
	-- TriggerEvent('OnUpdateSquadSelectSoldiers', XComHQ, XComHQ, NewGameState)  // permite que los mods modifiquen (retiren o añadan) soldados al iniciar la selección de pelotón.
	-- TriggerEvent('OnUpdateSquadSelect_ListItem', self, self)   // se activa desde UISquadSelect_ListItem_LW al actualizar y permite que los mods añadan cosas a objetos de lista individuales.

- X2TacticalGameRuleset
Se usa para ampliar el área de despliegue de unidades más allá de la cuadrícula de casillas de 3x3 permitida por el código del juego básico.

- UIPersonnel_SquadSelect
- UIPersonnel_SoldierListItem
- UIRecruitmentListItem
Se usa para implementar la visualización de atributos de soldados cuando se ven/reclutan soldados.
Se han añadido los siguientes ganchos para que los demás mods que necesiten hacer cambios puedan hacerlo.
	-- TriggerEvent('OnSoldierListItemUpdate_Start', self, self);  // se activa desde UIPersonnel_SoldierListItem_LW.Update y permite la actualización de elementos del fondo.
	-- TriggerEvent('OnSoldierListItemUpdate_End', self, self);  // se activa desde UIPersonnel_SoldierListItem_LW.Update y permite colocar capas de elementos de la interfaz sobre elementos ya existentes.
	-- TriggerEvent('OnSoldierListItemUpdate_Focussed', self, self);  // se activa desde UIPersonnel_SoldierListItem_LW.UpdateItemsForFocus y permite alterar objetos cuando el objeto de la lista está resaltado o no.
	-- TriggerEvent('OnSoldierListItem_GetPersonnelStatus', self, self); // se activa desde UIPersonnel_SoldierListItem_LW.GetPersonnelStatusSeparateWrapper y permite ignorar y sobrescribir el estado del personal.
	-- TriggerEvent('OnRecruitmentListItemInit', self, self);   // se activa desde UIRecruitmentListItem_LW.InitRecruitItem y permite que se modifiquen y añadan más elementos.
	-- TriggerEvent('OnRecruitmentListItemUpdateFocus', self, self);  // se activa desde UIRecruitmentListItem_LW.UpdateItemsForFocus y permite que se actualicen elementos cuando el objeto está resaltado.
	-- TriggerEvent('OnSoldierListItemUpdateDisabled', UnitItem, self); // se activa desde UIPersonnel_SquadSelect.UpdateList y permite ignorar el estado Desactivado de un objeto de lista. 

Este mod hace cambios a las plantillas de X2StrategyElement_DefaultRewards 'Reward_Soldier', 'Reward_Rookie' y 'Reward_CouncilSoldier'.
El delegado GenerateRewardFn se sobrescribe en los tres casos y no será compatible con otro mod que realice cambios similares.
Las funciones de reemplazo añaden los siguientes ganchos que pueden ser usados por las Herramientas y otros mods.
	-- TriggerEvent( 'SoldierCreatedEvent', NewUnitState, NewUnitState, NewGameState );  // permite interceptar soldados recién creados para que puedan realizarse modificaciones en ellos. Ten en cuenta que esto no afecta a los soldados iniciales creados al comienzo de la campaña.
	-- TriggerEvent( 'RankUpEvent', NewUnitState, NewUnitState, NewGameState );   // permite interceptar las subidas de rango de cada soldado cuando se generan soldados de recompensa. Se usa junto con 'PromotionEvent' y 'PsiTrainingCompleted' para atrapar esos eventos.

---------------------------------------------
------------ NOTAS PARA LOS MODDERS --------------
---------------------------------------------

Otros mods pueden utilizar la anulación de las Herramientas de LW de UIOptionsPCScreen para definir sus propias opciones configurables en el juego. Cada mod registrado aparecerá como una pestaña adicional en el menú Opciones. Esta será una lista desplazable si hay muchos mods que configuren las opciones de esta manera.

Pasos para enlazar tu mod con las Herramientas de LW:

1) Copia el archivo de clase XComGameState_LWModOptions.uc en tu mod, en una carpeta independiente, en /Src/LW_XCGS_ModOptions/Classes/
2) Añade la línea de configuración "+ModEditPackages=LW_XCGS_ModOptions" (para que coincida con la nueva carpeta en Src) a XComEngine.ini, sección [UnrealEd.EditorEngine]
3) Crea una extensión de XComGameState_LWModOptions para implementar tus propias opciones de mods, siguiendo el ejemplo establecido en XComGameState_LWToolboxOptions
4) En la extensión X2DownloadableContentInfo, añade llamadas a CreateModSettingsState, siguiendo el ejemplo en X2DownloadableContentInfo_LWToolbox
5) Cuando el mod Herramientas de LW esté presente, buscará el estado del juego ModOptions y rellenará las opciones del mod de forma automática

Notas sobre la implementación de la extensión XComGameState_LWModOptions:
La nueva carpeta Src (LW_XCGS_ModOptions) dará como resultado la compilación de un segundo archivo LW_XCGS_ModOptions.u en la carpeta de script de tu mod. Esto es normal y permite que el componente ModOptions y el código funcionen cuando el mod Herramientas de LW no esté presente. Se puede instalar un mod que implemente la interfaz ANTES de la instalación del mod Herramientas de LW, y las opciones funcionarán cuando se hayan instalado las Herramientas.

-- InitComponent() :
 Un punto para realizar cualquier inicialización que se desee. Esto solo ocurre cuando se crea por primera vez el estado del juego, y no se actualizará con actualizaciones del código/mod.

 -- GetTabText() : 
Proporciona el texto que se mostrará en UIOptionsPCScreen. Por lo general, debería estar localizado.

-- InitModOptions() : 
Ese método se ejecuta cada vez que se crea/inicializa UIOptionsPCScreen. Permite almacenar en caché la configuración actual o cualquier otra cosa que tenga que realizarse en ese momento.

-- SetModOptionsEnabled() : 
La interfaz principal entre ModOptions y UIOptionsPCScreen. Transfiere una serie de UIMechaItem para que sean rellenadas por ModOptions, y a continuación se muestran en UIOptionsPCScreen.

-- HasAnyValueChanged() : 
Realiza una solicitud a ModOptions si se modifica alguna opción. Se usa para mostrar una advertencia cuando se abandona UIOptionsPCScreen sin guardar los cambios realizados a las opciones.

-- ApplyModSettings() : 
Se activa cuando el usuario selecciona "Guardar y salir" e indica a ModOptions que aplique cualquier opción seleccionada por el usuario que se haya seleccionado anteriormente.

-- RestorePreviousModSettings() : 
Se activa cuando el usuario sale de las opciones sin seleccionar "Guardar y salir". ModOptions debería volver al estado de las opciones correspondiente al momento en que el usuario accedió a UIOptionsPCScreen.

-- CanResetModSettings() : 
Pregunta si el mod define una configuración de mod predeterminada. Se usa para colocar (o no) el botón "Restablecer opciones de mod". El valor predeterminado es "False". Si no se cambia, eliminará la función de restablecimiento de tus opciones.

-- ResetModSettings() : 
Invitación del botón "Restablecer opciones de mod" para restablecer la pestaña del mod actual a sus valores predeterminados. No debería guardar las opciones. Esto se producirá cuando el usuario salga y seleccione "Guardar y salir". Solo se puede activar si CanResetModSettings() se anula para que devuelva "True".

--------------------------------------------------

OPCIONAL:

Las Herramientas utilizan una estructura de datos genérica LW_Tuple para transmitir datos mediante X2EventManager. Si tu mod quiere RegisterForEvent para uno de estos EventIDs, deberás incluir el paquete LW_Tuple:

1) Copia el archivo de clase LWTuple.uc en tu mod, en una carpeta independiente, en /Src/LWTuple.uc/Classes/
2) Añade la línea de configuración "+ModEditPackages=LW_Tuple" (para que coincida con la nueva carpeta en Src) a XComEngine.ini, sección [UnrealEd.EditorEngine]
3) Usa la clase LWTuple en tu código

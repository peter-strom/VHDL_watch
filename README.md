# Projekt II - Digital konstruktion - Ela21, YRGO

Handledare: Erik Jagre och Erik Pihl 

Utfört av: Daniel Mentzer och Peter Strömblad
            
## VHDL klocka


## Introduktion

I detta projektet konstruerades en 24-timmars klocka med timerfunktion på ett FPGA-kort <a href="https://github.com/peter-strom/VHDL_klocka/blob/main/Projekt_II-Digital_klocka.pdf" target="_blank">(Projekt_II-Digital_klocka.pdf)</a>. FPGA-kortet var av modellen "Cyclone V 5CEBA4F23C7N" och konstruktionen skapades med VHDL i "Quartus Prime 18.1". Koden skrevs i "Visual Studio Code" med VHDL tilläget från Pu Zhao. Simuleringar gjordes i "ModelSim 10.5b".

![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig1.png?raw=true)

Fig.1 - Knapparna som användes samt dess funktion. 

## Resultat

Den första och roligaste nöten att knäcka var hur klockan skulle räkna upp. Ett enkelt sätt att utforma klockan var att ha en räknare för sekunder, minuter och timmar. Och med hjälp av en carry-bit påverka den följande räknaren. Dock valdes en lösning som endast innefattar en räknare som räknar upp till 86400 vilket är antalet sekunder på ett dygn. Två instanser av räknaren implementerades, en för klockfunktion och en för timerfunktionen. Med hjälp av generic kunde vi enkelt välja om räknaren skulle räkna upp eller ner.

Ett enkelt Excel-dokument användes för att lösa problemet med att omvandla sekunderna till användbara värden för de sex olika sju-segments displayer. Men när vi visade konstruktionen i RTL Viewern såg vi att de båda räknarna inte delade “omvandlings-kretsen” vi just konstruerat. Detta löste sig när omvandlingen flyttades utanför if-satsen, se Fig. 3.

Det vi inte löste var hur kretsen skall starta med en automatisk reset.


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig2.png?raw=true)

Fig.2 - Efter 23:59:59 slår räknaren om till 00:00:00. Början av projektet koncentrerades till att lösa det stora problemet med räknaren. Därför gjordes först en testbänk endast för counter.


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig3.png?raw=true)

Fig.3 - Första och andra försöket till att få de båda räknarna att samsas om funktionen för 7-segments omvandlingen. 


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig4.png?raw=true)

Fig.4 - Testbänken byggdes ut i takt med projektet växte. 


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig5.png?raw=true)

Fig.5 - Den färdiga konstruktionen i RTL Viewer. 


https://youtu.be/RBYuLH2Qr9E

Fig.6 - Filmklipp på den färdiga konstruktionen. 

## Diskussion

Kul och givande projekt där vi hade stor frihet i utformningen av klockan och dess funktioner. Att dessutom få utföra projektet tillsammans med en bra partner bidrog till ökad kreativitet och utveckling. Mycket tack vare våra olika kunskapsnivåer där en är en van programmerare medan den andra kommer från hårdvarubakgrund. Detta lyste igenom i hur problem angreps och lösningar utformades. En hade lättare för tydliga och enkla lösningar medan den andra byggde en bättre grund som senare i projektet gjorde nya funktioner enkla att implementera.

Med Microsofts fantastiska VSCode-extension ”Liveshare” kunde vi dessutom sammarbeta på ett effektivt sätt över internet. Simuleringen delgavs via discords skärmdelning och test på FPGA streamades med en webcam.

## TODO: Fixa bugg: 23:59:59 -> 00:00:00 går för fort.

### Erik Jagre (20 juni 2022)
Generellt:
VG-nivå - en imponerande lösning som visar på god förståelse i kursens moment!

Kommentar:
* Elegant lösning med en ensam sekundräknare som ni sedan delar upp i ss/mm/hh.
* Järvt att använda division, jag trodde inte Quartus skulle ställa upp på det. (har ni jämfört resursanvändningen före lösningen med separata räknare för ss/mm/hh?)
* Men skiftar inte klockan över från 23:59:59 till 00:00:00 lite i hastigaste laget? jag är rädd att er klocka kommer gå 365 sekunder fel på ett år...
* Er testbänk borde exekverat från 23:59:59 till 00:00:00 (då hade ni sett varför klockan drar sig lite)



### Erik Jagre (23 juni 2022)
Era ingångar är inte synkroniserade med dubbla vippor. Det finns risk att ni använder ett in-värde i er design som inte är av korrekt logisk nivå (varken ett eller noll).


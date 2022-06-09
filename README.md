# Projekt II - Digital konstruktion - Ela21, YRGO

Handledare: Erik Jagre
Utfört av: Daniel Mentzer och Peter Strömblad
            
## VHDL klocka


## Introduktion

I detta projektet konstruerades en 24-timmars klocka med timerfunktion på ett FPGA-kort <a href="https://github.com/peter-strom/VHDL_klocka/blob/main/Projekt_II-Digital_klocka.pdf" target="_blank">(Projekt_II-Digital_klocka.pdf)</a>. FPGA-kortet var av modellen "Cyclone V 5CEBA4F23C7N" och konstruktionen skapades med VHDL i "Quartus Prime 18.1". Koden skrevs i "Visual Studio Code" med VHDL tilläget från Pu Zhao. Simuleringar gjordes i "ModelSim 10.5b".

![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig1.png?raw=true)

Fig.1 - Knapparna som användes samt dess funktion. 

## Resultat

Ett mycket roligt projekt där det gavs möjlighet att lösa uppgiften två och två. Med Microsofts fantastiska VSCode-extension ”Liveshare” kunde vi på ett effektivt sätt jobba tillsammans över internet. Simuleringen delgavs via discords skärmdelning. Den roligaste uppgiften var att lösa räknarproblemet där vi först hade 3 olika lösningsförslag. …

![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig2.png?raw=true)

Fig.2 - Efter 23:59:59 slår räknaren om till 00:00:00. Början av projektet koncentrerades till att lösa det stora problemet med räknaren. Därför gjordes först en testbänk för counter.


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig3.png?raw=true)

Fig.2 - Försa och andra försöket till att få de båda räknarna att samsas om funktionen för 7-segments omvandlingen. 


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig4.png?raw=true)

Fig.4 - Testbänken byggdes ut i takt med projektet växte. 


![alt text](https://github.com/peter-strom/VHDL_klocka/blob/main/fig5.png?raw=true)

Fig.5 - Den färdiga konstruktionen i RTL Viewer. 


https://youtu.be/RBYuLH2Qr9E

Fig.5 - Filmklipp på den färdiga konstruktionen. 

#!/bin/bash

# Script d'installation de fichiers MIB pour une supervision SNMP


#Checklist pour demander à l'utilisateur quels fichiers il souhaite installer
LST_MIB=$(whiptail --title "Import de fichiers MIB" --checklist "Quels models de commutateurs souhaitez vous importer ?\n
Selectionnez en vous déplaçant avec les fleches haut et bas, puis cochez la case avec espace. Appuyez ensuite sur entrer pour valider" 40 100 13 \
"HPE_3600-24_v2_SI_Switch" "" 0 \
"HPE_3600-48_v2_SI_Switch" "" 0 \
"HPE_5130-24G" "" 0 \
"HPE_5130-48G" "" 0 \
"HPE_5140_24G_PoE+_4SFP+_EI_Sw_JL827A" "" 0 \
"HPE_5140_48G_PoE+_4SFP+_EI_Sw_JL824A" "" 0 \
"HPE_5500-24G-EI" "" 0 \
"HPE_A5500-48G_EI" "" 0 \
"HPE_5510_24G_4SFP+_HI" "" 0 \
"HPE_5510_24G_SFP_4SFP+_HI_1-slot_Switch_JH149A" "" 0 \
"HPE_5510_48G_4SFP+_HI_1-slot_Switch_JH146A" "" 0 \
"HPE_5520_24G" "" 0 \
"HPE_5520_48G" "En cours d'ajout..." 0 3>&1 1>&2 2>&3) #renvoie les choix de l'utilisateur sous forme de chaine de caracteres

LST_MIB=$(echo "$LST_MIB" | sed 's/\"//g') #enlève les gillemets de la chaine de caractères


declare -A dico_MIB #Cree un dictionnaire pour lier les modèles de commutateurs à leurs numero de fichier
dico_MIB['HPE_3600-24_v2_SI_Switch']='95'
dico_MIB['HPE_3600-48_v2_SI_Switch']='96'
dico_MIB['HPE_5130-24G']='188'
dico_MIB['HPE_5130-48G']='189'
dico_MIB['HPE_5140_24G_PoE+_4SFP+_EI_Sw_JL827A']='298'
dico_MIB['HPE_5140_48G_PoE+_4SFP+_EI_Sw_JL824A']='299'
dico_MIB['HPE_5500-24G-EI']='24'
dico_MIB['HPE_A5500-48G_EI']='25'
dico_MIB['HPE_5510_24G_4SFP+_HI']='215'
dico_MIB['HPE_5510_24G_SFP_4SFP+_HI_1-slot_Switch_JH149A']='219'
dico_MIB['HPE_5510_48G_4SFP+_HI_1-slot_Switch_JH146A']='216'
dico_MIB['HPE_5520_24G']='308'
dico_MIB['HPE_5520_48G']='?'

#Pour supprimer un dictionnaire
#unset dico_MIB['HPE_5130-24G']='188'


for switch in $LST_MIB #Parcours notre chaine de caracteres comme un tableau pour retrouver le numero de fichier en fonction des les valeurs choisies par l'utilisateur
do
num_MIB=${dico_MIB[$switch]}
switch2=$(echo "$switch" | sed -r 's/[_]+/ /g') #Enlève les _ des modèles de commutateurs

if [ -f "/var/nedi/sysobj/1.3.6.1.4.1.25506.11.1.$num_MIB.def" ]; #Verifie si le fichier MIB existe, si il n'existe pas il l'installe
then
#Si le fichier existe, Demande à l'utilisateur si il souhaite le remplacer
	if whiptail --yesno "Le fichier pour $switch2 existe,\nSouhaitez vous le remplacer ?" 10 80;
	then
	#Création d'un fichier MIB
	echo "# Definition for 1.3.6.1.4.1.25506.11.1.$num_MIB created by Defed 2.1 on 31.Oct 2024 (admin)
 
# Main
SNMPv	2HC
Type	$switch2
TypOID	
NamOID	
DesOID	
OS	Comware
Icon	lbmg
Size	1
Uptime	U
Bridge	qbriX
ArpND	oldphy
Dispro	LLDPXN
Serial	1.3.6.1.2.1.47.1.1.1.1.11.2
Bimage	1.3.6.1.2.1.47.1.1.1.1.10.2
VLnams	1.3.6.1.2.1.17.7.1.4.3.1.1	
VLnamx	
Group	
Mode	
CfgChg	
CfgWrt	1.3.6.1.4.1.25506.2.4.1.1.3.0
FTPConf	
Fanstat		
 
# Interfaces
StartX	
EndX	
IFname	1.3.6.1.2.1.31.1.1.1.1
IFaddr	adr	
IFalia	1.3.6.1.2.1.31.1.1.1.18
IFalix	
InBcast	1.3.6.1.2.1.31.1.1.1.9
InDisc	1.3.6.1.2.1.2.2.1.13
OutDisc	1.3.6.1.2.1.2.2.1.19
IFvlan	1.3.6.1.2.1.17.7.1.4.5.1.1	
IFvlix	
IFpowr		
IFpwix	
IFpalc	
IFdupl	1.3.6.1.2.1.10.7.2.1.19
IFduix	1.3.6.1.2.1.10.7.2.1.1
Halfdp	2
Fulldp	3
 
# Modules
Modom		
Moslot	1.3.6.1.2.1.47.1.1.1.1.7
Moclas	1.3.6.1.2.1.47.1.1.1.1.5
Movalu	9
Modesc	1.3.6.1.2.1.47.1.1.1.1.2
Modhw	1.3.6.1.2.1.47.1.1.1.1.8
Modfw	1.3.6.1.2.1.47.1.1.1.1.10
Modsw	1.3.6.1.2.1.47.1.1.1.1.9
Modser	1.3.6.1.2.1.47.1.1.1.1.11
Momodl	1.3.6.1.2.1.47.1.1.1.1.13.2
Modloc	
Mostat	
Mostok	
 
# RRD Graphing
CPUutl	1.3.6.1.4.1.25506.2.6.1.1.1.1.6.82	%	
Temp			
MemCPU			
Custom			" > /var/nedi/sysobj/1.3.6.1.4.1.25506.11.1.$num_MIB.def
	fi
else
echo "Le fichier pour $switch2 n'existe pas, installation..."
#Création d'un fichier MIB
echo "# Definition for 1.3.6.1.4.1.25506.11.1.$num_MIB created by Defed 2.1 on 31.Oct 2024 (admin)
 
# Main
SNMPv	2HC
Type	$switch2
TypOID	
NamOID	
DesOID	
OS	Comware
Icon	lbmg
Size	1
Uptime	U
Bridge	qbriX
ArpND	oldphy
Dispro	LLDPXN
Serial	1.3.6.1.2.1.47.1.1.1.1.11.2
Bimage	1.3.6.1.2.1.47.1.1.1.1.10.2
VLnams	1.3.6.1.2.1.17.7.1.4.3.1.1	
VLnamx	
Group	
Mode	
CfgChg	
CfgWrt	1.3.6.1.4.1.25506.2.4.1.1.3.0
FTPConf	
Fanstat		
 
# Interfaces
StartX	
EndX	
IFname	1.3.6.1.2.1.31.1.1.1.1
IFaddr	adr	
IFalia	1.3.6.1.2.1.31.1.1.1.18
IFalix	
InBcast	1.3.6.1.2.1.31.1.1.1.9
InDisc	1.3.6.1.2.1.2.2.1.13
OutDisc	1.3.6.1.2.1.2.2.1.19
IFvlan	1.3.6.1.2.1.17.7.1.4.5.1.1	
IFvlix	
IFpowr		
IFpwix	
IFpalc	
IFdupl	1.3.6.1.2.1.10.7.2.1.19
IFduix	1.3.6.1.2.1.10.7.2.1.1
Halfdp	2
Fulldp	3
 
# Modules
Modom		
Moslot	1.3.6.1.2.1.47.1.1.1.1.7
Moclas	1.3.6.1.2.1.47.1.1.1.1.5
Movalu	9
Modesc	1.3.6.1.2.1.47.1.1.1.1.2
Modhw	1.3.6.1.2.1.47.1.1.1.1.8
Modfw	1.3.6.1.2.1.47.1.1.1.1.10
Modsw	1.3.6.1.2.1.47.1.1.1.1.9
Modser	1.3.6.1.2.1.47.1.1.1.1.11
Momodl	1.3.6.1.2.1.47.1.1.1.1.13.2
Modloc	
Mostat	
Mostok	
 
# RRD Graphing
CPUutl	1.3.6.1.4.1.25506.2.6.1.1.1.1.6.82	%	
Temp			
MemCPU			
Custom			" > /var/nedi/sysobj/1.3.6.1.4.1.25506.11.1.$num_MIB.def
fi

done

sudo chown -R www-data:www-data /var/nedi #Donne les droits sur les fichers de NeDi à NeDi (ce qui lui permet d'éditer les fichiers que nous vennons de créer)

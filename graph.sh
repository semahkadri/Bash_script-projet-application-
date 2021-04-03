#!/bin/sh

#Fct 2eme menu
Afficher_sauvgarder()
{


yad --center --width=250 --height=100 --title="MENU1"  --text "Veuillez choisir : 
                1) Afficher les informations sur les péripheriques de votre  ordinateur :
                2) Afficher les informations sur larchitecture du processeur :
                3) Sauvegarder vos informations :" --button="<b><span color='black'>1</span></b>":1 --button="<b><span color='black'>2</span></b>":2 --button="<b><span color='black'>3</span></b>"



case $? in
                1)
                        function1;;
                2)
                        function2;;
                3)
                        function3;;
                
            
esac
}

#Fct quittez
quit()
{
 yad --center --width=250 --height=100 --image dialog-question --text "Voulez-vous quitte?" text-align=center \
--button="<b><span color='black'>No</span></b>"!gtk-no:1 --button="<b><span color='black'>Yes</span></b>"!gtk-yes:0
if [ $? = 0 ] ; then
 exit 
fi
}

#Fct1(lshw)
function1()
{
yad --center --width=400 --height=300 --text-info --title="1" --back=black --fore=white<funtion1
	echo `lshw > funtion1`
}

#Fct2(lscpu)
function2()
{
yad --center --width=400 --height=300 --text-info --title="2" --back=black --fore=white<funtion2
	echo `lscpu > funtion2`
}

#Fct3(Save)
function3()
{
yad --center --width=400 --height=300 --text-info --title="4" --back=black --fore=white<save.txt
	echo `lshw > save.txt | lscpu >> save.txt`
	
}


#Fct5(Help)
helpp()
{
yad --center --width=400 --height=300 --text-info --title="help" --back=black --fore=white<help
}

#Fct6(Version et auteurs)
Version_Auteur()
{
yad --center --width=400 --height=300 --text-info --title="Version & Auteurs" --back=black --fore=white<version_auteur
echo `cat /etc/os-release>> version_auteur`
}

#Menu principal
while [ "$choix" != "0" ]
do
yad --center --width=400 --height=300 --title="Aplication Shell" --image="acceuil.jpg"  \
--button="<b><span color='black'> All Hardware informations </span></b>":1 \
--button="<b><span color='black'> Version et Auteurs </span></b>":2 \
--button="<b><span color='black'> Help </span></b>":3 \
--button="<b><span color='black'>Quit</span></b>"!gtk-quit:0 \
--buttons-layout=center \

case $? in
        0) quit ;;
        1) Afficher_sauvgarder ;;
	2) Version_Auteur;;
        3) helpp ;;
esac

done


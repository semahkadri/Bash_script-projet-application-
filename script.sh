#!/bin/bash

#Fct_help (option -h)
function help
{
        echo "-w : Afficher les caractéristiques par la commande lshw"
        echo "-u : Afficher les caractéristiques par la commande lscpu"
        echo "-s [arg]:nom du fichier : Enregistrement du fichier contenant les informations système avec la date de création"
        echo "-g : Afficher le menu graphique" 
	echo "-m : Afficher un menu en boucle" 
        echo "-o [arg]:nom du fichier : Afficher le fichier contenant les informations système avec la date de création"
	echo "-v :Afficher la version et les auteurs "
	echo "-f -o [arg]:Mot clé :Afficher les lignes contenant le mot clé dans un fichier "
}

#Fct_lshw (option -w)
function lshw
{
	echo`lshw`
}


#Fct_lscpu (option -u)
function lscpu
{
        echo`lscpu`
}

#Fct_save (option -s)
function save
{
	echo `lshw > save.txt`
	echo `lscpu >> save.txt`        
	 cp  save.txt /Bureau/projet/$s
} 

#Fct_Afficher_Menu (option -m)
function menu
{
#Creation d'un message pompt
 PS3="Votre choix:"
#Creation d'un menu a partir de la commande select
select item in "-Afficher les caractéristiques par la commande lshw-" "-Afficher les caractéristiques par la commande lscpu-" "-Enregistrement du fichier contenant les informations système avec la date de création-" "-Affiche le menu graphique-" "-Affichage du fichier contenant les informations système avec la date de création-" "-Afficher les lignes contenant le mot clé dans un fichier-" "-Afficher la version et les auteurs-" "Afficher le manuel help-" "-Quittez-"
do
	echo "Vous avez choisi l'item $REPLY : $item"
	case $REPLY in
	1)
		echo "Lancement de la commande  lswh"
		lshw
		;;
	2)
		echo "Lancement de la commande  lscpu"
                lscpu
                ;;

	3) 	echo "Lancement de la commande save"
		save
		;;

	4) 	echo "Lancement de la commande menu graphique"
		./graph.sh
		;;

	5)	echo "Lancement de la commande affichage des information"
		Affichage_InfoPertinantes
		;;
	
	6) 	echo "Lancement de la commande affichage des lignes contenant le mot clé"
		Affichage_MotCle
		;;

	7) 	echo "Lancement de la commande afficher auteur et version"
		auteur_version
		;;
	
	8)
		echo "Lancement de la commande help"
                help
                ;;
	
	9)
		echo "Fin du menu"
		exit 0
		;;
	*) 
		echo "Choix incorrect"
		;;
	esac

done
}

#Fct_Afficher_version_aut (option -v)
function auteur_version
{
	echo ""
	cat /etc/os-release
	echo 'Les auteurs sont: Semah Kadri et Ines Kouki'
}



#Fct_Afficher_informations(option -o)
function Affichage_InfoPertinantes
{
if [ -e /home/esprit/Desktop/${OPTARG} ]
 then {
	if [ -f /home/esprit/Desktop/${OPTARG} ]
	 then
	   lswh --short>/home/ines/Bureau/projet/${OPTARG}
	 else 
	   echo "L'argument passé en parametre n'est pas un fichier"
	fi

echo " Fichier déja existant"
}
else
 { echo -e "Le fichier n'existe pas \n Creation d'un nouveau en cours"
    lshw --short>/home/ines/Bureau/projet/${OPTARG}
}
fi
Fichier=${OPTARG}
}

#Fct_afficher_mot_cle (Option -f)
function Affichage_MotCle
{
	cat | grep -i $Mot_Cle  /home/ines/Bureau/projet/$Fichier
}

#Boucle pour tester ce que l'utilisateur va saisir
#La commande interne getops permet a un script d'analyser les options passées en arguments
#La liste des options utilisable avec ce script sont definies a la ligne (getops :huwsvmf:go")

while getopts ":huwsvmf:go:" option
  do
          echo "getopts a trouvé l'option $option"
          case $option in
                  h)
                       echo "Exécution des commandes de l'option h"
			 help
                        ;;
                  w)
			echo "Exécution des commandes de l'option w"
                        lshw
			;;
		  u)
			echo "Exécution des commandes de l'option u"
			lscpu 
			;;
    
                  s)	echo "Exécution des commandes de l'option s"
                        d=$(date +%Y-%m-%d)
                        s="$OPTARG"_$d
                        save $s_$d
                        echo "Les informations sont enregistrées dans le fichier /var/projet/$s"
                          ;;

                  g)
			echo "Exécution des commandes de l'option g"
                        ./graph.sh
                                ;;
  	  	  v)
			echo "Exécution des commandes de l'option v"
			auteur_version 
				;;
		  m)	echo "Exécution des commandes de l'option m"
			menu 	
				;;
                  o)
			echo "Exécution des commandes de l'option o"		
                        Affichage_InfoPertinantes
				;;

	       	  f)  echo "Exécution des commandes de l'option f"
			echo -e "$OPTIND"  
			if [ ! "$OPTIND" -lt 5 ]
			then
			 Mot_Cle=${OPTARG} Affichage_MotCle 
			else
		 	echo "Invalid"
			fi
			;;
                                
		  ?) echo "L'option $OPTARG est invalide"

          esac
done

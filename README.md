
# Introduction
## Données
Les données que nous avons choisi sont constituées de deux datasets :
- des relevés de stations météo réparties sur toute la surface du globe, depuis la fin des années 80
- la surface de glace dans les océans, pendant la même période
- le niveau global des océans depuis les années 1992

	Plusieurs points nous ont fait décider d'aborder ce thème du réchauffement climatique : notre intérêt personnel sur le sujet, son importance dans notre vie de tous les jours, … De plus, c'est un sujet qui concerne de plus en plus de gens , ce qui facilite la compréhension des analyses. La découverte du premier dataset et sa qualité n'a fait que cimenter l'idée.
	Les données de station météo proviennent de la **NCEI** (National Centers for Environmental Information), qui est un des leaders mondiaux dans la distribution gratuite de données sur le climat. Le dataset comprend 833,189 entrées distinctes, avec un total de 36 variables. Ces variables peuvent être regroupées selon : **station** (longitude, latitude, élévation, nom, …) concernée, **pression** (au niveau de la mer et pression de vapeur d'eau), **température** (moyenne, min, max), **précipitation** (nb de jours, total, moyenne, …), **durée de jour**. Toutes les données sont regroupées dans un fichier sous forme CSV.
  
	Le deuxième dataset sur la surface de glace a été jugé intéressant pour compléter le premier dataset, en ajoutant une nouvelle variable de comparaison plus globale. Ces données proviennent de la **NSIDC** (National Snow and Ice Data Center). Ce dataset est composé d'une seule donnée : la surface de glace mesurée pendant un mois donné. Les entrées remontent au début des années 80, et sont séparées en 4 sous-groupes, selon la localisation (hémisphère nord ou sud) et le type (surface ou étendue). On espère que ce dataset permettra d'ajouter un aspect plus réel à notre analyse.

	Le dernier dataset représente les données mesurées depuis 3 satellites différents du niveau des eaux autour du globe. Ces données proviennent de la NESDIS (National Environmental Satellite, Data, and Information Service) , elle contient  1662 données concernant le niveau des eaux en millimètres. ainsi que la date correspondante. Les mesures sont effectuées plusieurs fois par an (environ 29 fois). 
Avec ce dataset nous souhaitons montrer l’effet de la fonte des glaces sur le niveau des océans.

## Plan d'analyse
Ces données nous permettront de répondre à travers la visualisation à plusieurs questions. En effet, le réchauffement climatique est de plus en plus préoccupant et nous souhaitons savoir si son évolution a pu diminuer au cours des dernières années par rapport au début du siècle. Pour cela nous comptons corréler plusieurs paramètres afin de visualiser les évolutions des différents éléments tels que la température mesurée dans les différentes stations du monde, les précipitations et la pression. Ces données nous permettront de nous rendre plus facilement compte de l’évolution du climat dans le monde et d’en tirer également des conclusions sur les impacts environnementaux que nous subissons actuellement et à anticiper l’évolution future du climat.

On pourrait alors réaliser une visualisation avec l’évolution du climat en fonction des zones géographiques.

Cette évolution nous permettrait aussi de prévoir et anticiper les prochaines zones géographiques qui seront touchées par de nouveaux phénomènes naturels tels que la montée des eaux, la sécheresse …

Afin de nous rendre compte des conséquences de cette évolution nous avons voulu corréler notre dataset avec la fonte de la banquise en fonction du climat. Il y aura surement un travail de mise en relation à faire entre les deux datasets qui pourrait aussi poser problème dans la visualisation des données, étant donné que les datasets n’ont pas les mêmes fréquences de mesure. Nous espérons que cette corrélation nous permettra de tirer des conclusions sur d'autres variables réelles,  comme la montée du niveau de la mer. 

# Rapport sur l'Exercice des Dominos
## Introduction
L'objectif de cet exercice est de modéliser un jeu de dominos à l'aide de la programmation logique avec Answer Set Programming (ASP). Un domino est représenté par un symbole fonctionnel domino(I, J) indiquant les deux chiffres qu'il porte. Nous devons aligner ces dominos selon les règles suivantes :
- Un domino peut être ajouté à l'une des deux extrémités de la suite déjà construite.
- Les deux faces en contact doivent porter le même chiffre.
- Un domino peut être retourné.
- Le but est de trouver toutes les séquences possibles comprenant tous les dominos.

## Etapes de Réalisation
### Etape 1: Générer Tous les 28 Dominos
La première étape consiste à générer tous les dominos possibles, ce qui donne un total de 28 dominos pour les valeurs de 0 à 6.

### Etape 2: Associer les Dominos à des Positions
Nous devons générer les 28 positions (steps) et y associer les dominos tout en respectant les règles de succession.

### Etape 3: Unicité des Dominos
Il faut s'assurer qu'un domino n'apparaisse qu'une seule fois dans la séquence.

### Etape 4: Filtre de Succession
Les dominos doivent être alignés de manière à ce que les chiffres aux extrémités correspondantes soient les mêmes.

### Etape 5: Gestion des Swaps
Un domino et son swap (retourné) ne doivent pas apparaître deux fois dans la séquence.

### Etape 6: Choix de Swap
Le générateur doit être capable de choisir de swapper ou non un domino pour assurer la continuité de la séquence.

## Code ASP
Voici le code ASP pour résoudre ce problème :
```
% ################### Etapes à suivre pour réaliser le jeu de domino ########################

% Etape 1: Génerer tous les 28 bons dominos.
% Etape 2: Génerer les 28 steps et y associer des dominos -> seq(N, d(X, Y):- domino(X,Y)).
% Etape 3: S'assurer qu'un domino n'apparait qu'une fois.
% Etape 4: Mettre un filtre de succession des dominos dans la séquence.
% Etape 5: S'assurer qu'un domino et son swap n'apparaissent pas 2 fois.
% Etape 6: Modifier le générateur pour choisir de swap ou non.

% ####################### PROGRAMME ASP DU JEUX DOMINOS ############################

% Elements du jeu
nb(0..6).
nbPiece(1..28).

% Etape 1: Générer tous les 28 bons dominos
{domino(I, J) : nb(I), nb(J)} = 28.

% Filtrage: s'assurer qu'un domino n'apparait qu'une seule fois - Etape 3
:- domino(I, J), I > J.

% Etape 2 et 6: Générer les 28 steps et y associer des dominos
{seq(N, (d(I, J); d(J, I))) : domino(I, J)} = 1 :- nbPiece(N).

% Filtre: s'assurer qu'un domino n'apparait qu'une seule fois
:- seq(N, d(I, J)), seq(N1, d(I, J)), N != N1.

% Filtre (Etape 5): s'assurer qu'un domino et son swap n'apparaissent pas 2 fois 
:- seq(N, d(I, J)), seq(N1, d(J, I)), N != N1.

% Etape 4: Filtre de succession des dominos dans la séquence
:- seq(N, d(_, J1)), seq(N + 1, d(I1, _)), J1 != I1.

#show seq/2.
```
## Explication du Code
1. Génération des Dominos :
```
{domino(I, J) : nb(I), nb(J)} = 28.
```
Cette règle génère tous les dominos possibles pour les valeurs de 0 à 6.

2. Filtrage des Dominos :
```
:- domino(I, J), I > J.
```
Cette contrainte assure que chaque combinaison (I, J) est unique et que (I, J) n'est pas considéré deux fois si I > J.

3. Association des Dominos aux Positions :
```
{seq(N, (d(I, J); d(J, I))) : domino(I, J)} = 1 :- nbPiece(N).
```
Chaque position N dans la séquence reçoit exactement un domino (soit d(I, J) soit son swap d(J, I)).

4. Unicité des Dominos dans la Séquence :
```
:- seq(N, d(I, J)), seq(N1, d(I, J)), N != N1.
```
Cette contrainte assure qu'un même domino d(I, J) n'apparaît pas deux fois dans la séquence.

5. Unicité des Swaps dans la Séquence :
```
:- seq(N, d(I, J)), seq(N1, d(J, I)), N != N1.
```
Cette contrainte empêche qu'un domino et son swap apparaissent tous les deux dans la séquence.

6. Filtrage de Succession :
```
:- seq(N, d(_, J1)), seq(N + 1, d(I1, _)), J1 != I1.
```
Cette règle assure que les dominos sont alignés correctement avec les chiffres correspondants aux extrémités.

## Conclusion
Le programme ASP présenté permet de générer toutes les séquences possibles de dominos en respectant les règles du jeu. Il garantit que chaque domino n'apparaît qu'une seule fois et que les dominos sont correctement alignés. Ce modèle peut être utilisé pour explorer différentes configurations et solutions pour le jeu de dominos.

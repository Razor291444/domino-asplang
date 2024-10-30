% ################### Etapes à suivre pour réaliser le jeu de domino ########################

% Etape 1: Génerer tous les 28 bons dominaux.
% Etape 2: Génerer les 28 steps et y associer des dominaux -> seq(N, d(X, Y):- domino(X,Y)).
% Etape 3: S'assurer qu'un domino n'appariait qu'une fois.
% Etape 4: Mettre un filtre de succession des dominaux dans la séquence.
% Etape 5: S'assurer qu'un domino et son swap n'apparaissent pas 2 fois.
% Etape 6: Modifier le générateur pour choisir de swap ou non.

%####################### PROGRAMME ASP DU JEUX DOMINOS ############################

% Elements du jeu
nb(0..6).
nbPiece(1..28).
% Etape 1
% generate -> Génerer tous les 28 bons dominuax
{domino(I,J) : nb(I), nb(J)}=28.
% test -> filtrage : s'assure qu'un domino n'apparait qu'une seule fois - Etape 3
:- domino(I,J), I > J.

% Etape 2 + Etape 5
% Génerer les 28 steps et y associer des dominaux
{seq(N, (d(I,J); d(J, I))) : domino(I,J)}=1 :- nbPiece(N).

% test -> filtre 
% S'assurer qu'un domino n'apparait qu'une fois
%:- seq(N, (d(I,J); d(J, I))), seq(N1, d(I,J)), N!=N1.
% S'assurer qu'un domino et son swap n'apparaissent pas 2 fois
:- seq(N, d(I,J)), seq(N1, d(I,J)), N!=N1.
% Mettre un filtre de succession des dominos dans la séquence
:- seq(N, d(_,J1)), seq(N+1, d(I1,_)), J1!=I1.

#show seq/2.

%#show domino/2.  
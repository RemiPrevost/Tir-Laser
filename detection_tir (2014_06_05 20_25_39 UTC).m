clear all;
close all;
clc;

% fr�quences des pistolets
F1=85005.9;
F2=90000;
F3=94986.8;
F4=100000;
F5=115015.9;
F6=120000;
Ampl=5;
% fr�quence et temps d'�chantillonage
Fe=320000;
Te=1/Fe;

% largeur fen�tre
T= 0.2*10^-3;

% nombre de points pour l'�chantillonage
M= Fe*T ;

% temps de simulation
Tsim=T-Te;

% lancement de la simulation
sim('signal_pistolet');

% affichage du signal temporel = somme de tous les sinus de tous les
% pistolets
figure (1)
subplot(2,2,1)
plot(Tmp_Ech, S_Ech);
hold on;

%fft de S_Ech

FFT_Ech=abs(fft(S_Ech));
F_Ech=linspace(0,Fe,64);
subplot(2,2,2)
stem(F_Ech, FFT_Ech,'x');
hold on;

%fft de S_Ech en �chelle log pour question 3

FFT_Ech=abs(fft(S_Ech));
F_Ech=linspace(0,Fe,64);
subplot(2,2,3)
plot(F_Ech, log(FFT_Ech),'+');
hold on;

% Question 3 : gr�ce � l'�chelle log on peut mettre en �vidence l'impact de
% fr�quences n'�tant pas des multiples parfaits du pas fr�quentiel. Ici on
% remarque que la marge est (largement) assez grande pour distinguer les
% niveaux hauts des niveaux bas



S_tronc=S_Ech;
for i=1:M/2
    S_tronc(i)=0;
end
% affichage du signal temporel = somme de tous les sinus de tous les
% pistolets
figure (2)
subplot(1,2,1)
plot(Tmp_Ech, S_tronc);
hold on;

%fft de S_Ech
subplot(1,2,2)
FFT_Ech_tronc=abs(fft(S_tronc));
F_Ech=linspace(0,Fe,64);
stem(F_Ech, FFT_Ech_tronc,'+');

% Question 5: plus aucune marge entre les niveaux si le signal temporel est tronqu�
%--> probl�me � r�soudre � l'avenir

% lancement de la simulation
sim('signal_carre');

% affichage du signal carr� de fr�quence 85kHz
figure(3) 
plot(Tmp_Ech_2, Carre_Ech);

% affichage de la fft du signal carr�
figure(4)
FFT_carre=abs(fft(Carre_Ech));
stem(F_Ech, FFT_carre,'+');

% Question 6 : les sinus cardinaux se superposent


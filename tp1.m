clc; 
clear; 
close all; 
% Paramètres 
A = 2;              % amplitude 
f = 50;             % fréquence en Hz
% 
% % 1. vecteur temps
Te = 0.0001;
t = 0:Te:0.02;

%2. signal 50 Hz
x = A*sin(2*pi*f*t);

%3. signal 10 Hz
b = A*sin(2*pi*30*t);

%signal 500 Hz
c = A*sin(2*pi*500*t);
%signal 1000 Hz
d = A*sin(2*pi*1000*t);

% affichage
 
plot(t,x,'r--','LineWidth',1.5)
hold on
plot(t,b,'g','LineWidth',1.5)
plot(t,c,'y','LineWidth',1.5)
plot(t,d,'k','LineWidth',1.5)
grid on
% 
xlabel('Temps (s)')
ylabel('Amplitude')
title('Comparaison 50 Hz , 30 Hz , 500Hz et 1000 Hz'); 
legend('50 Hz', '30 Hz' , '500 Hz' , '1000 Hz'); 

% ======Variation de l'amplitude ==========
% % 2. signal 50 Hz
% x = A*sin(2*pi*f*t);
% A2 = 5;
% x2 = A2*sin(2*pi*f*t);
% plot(t,x,'r--','LineWidth',1.5)
% hold on
% grid on 
% plot(t , x2 )
% 
% xlabel('Temps (s)')
% ylabel('Amplitude')
% title('Comparaison Amplitude A = 2 , A = 5'); 
% legend( '2','5');
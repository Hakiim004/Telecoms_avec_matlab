% TP : Comprendre le rapport signal/bruit (SNR)
% Génération d'un signal sinusoïdal, ajout de bruit, calcul des puissances et du SNR

clear; close all; clc;

% --- Paramètres ---
A = 1;                % Amplitude du signal sinusoidal (V)
f0 = 5;               % Fréquence du signal (Hz)
Fe = 1000;            % Fréquence d'échantillonnage (Hz)
T = 1;                % Durée du signal (s)
t = (0:1/Fe:T-1/Fe)'; % Vecteur temps

% Puissance du bruit souhaitée (variance)
Pnoise = 0.1;         % W (ou V^2 si impédance 1 ohm)

% --- 1. Génération du signal sinusoïdal ---
signal_propre = A * sin(2*pi*f0*t);

% --- 2. Calcul de la puissance du signal ---
Psignal = mean(signal_propre.^2);  % Puissance = valeur quadratique moyenne

% --- 3. Génération du bruit ---
bruit = sqrt(Pnoise) * randn(size(t));  % Bruit blanc gaussien de variance Pnoise

% --- 4. Calcul de la puissance du bruit (vérification) ---
Pbruit_calculee = mean(bruit.^2);       % Doit être proche de Pnoise

% --- 5. Signal bruité ---
signal_bruite = signal_propre + bruit;

% --- 6. Calcul du SNR ---
SNR_lineaire = Psignal / Pnoise;         % Rapport en linéaire
SNR_dB = 10 * log10(SNR_lineaire);       % Rapport en dB

% --- Affichage des résultats ---
fprintf('Puissance du signal pur : %.4f\n', Psignal);
fprintf('Puissance du bruit (consigne) : %.4f\n', Pnoise);
fprintf('Puissance du bruit calculée : %.4f\n', Pbruit_calculee);
fprintf('SNR linéaire : %.2f\n', SNR_lineaire);
fprintf('SNR (dB) : %.2f dB\n', SNR_dB);

% --- Tracés ---
figure;

subplot(3,1,1);
plot(t, signal_propre);
xlabel('Temps (s)'); ylabel('Amplitude');
title('Signal sinusoidal pur');
grid on;

subplot(3,1,2);
plot(t, bruit);
xlabel('Temps (s)'); ylabel('Amplitude');
title('Bruit seul');
grid on;

subplot(3,1,3);
plot(t, signal_bruite);
xlabel('Temps (s)'); ylabel('Amplitude');
title(['Signal bruité (SNR = ' num2str(SNR_dB, '%.1f') ' dB)']);
grid on;

% --- Pour observer l'effet du bruit, modifier la variable Pnoise ---
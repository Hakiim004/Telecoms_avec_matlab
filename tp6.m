% TP : Comprendre le taux d'erreur binaire (BER)
% Génération de bits aléatoires, modulation BPSK, ajout de bruit,
% détection et calcul du BER pour différents niveaux de bruit.

clear; close all; clc;

% --- Paramètres ---
N = 1000000;                   % Nombre de bits à transmettre
Eb = 1;                      % Énergie par bit (pour BPSK, amplitude = sqrt(Eb))
SNR_dB = 0:2:10;             % Différents rapports signal/bruit (en dB) à tester

% --- 1. Génération des bits aléatoires ---
bits = randi([0 1], N, 1);   % Vecteur colonne de 0 et 1

% --- 2. Modulation BPSK ---
% Mapping : 0 -> -1, 1 -> +1 (ou l'inverse, cela n'a pas d'importance)
symboles = 2*bits - 1;       % Convertit 0 en -1, 1 en +1
% On peut aussi utiliser : symboles = (bits == 1)*2 - 1;

% --- 3. Boucle sur les différents niveaux de bruit ---
BER = zeros(size(SNR_dB));   % Pour stocker les résultats

for i = 1:length(SNR_dB)
    % Calcul de la variance du bruit à partir du SNR
    % En BPSK, le rapport Eb/N0 (dB) = SNR_dB (car Eb=1, et on considère la puissance du bruit sur la bande)
    % La puissance du bruit (variance) = N0/2 = 1/(2*10^(SNR_dB/10)) ? Attention : pour un signal réel, la variance du bruit additif est N0/2.
    % Ici, on ajoute un bruit complexe? Non, BPSK est réel, on utilise un bruit réel gaussien de variance N0/2.
    % Avec Eb=1, Eb/N0 (linéaire) = 10^(SNR_dB/10). Donc N0 = Eb / (10^(SNR_dB/10)) = 1/10^(SNR_dB/10).
    % La variance du bruit (pour un bruit réel) est N0/2 = 1/(2*10^(SNR_dB/10)).
    EbN0_lin = 10^(SNR_dB(i)/10);
    N0 = 1 / EbN0_lin;          % Densité spectrale monolatérale
    variance_bruit = N0/2;      % Variance du bruit réel (bilatérale)
    
    % Génération du bruit
    bruit = sqrt(variance_bruit) * randn(N, 1);
    
    % Signal reçu
    signal_recu = symboles + bruit;
    
    % --- 4. Détection des bits reçus ---
    bits_estimes = (signal_recu > 0);   % Seuil à 0 : si >0 -> 1, sinon 0
    
    % --- 5. Calcul du BER ---
    erreurs = sum(bits ~= bits_estimes);
    BER(i) = erreurs / N;
end

% --- Affichage des résultats ---
figure;
semilogy(SNR_dB, BER, 'b-o');
xlabel('SNR (dB)');
ylabel('BER');
title('Taux d''erreur binaire en fonction du SNR');
grid on;

% Affichage textuel
fprintf('SNR (dB)\tBER\n');
for i = 1:length(SNR_dB)
    fprintf('%d\t\t%.2e\n', SNR_dB(i), BER(i));
end
% 
% % --- Réponses aux questions ---
% disp(' ');
% disp('Réponses aux questions :');
% disp('1. Lorsque le bruit augmente (SNR diminue), le BER augmente : plus de bits sont erronés.');
% disp('2. Le bruit provoque des erreurs car il modifie aléatoirement l''amplitude du signal reçu. Si le bruit est suffisamment fort, il peut faire passer un symbole +1 en dessous du seuil de décision (0) ou un symbole -1 au-dessus, entraînant une erreur de décision.');
% disp('3. La relation entre SNR et BER est inverse : plus le SNR est élevé, plus le BER est faible. En BPSK, le BER théorique est Q(sqrt(2*Eb/N0)), où Q est la fonction de queue de la gaussienne. Donc le BER diminue exponentiellement avec le SNR.');
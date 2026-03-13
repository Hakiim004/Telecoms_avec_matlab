% === SIMULATION SIMPLE D'UNE MODULATION QPSK ===
% Pour débutants : génération de bits, mapping, ajout de bruit, tracé

clear; close all; clc;

% 1. Générer 200 bits aléatoires (0 ou 1)
N = 200;
bits = randi([0,1], 1, N);
disp('Les 10 premiers bits :'); disp(bits(1:10));

% 2. Regrouper les bits par paires (dibits) pour former des symboles de 0 à 3
N_symboles = N/2;                % 100 symboles
symboles = zeros(1, N_symboles);
for i = 1:N_symboles
    bit1 = bits(2*i - 1);        % premier bit de la paire
    bit2 = bits(2*i);            % second bit
    symboles(i) = bit1*2 + bit2; % conversion binaire -> décimal (0-3)
end
disp('Les 5 premiers symboles (0-3) :'); disp(symboles(1:5));

% 3. Mapping QPSK : associer chaque symbole à une phase
%    On utilise 4 phases : 45°, 135°, 225°, 315° (soit pi/4, 3pi/4, 5pi/4, 7pi/4)
%    Les points de la constellation sont sur le cercle unité (amplitude = 1)
constellation = exp(1j * [pi/4, 3*pi/4, 5*pi/4, 7*pi/4]);

%    Créer le signal modulé (nombres complexes)
signal_emission = zeros(1, N_symboles);
for i = 1:N_symboles
    % MATLAB indexe à partir de 1, donc symbole 0 -> indice 1, symbole 1 -> indice 2, etc.
    signal_emission(i) = constellation(symboles(i) + 1);
end

% Afficher les 5 premiers symboles modulés (parties réelle et imaginaire)
disp('Les 5 premiers symboles émis (complexes) :');
for i = 1:5
    fprintf('Symbole %d -> %.3f + %.3fi (phase = %.1f°)\n', ...
        symboles(i), real(signal_emission(i)), imag(signal_emission(i)), ...
        angle(signal_emission(i))*180/pi);
end

% 4. Ajouter du bruit (canal AWGN) avec un rapport signal sur bruit (SNR) de 10 dB
SNR_dB = 10;                     % SNR en décibels
SNR_lin = 10^(SNR_dB/10);        % conversion en linéaire
puissance_signal = mean(abs(signal_emission).^2);   % puissance du signal (doit être ~1)
puissance_bruit = puissance_signal / SNR_lin;       % puissance du bruit

% Générer un bruit complexe gaussien (parties réelle et imaginaire indépendantes)
bruit = sqrt(puissance_bruit/2) * (randn(1, N_symboles) + 1j*randn(1, N_symboles));

% Signal reçu = signal émis + bruit
signal_recu = signal_emission + bruit;

% 5. Tracer les constellations
figure('Name', 'Constellation QPSK', 'Position', [100 100 900 400]);

% Sous-figure 1 : constellation idéale (sans bruit)
subplot(1,2,1);
plot(real(constellation), imag(constellation), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold on;
grid on;
axis equal;
xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);
xlabel('Partie réelle (I)'); ylabel('Partie imaginaire (Q)');
title('Constellation QPSK idéale');
% Ajouter les étiquettes des symboles
for i = 1:4
    text(real(constellation(i))*1.1, imag(constellation(i))*1.1, ...
        sprintf('%d', i-1), 'FontSize', 12, 'HorizontalAlignment', 'center');
end
% Tracer le cercle unité pour référence
theta = linspace(0, 2*pi, 100);
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 0.5);

% Sous-figure 2 : constellation avec bruit (signal reçu)
subplot(1,2,2);
plot(real(signal_recu), imag(signal_recu), 'b.', 'MarkerSize', 6);
hold on;
plot(real(constellation), imag(constellation), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
grid on;
axis equal;
xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);
xlabel('Partie réelle (I)'); ylabel('Partie imaginaire (Q)');
title(['Constellation avec bruit (SNR = ', num2str(SNR_dB), ' dB)']);
legend('Symboles reçus', 'Points idéaux', 'Location', 'best');
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 0.5);

% Affichage d'un message final
fprintf('\nSimulation terminée.\n');
fprintf('SNR utilisé : %d dB\n', SNR_dB);
fprintf('Puissance du signal : %.3f\n', puissance_signal);
fprintf('Puissance du bruit : %.3f\n', puissance_bruit);
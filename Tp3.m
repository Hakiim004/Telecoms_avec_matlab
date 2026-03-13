%1. Générer 100 bits aléatoires. 
N = 100; 
bits = randi([0,1], 1,N);
%2. Convertir les bits en symboles BPSK. 
symbols = 2*bits - 1;
% le bruit gaussien
sigma = 0.8 ;
bruit = sigma * randi(1,N);
recu = symbols + bruit;

%Detection

bits_recus = recu > 0; 

erreurs = sum(bits ~= bits_recus); 
BER = erreurs / N;
% Affichage 
disp(['Nombre d''erreurs = ', num2str(erreurs)]); 
disp(['BER = ', num2str(BER)]); 
% Représentation 
figure; 
subplot(3,1,1); 
stairs(bits, 'LineWidth', 1.5); 
grid on; 
title('Bits émis'); 
ylim([-0.5 1.5]); 
subplot(3,1,2); 
stem(symbols, 'filled'); 
grid on; 
title('Symboles BPSK émis'); 
ylim([-2 2]); 
subplot(3,1,3); 
stem(recu, 'filled'); 
grid on; 
title('Signal reçu bruité'); 
ylim([-3 3]);
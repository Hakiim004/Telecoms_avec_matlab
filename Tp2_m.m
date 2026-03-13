%1. Générer 20 bits aléatoires. 
N = 20; 
bits = randi([0,1], 1,N);
%2. Afficher la suite binaire. 
disp("Affichons la suite binaire");
disp(bits);
%3. Représenter le signal sous forme d'escalier. 
figure;
stairs(1:N,bits, 'LineWidth' ,2);
stairs(bits, 'LineWidth', 2); 
grid on; 
xlabel('Indice binaire'); 
ylabel('Valeur'); 
title('Signal binaire original'); 
ylim([-0.5 1.5]);

%ajout un bruit gaussien
 %Ce code ajoute un bruit gaussien de faible amplitude au signal 
 % binaire initial bits en générant un vecteur de bruit aléatoire
 %  bruit avec une distribution normale centrée réduite, puis en le
 %  sommant au signal original pour obtenir un signal bruité signal_bruite.
 %  Ensuite, il affiche sur une même figure le signal binaire propre sous forme d'escalier
 %  et le signal bruité avec des points reliés par des lignes, permettant ainsi de visualiser
 %  clairement l'effet du bruit sur les valeurs discrètes du signal. Les axes sont étiquetés, un titre 
 % est ajouté, une légende distingue les deux signaux, et la plage verticale est limitée pour bien montrer
 %  les variations autour des niveaux 0 et 1.%
bruit = 0.3 * randn(1, N); 
signal_bruite = bits + bruit; 
% Affichage comparatif 
figure; 
stairs(bits, 'LineWidth', 2); 
hold on; 
plot(signal_bruite, 'o-', 'LineWidth', 1.2); 
grid on; 
xlabel('Indice binaire'); 
ylabel('Amplitude'); 
title('Signal binaire avec bruit'); 
legend('Signal original', 'Signal bruité'); 
ylim([-1 2]);

% Augmentons Amplitude du bruit
bruit = 5 * randn(1, N); 
signal_bruite = bits + bruit; 
% Affichage comparatif 
figure; 
stairs(bits, 'LineWidth', 2); 
hold on; 
plot(signal_bruite, 'o-', 'LineWidth', 1.2); 
grid on; 
xlabel('Indice binaire'); 
ylabel('Amplitude'); 
title('Signal binaire avec bruit'); 
legend('Signal original', 'Signal bruité'); 

ylim([-10 10]);

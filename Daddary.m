clc;
clear;
close all;

function [final_prime, iterations, intermediate_steps] = daddary_sequence(n, known_results)
    % Convertir le nombre initial en un nombre symbolique
    n = sym(n);
    intermediate_steps = {n}; % Initialiser la liste des étapes intermédiaires
    iterations = 0; % Initialiser le compteur d'itérations
    
    while true
        % Vérifier si le résultat est déjà connu
        n_str = char(n);
        if isKey(known_results, n_str)
            result = known_results(n_str);
            final_prime = result.final_prime;
            iterations = iterations + result.iterations;
            intermediate_steps = [intermediate_steps, result.intermediate_steps(2:end)];
            break;
        end
        
        % Décomposer en facteurs premiers (en symbolique)
        factors = factor(n);
        
        % Convertir les facteurs en chaînes de caractères
        factorStrings = arrayfun(@char, factors, 'UniformOutput', false);
        
        % Concaténer les chaînes de caractères pour former un nouveau nombre
        concatenatedFactors = str2sym(strjoin(factorStrings, ''));
        
        % Augmenter le compteur d'itérations
        iterations = iterations + 1;
        
        % Ajouter l'étape intermédiaire à la liste
        intermediate_steps{end+1} = concatenatedFactors;
        
        % Vérifier si le nombre obtenu est premier
        if isprime(concatenatedFactors)
            final_prime = concatenatedFactors;
            break;
        else
            n = concatenatedFactors; % Répéter le processus avec le nouveau nombre
        end
    end
        
    % Enregistrer le résultat de chaque étape intermédiaire dans known_results
    for i = 1:length(intermediate_steps)
        step_str = char(intermediate_steps{i});
        if ~isKey(known_results, step_str)
            known_results(step_str) = struct('final_prime', final_prime, 'iterations', iterations - (length(intermediate_steps) - i), 'intermediate_steps', {intermediate_steps(i:end)});
        end
    end
end

function formatted_number = format_number(number)
    % Convertir le nombre en chaîne de caractères
    number_str = char(number);
    % Utiliser sprintf pour ajouter des séparateurs de milliers
    formatted_number = sprintf('%0.0f', str2double(number_str));
    % Ajouter des virgules comme séparateurs de milliers
    formatted_number = insertThousandSeparators(formatted_number);
end

function str_with_spaces = insertThousandSeparators(str)
    % Trouver la position du point décimal
    dot_pos = find(str == '.', 1);
    if isempty(dot_pos)
        dot_pos = length(str) + 1;
    end
    
    % Séparer la partie entière et la partie décimale
    int_part = str(1:dot_pos-1);
    dec_part = str(dot_pos:end);
    
    % Ajouter des espaces comme séparateurs de milliers à la partie entière
    int_part_with_spaces = regexprep(int_part, '\d(?=(?:\d{3})+(?!\d))', '$& ');
    
    % Reconstituer le nombre formaté
    str_with_spaces = [int_part_with_spaces, dec_part];
end



% Initialiser known_results
known_results = containers.Map;

% Initialiser une table pour stocker les résultats
results_table = table('Size', [0, 4], 'VariableTypes', {'double', 'double', 'string', 'double'}, ...
                      'VariableNames', {'n', 'final_prime', 'intermediate_steps', 'iterations'});

% Définir la plage de nombres à calculer
start_num = 2; %>=2
end_num = 100;

for n = start_num:end_num
        [final_prime, iterations, intermediate_steps] = daddary_sequence(n, known_results);
        
        % Convertir les étapes intermédiaires en chaîne de caractères
        intermediate_str = ['['];
        for i = 1:length(intermediate_steps)
            intermediate_str = [intermediate_str, ' ', format_number(intermediate_steps{i}), ','];
        end
        intermediate_str = [intermediate_str(1:end-1), ' ]']; % Enlever la dernière virgule et fermer le crochet
        
        % Afficher les résultats pour chaque nombre de manière concise
        disp(['ξ(' format_number(sym(n)) ') = ' format_number(final_prime) ' ; étapes intermédiaires : ' intermediate_str ' ; itérations : ' num2str(iterations)]);
        
        % Ajouter les résultats à la table
        results_table = [results_table; {n, double(final_prime), intermediate_str, iterations}];
end

% Enregistrer les résultats dans un fichier Excel
writetable(results_table, 'daddary_results.xlsx');






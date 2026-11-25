function selectCircuit2(circuitselectat, R, C, L, fr, E, N)
        
        % Verifică opțiunea selectată și apelează funcția corespunzătoare
switch circuitselectat
      case 1
                % RLC Paralel
                disp('RLC Paralel a fost selectat.');
                close(); % Închide fereastra curentă
                paralel( R, C, L, fr, E, N);% Apelează funcția pentru circuit RLC Paralel 
      case 2
                % RLC Serie
                disp('RLC Serie a fost selectat.');
                close(); % Închide fereastra curentă
                serie( R, C, L, fr, E, N); % Apelează funcția pentru circuit RLC Serie 
end
end
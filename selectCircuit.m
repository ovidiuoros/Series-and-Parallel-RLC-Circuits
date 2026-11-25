function selectCircuit(circuitselectat, R, C, L, fr, E, N)
        
        
switch circuitselectat
      case 1
                % RLC Serie
                disp('RLC Serie a fost selectat.');
                close(); % Închide fereastra curentă
                serie(R, C, L, fr, E, N); % Apelează funcția pentru circuit RLC Serie
      case 2
                % RLC Paralel
                disp('RLC Paralel a fost selectat.');
                close(); % Închide fereastra curentă
                paralel(R, C, L, fr, E, N);% Apelează funcția pentru circuit RLC Paralel 
end
end
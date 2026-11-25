function afisaregraficserie(N, R, L, C, fr, E, select_operatie)

T = 1/fr;
t=0:T/100:T*N;

w=2.*pi.*fr;
u=sqrt(2).*E.*sin(w.*t);

% Impedanta 
wrez = 1./sqrt(L.*C);
frez = wrez./(2.*pi);
fmin=frez./3;
fmax=3.*frez;
f1=linspace(fmin,fmax);
w1 = 2.*pi.*f1;
Xc=1./(w1.*C);
XL=w1.*L;

switch select_operatie
    
    case 1
        impedanta_rezistenta = R * ones(size(t));
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(t, impedanta_rezistenta, 'LineWidth', 2);
        xlabel('Timp (s)');
        ylabel('Rezistenta (Ohmi)');
        title('Impedanța R in functie de timp', 'Color', 'white');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);

    case 2
        fmin=fr./3;
        fmax=3.*fr;
        f1=linspace(fmin,fmax);
        w1 = 2.*pi.*f1;
        impedanta_bobinei = w1.*L;
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(f1, impedanta_bobinei, 'LineWidth', 2);
        xlabel('Frecvență (Hz)');
        ylabel('Inductanță (H)');
        title('Impedanță L în funcție de f', 'Color', 'white');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);

    case 3
        fmin=fr./3;
        fmax=3.*fr;
        f1=linspace(fmin,fmax);
        w1 = 2.*pi.*f1;
        impedanta_condensator = 1./(w1.*C);
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(f1, abs(impedanta_condensator), 'LineWidth', 2);
        xlabel('Frecventă (Hz)');
        ylabel('Capacitate (F)');
        title('Impedanța C în funcție de f', 'Color', 'white');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);

   case 4
        fmin=fr./3;
        fmax=3.*fr;
        f1=linspace(fmin,fmax);
        w1 = 2.*pi.*f1; 
        Z = sqrt(R^.2 + (w1.* L - 1 ./ (w1.* C)).^2);
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        semilogx(f1, abs(Z),'LineWidth', 2);
        xlabel('Frecvență (Hz)');
        ylabel('Impedanță totală (Ohmi)');
        title('Impedanța totală în serie', 'Color', 'white');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white');
       
    case 5

        % wrez = 1./sqrt(L.*C);
        % frez = wrez./(2.*pi);
        fmin=fr./3;
        fmax=3.*fr;

        f=linspace(fmin,fmax);
        w = 2.*pi.*f;

        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);

        zz = R + 1./(i.*w.*C) + i.*w.*L;
        z = abs(zz);
        Xc=1./(w.*C);
        XL=w.*L;

        plot(f,z,'r',f,Xc,'b',f,XL,'g');
        title('Variatia Impedantei echivalente a  Reactantei inductive si a Reactantei capacitive cu frecventa', 'Color', 'white');
        xlabel(['f ',' , frez = ',num2str(ceil(fr)),' [ Hz ]']);
        ylabel('Xc   XL  Zech  [Ohm]', 'Color', 'white');
        grid on;
        legend('Zech','Xc ','XL');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white');


    case 6

       %--------ecuatiile--------
%--------tensiunea de intrare--------
        u=sqrt(2).*E.*sin(w.*t);

%--------curentul prin circuit--------
        y_1=E./(R+(i*w.*L)+(1./(i*w.*C)));
        y_2=abs(y_1);
        df_y=angle(y_1);
        y=sqrt(2).*y_2.*sin(w.*t+df_y);

%--------tensiunea pe rezistenta--------
        ur_1=y_2.*R;
        ur_2=abs(ur_1);
        ur=sqrt(2).*ur_2.*sin(w.*t+df_y);

%--------tensiunea pe condensator--------
        uc_1=y_2.*(1./(i.*w.*C));
        uc_2=abs(uc_1);
        df_uc=angle(uc_1);
        uc=sqrt(2).*uc_2.*sin(w.*t+df_y+df_uc);

%--------tensiunea pe bobina-------------
        ul_1=y_2.*(i.*w.*L);
        ul_2=abs(ul_1);
        df_ul=angle(ul_1);
        ul=sqrt(2).*ul_2.*sin(w.*t+df_y+df_ul);

%--------graficul tensiunilor--------- 
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(t,u,'b',t,ur,'m',t,ul,'c',t,uc,'k');
        grid on;
        title('Tensiunea pe R,L si C', 'Color', 'white');
        xlabel('Timp  [s]');
        ylabel('u,  uR,  uL, uC [V]');
        legend('u=uR+uL+uC','uR - pe R ','uL - pe L','uC - pe C');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);

end

end

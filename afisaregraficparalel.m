function afisaregraficparalel(N, R, L, C, fr, E, select_operatie)

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
        title('Impedanța R in functie de timp','Color', 'white');
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
        Z = 1 ./sqrt( (1 ./ R)^.2 + ( 1 ./ (w1 .* L) - (w1 .* C)).^2);
        plot(f1, abs(Z),'LineWidth', 2);
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        xlabel('Frecvență (Hz)');
        ylabel('Impedanță totală (Ohmi)');
        title('Impedanța totală în paralel', 'Color', 'white');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);
  
    case 5

        % wrez = 1./sqrt(L.*C);
        % fr = wrez./(2.*pi);
        fmin=fr./3;
        fmax=3.*fr;

        f=linspace(fmin,fmax);
        w = 2.*pi.*f;

        a = 1./R + i.*w.*C + 1./(i.*w.*L) ;
        zz = 1./a;
        z = abs(zz);
        Xc=1./(w.*C);
        XL=w.*L;

        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(f,z,'r',f,Xc,'b',f,XL,'g');
        ylabel('Xc   XL  Zech  [Ohm]');
        grid on;
        legend('Zech','Xc ','XL');
        title('Impedanta echivalenta  Reactanta inductiva  Reactanta capacitiva', 'Color', 'white');
        xlabel(['f ',' , fr = ',num2str(ceil(fr)),' [ Hz ]']);
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);

    case 6

        % Admitanta complexa a circuitului
        Y=1./R+1./(i.*w.*L)+i.*w.*C;
% Impedanta complexa a circuitului
        Zp=1./Y;
%--------curentul total complex prin circuit--------
        it_c=E./Zp;

%y_1=E./((i.*w.*L.*R)./(i.*w.*L+R-w.^2.*R.*L.*C));
        it_m=abs(it_c);                        % modulul
        it_df=angle(it_c);                     % defazajul    
        it=sqrt(2).*it_m.*sin(w.*t+it_df);    % variaria in timp

%--------curentul prin rezistenta--------
        ir_m=E./R;
        ir=sqrt(2).*ir_m.*sin(w.*t);

%--------curentul prin condensator--------
        ic_c=E.*i.*w.*C;
        ic_m=abs(ic_c);
        ic_df=angle(ic_c);
        ic=sqrt(2).*ic_m.*sin(w.*t+ic_df);

%--------curentul prin bobina--------
        yl_1=E./(i.*w.*L);
        yl_2=abs(yl_1);
        df_ul=angle(yl_1);
        yl=sqrt(2).*yl_2.*sin(w.*t+df_ul);

%--------graficul curentilor--------
        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(t,it,'m',t,ir,'b',t,yl,'c',t,ic,'k');
        grid on;
        title('Curentii it=iR+iL+iC','Color', 'white');
        xlabel('Timp  [s]');
        ylabel('it,  iR,  iL, iC [A]');
        legend('it','iR ','iL','iC');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);
%-------------------------------------------------------------------
    
     case 7
%--------curentul prin circuit--------
        Zs=R+i*w.*L+1./(i*w.*C);       
        it_c=E./Zs;
        it_m=abs(it_c);
        df_it=angle(it_c);
        it=sqrt(2).*it_m.*sin(w.*t+df_it);

%--------tensiunea pe rezistenta--------
        ur=it.*R;

%--------tensiunea pe condensator--------
        uc_c=it_c.*(1./(i.*w.*C));
        uc_m=abs(uc_c);
        df_uc=angle(uc_c);
        uc=sqrt(2).*uc_m.*sin(w.*t+df_it+df_uc);

%--------tensiunea pe bobina-------------
        uL_c=it_c.*(i.*w.*L);
        uL_m=abs(uL_c);
        df_uL=angle(uL_c);
        uL=sqrt(2).*uL_m.*sin(w.*t+df_it+df_uL);

%--------graficul tensiunilor--------- 

        pozitie = [0.35, 0.25, 0.6, 0.3]; 
        subplot('Position', pozitie);
        plot(t,u,'b',t,ur,'m',t,uL,'c',t,uc,'k');
        grid on;
        title('Tensiunile u=uR+uC+uR', 'Color', 'white');
        xlabel('Timp  [s]');
        ylabel('u,  uR,  uL, uC [V]');
        legend('u','uR','uL','uC');
        set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white', 'FontSize', 10);

end

end

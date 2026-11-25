function afisarecircuitparalel(buton_radio)

if buton_radio == 1
    img1 = imread('circuitparalel.png');
    ax1 = axes('units','normalized','position',[0.13 0.71 0.26 0.27]);
    image(ax1, img1);
    axis(ax1, 'off');

else 
    if buton_radio == 0

    img1 = imread('fundal.png');
    ax1 = axes('units','normalized','position',[0.13 0.71 0.26 0.27]);
    image(ax1, img1);
    axis(ax1, 'off');

    end
    
end
clc;
clear;

%wczytuje dane(country, total cases, total deaths, total recovered,
%population) top 50 world; (27.05.2020)
data = readtable("covid.xlsx");
lengthdata = length(data.num); %ilosc elementow
sz = [lengthdata, 2];
varTypes = {'string', 'double'};
varNames = {'country', 'casesfor1m'};
%tworze tablice pomocnicza(panstwo, liczna zakazen na 1M)
iloscchorych = table('Size',sz,'VariableTypes',varTypes, 'VariableNames', varNames); %liczba zakazen na 1000000/mieszkancow
%licze ilosc zakazen na 1000000/mieszkancow
for i=1:lengthdata
    iloscchorych(i,1) = data.country(i);
    iloscchorych(i,2) = {data.total_cases(i)/ (data.population(i)/1000000)};
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%najmniej zakazen na 1000000/mieszkancow(top 15 swiat)
iloscchorych = sortrows(iloscchorych, {'casesfor1m'}); %sortuje tablice wedlug wskaznika zakazen
for i=1:15
    xtemp(i) = iloscchorych.casesfor1m(i);
    ytemp(i) = iloscchorych.country(i);
end
wykres1 = figure;
%rysuje wykres dla panstw z najmniejsza ilosciu zakazen na 1000000/mieszkancow(top 15 swiat)
bar(xtemp,'FaceColor',[0.4940 0.1840 0.5560],'EdgeColor',[0.9290 0.6940 0.1250],'LineWidth',1.5);
ylabel("Zakażeń na 1M", "FontSize", 12, "Color", 'k'); %podpisuje os Y
xlabel("Panstwa","FontSize", 12, "Color", 'k');%podpisuje os X
title("Top 15 Swiata z najmniejszym wskaznikiem zakazen na 1M mieszkancow", "FontSize", 12, "Color", 'k'); %ustawiam tytul wykresu
set(gca, 'XTick', 1:15, 'XTickLabel', ytemp,'XTickLabelRotation',90, 'Color', [0.6 0.93 1]); %ustawiam punkty na osi X oraz backgroud kolor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%najwiecej zakazen na 1000000/mieszkancow(top 15 swiat)
for i=(lengthdata-14):lengthdata
    xtemp(lengthdata-i+1) = iloscchorych.casesfor1m(i);
    ytemp(lengthdata-i+1) = iloscchorych.country(i);
end
wykres2 = figure;
%rysuje wykres dla panstw z najwieksza ilosciu zakazen na 1000000/mieszkancow(top 15 swiat)
bar(xtemp,'FaceColor',[0.4940 0.1840 0.5560],'EdgeColor',[0.9290 0.6940 0.1250],'LineWidth',1.5);
ylabel("Zakazen na 1M", "FontSize", 12, "Color", 'k');
xlabel("Panstwa","FontSize", 12, "Color", 'k');
title("Top 15 Swiata z najwiekszym wskaznikiem zakazen na 1M mieszkancow", "FontSize", 12, "Color", 'k');
set(gca, 'XTick', 1:15, 'XTickLabel', ytemp,'XTickLabelRotation',90, 'Color', [0.6 0.93 1]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% top 20 Europa
%wczytuje dane dla Europy(country, total cases, total deaths, total recovered,
%population) (28.05.2020)
dataEurope = readtable("europe.xlsx"); %wczytuje dane
lengthEurope = length(dataEurope.num); %ilosc elementow
szE = [lengthEurope, 2];
%dodatkowa tablica dla Europy
iloscchorychE = table('Size',szE,'VariableTypes',varTypes, 'VariableNames', varNames);
%licze ilosc zakazen na 1000000/mieszkancow
for i=1:lengthEurope
    iloscchorychE(i,1) = dataEurope.country(i);
    iloscchorychE(i,2) = {dataEurope.total_cases(i)/ (dataEurope.population(i)/1000000)};
end
iloscchorychE = sortrows(iloscchorychE, {'casesfor1m'}); %sortuje tablice wedlug wskaznika zakazen

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%najmniej zakazen na 1000000/mieszkancow(top 5 Europy)
wykres3 = figure;
%tworze wykres dla top 5 panstw z najmniejsza ilosciu zakazen na 1000000/mieszkancow
yE = [iloscchorychE.country(1:5)]; %zmienna pomocnicza, ktora przechpwuje nazwe panstw
for i=1:5
    x(i)=iloscchorychE.casesfor1m(i); %zmienna ktora przechowuje wskaznik zakazen
    bar(i,x(i),'FaceColor', [.99-(i*0.1) .0+(i*0.02) .0+(i*0.02)],'EdgeColor',[1 0.4 0.2],'LineWidth',1.5);%rysuje kazdy slupek osobno aby nadac
                                                                                                           % mu inny kolor
    hold on;
end
ylabel("Zakazen na 1M", "FontSize", 12, "Color", 'k');
xlabel("Panstwa","FontSize", 12, "Color", 'k');
title("Top 5 Europy z najmniejszym wskaznikiem zakazen na 1M mieszkancow", "FontSize", 12, "Color", 'k');
set(gca, 'XTick', 1:5, 'XTickLabel', yE,'XTickLabelRotation',90, 'Color', [0.81 1 0.99]);
figure(wykres3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%najwiecej zakazen na 1000000/mieszkancow(top 5 Europy)
wykres4 = figure;
%tworze wykres dla top 5 panstw z najwieksza ilosciu zakazen na 1000000/mieszkancow
yE = [iloscchorychE.country(lengthEurope-4:lengthEurope)];
for i=1:5
    x(i)=iloscchorychE.casesfor1m(lengthEurope+1-i);
    yE(i) = iloscchorychE.country(lengthEurope+1-i);
    bar(i,x(i),'FaceColor', [.49+(i*0.1) .1-(i*0.02) .1-(i*0.02)],'EdgeColor',[1 0.5 0.0],'LineWidth',1.5);%rysuje kazdy slupek osobno aby nadac
                                                                                                           %mu inny kolor
    hold on;
end
ylabel("Zakazen na 1M", "FontSize", 12, "Color", 'k');
xlabel("Panstwa","FontSize", 12, "Color", 'k');
title("Top 5 Europy z najwiekszym wskaznikiem zakazen na 1M mieszkancow", "FontSize", 12, "Color", 'k');
set(gca, 'XTick', 1:5, 'XTickLabel', yE,'XTickLabelRotation',90, 'Color', [0.81 1 0.99]);
figure(wykres4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%total cases world(stanem na 26.05.2020)
%tworze animacje ktora pokazuje wzrost ilosci przypadkow od 22.01 do 26.05
dataTotal = readtable("total_cases_world.xlsx"); %wczytuje dane
wykres5 = figure;
filename = 'total_cases.gif';
set(gcf, 'Position', get(0, 'Screensize'));
drawLine = animatedline('Color','r','LineWidth',5);
set(gca,'XLim',[0 27],'YLim',[0 6*10^6]); %ustawiam statyczne pole
grid on; %siatka
xlabel('Data',"FontSize", 12, "Color", 'k');
ylabel('Liczba zakażeń',"FontSize", 12, "Color", 'k');
title('Ilosc zakazen w Swiecie(22.01 - 26.05)','FontSize', 12, 'Color', 'k');
set(gca, 'XTick', 1:length(dataTotal.num), 'XTickLabel',dataTotal.date,'XTickLabelRotation',90, 'Color', [0.81 1 0.99]);
%petla dla rysowania gif
for i=1:length(dataTotal.num)
    addpoints(drawLine,dataTotal.num(i),dataTotal.total_cases(i));
    drawnow;
    frame = getframe(wykres5);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % zapis do gif
    if i == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.05);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tworze wykres na mapie swiatu, ktory pokazuje wskaznik zakazen na 1M
%mieszkancow na kazdym kontynencie
wykres6 = figure;
continents = readtable('continents.xlsx'); %wczytuje dane(continent, latitude, longitude, total cases, population)
lat = continents.latitude; %zapisuje latitude do zmiennej
lon = continents.longitude; %zapisuje  longitude do zmiennej
for i=1:length(continents.num)
    continentsfor1m(i) = continents.total_cases(i)/(continents.population(i)/1000000); %wyliczam wskaznik zakazen na
    %1M mieszkancow dla kazdego kontynentu
end
gb = geobubble(lat,lon,continentsfor1m,'Title', 'Liczba zakazen na kontynentach swiata na 1M mieszkancow','SizeLegendTitle', 'Zakazen na 1M', ...
    'BubbleColorList', [1, 0, 0]); %rysuje wykres za pomoca geobubble
geobasemap colorterrain; %wczytuje bazowa mape
geolimits(gb,[-90 90],[-180 180]);
set(gcf, 'Position', get(0, 'Screensize')); %wykres na "full screen"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%srednia temperatura
wykres7 = figure;
load('T_file.mat'); %wczytuje dane
T_file = double(T_file) ;
A=T_file;
lat=A(:,2); 
lon=A(:,1); 
z=A(:,3);
lon0 =(-90) ; lon1 = (90) ; % ustawiam limity dla latitude 
lat0 = (0) ; lat1 = (360) ; % ustawiam limity dla longitude
TempX = linspace(lon0,lon1,100) ;
TempY = linspace(lat0,lat1,100) ; 
[X,Y] = meshgrid(TempX,TempY) ;
F=scatteredInterpolant(lon,lat,z); %interpolacja funkcji
Z = F(X,Y);
worldmap('world');      % inicjalizacja mapy
c = load('coast.mat'); % laduje linie brzegowe
plotm(c.lat,c.long);    % rysuje linie brzegowe
geoshow(X,Y,Z,'DisplayType', 'surface');%wyswietlam wektorowe elementy geograficzne
title('Srednia roczna temperatura','FontSize', 12, 'Color', 'k'); %ustawiam tytul
colormap 'Hot'; %color dla mapy
c = colorbar;
c.Label.String = "Temperatura"; %podpis skali
set(gcf, 'Position', get(0, 'Screensize'));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wykres8 = figure;
%rysuje HeatMap na ktorej sa top panst na kazdym kontynencie z najwieksza
%ilosciu zakazen
S = shaperead('ne_10m_admin_0_countries.shp'); 
numRegions = length(S); %ilosc panstw
topCountry = readtable('top_country_cases'); %wczytuje dane(code panstwa, panstwa)
mapshow(S); %rysuje mape 
% za pomoca petli koloruje to panstwo ktore potrzebuje, na kazdym
% kontynencie uzywam innego koloru
for i=1:length(topCountry.num)
    mapshow(S(topCountry.code(i)),'FaceColor',[.71 .4 .4]);
    if(i>=6 && i<=8)
        mapshow(S(topCountry.code(i)),'FaceColor',[.2 .8 .05]);
    elseif(i>=9 && i<=13)
        mapshow(S(topCountry.code(i)),'FaceColor',[.2 .15 .8]);
    elseif(i>=14 && i<=16)
        mapshow(S(topCountry.code(i)),'FaceColor',[.3 .0 .2]);
    elseif(i==17 || i==18)
        mapshow(S(topCountry.code(i)),'FaceColor',[.65 1 1]);
    elseif(i==19 || i==20)
        mapshow(S(topCountry.code(i)),'FaceColor',[.08 .2 .0]);
    end
end
title("Kraje z największą ilością zakażeń(Kontynenty)", "FontSize", 12, "Color", 'k');
set(gcf, 'Position', get(0, 'Screensize'));
set(gca,'Color',[0.81 1 0.99]); %background mapy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%wyliczam korelacje pomiedzy srednim wiekiem a liczba zgonow (x - sredni
%wiek, y - liczba zgonow)
korTable = readtable('korelacja.xlsx'); %wczytuje dane (country, average age, total deaths)
averageAge=str2double(korTable.average_age); %konwertuje string do double(nie wiem dla czego excel zapisal liczby jako string:( )
%zmienne pomocnicze potrzebne dla korelacji Pearsona
xy = 0;
xkwadrat = 0;
ykwadrat = 0;
sumaX = 0;
sumaY = 0;
n = length(korTable.num);
%wyliczam wspolczyniki korelacji
for i=1:n
    xy = xy + averageAge(i) * korTable.total_deaths(i);
    sumaX = sumaX + averageAge(i);
    sumaY = sumaY + korTable.total_deaths(i);
    xkwadrat = xkwadrat + averageAge(i)*averageAge(i);
    ykwadrat = ykwadrat + korTable.total_deaths(i)*korTable.total_deaths(i);
end
pierwiastek = sqrt((n*xkwadrat - (sumaX*sumaX))*(n*ykwadrat - (sumaY*sumaY)));
korelacja = (n*xy - sumaX*sumaY)/pierwiastek %wartosc korelacji
% korelacja > 0, wartosci jednej cechy rosna, to wartosci drugiej cechy
% rowniez rosna

%licze parametry liniowej funkcji regresji y = a + bx
b = (n*xy - sumaX*sumaY)/(n*xkwadrat - (sumaX*sumaX)) %licze wspolczynnik b
ysredni = sumaY/n;
xsredni = sumaX/n;
a = ysredni - b*xsredni %licze wspolczynnik a
for i=1:n
    funkcja(i)=a+b*averageAge(i);
end
%rysuje funkcje regresji
wykres9 = figure;
set(gca, 'XTick', 1:n, 'XTickLabel',averageAge);
plot(averageAge,funkcja,'r','LineWidth',1.5);
ylabel("Liczba zgonow", "FontSize", 12, "Color", 'k');
xlabel("Sredni wiek","FontSize", 12, "Color", 'k');
title("Regresja liniowa", "FontSize", 12, "Color", 'k');
set(gca,'Color',[0.81 1 0.99]);


%koniec projektu :)



















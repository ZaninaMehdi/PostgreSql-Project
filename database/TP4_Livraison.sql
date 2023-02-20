create table if not exists Client (
    numeroclient SERIAL not NULL,
    nomclient VARCHAR(35) not NULL, 
    prenomclient varchar(35) not NULL, 
    adressecourrielclient VARCHAR(50) not null,
	rueclient VARCHAR(50) not null,
	villeclient VARCHAR(35) not null,
	codepostalclient CHAR(6) not null,
	PRIMARY KEY (numeroclient)
);

create table if not exists Telephone (
    numerotelephone VARCHAR(15) not null CHECK (numerotelephone not like '%[^0-9]%'),
    numeroclient integer not null,
	PRIMARY KEY (numerotelephone, numeroclient),
	FOREIGN KEY (numeroclient) REFERENCES Client(numeroclient) on update cascade on delete cascade
);

create table if not exists Fournisseur (
    numerofournisseur SERIAL not null,
    nomfournisseur VARCHAR(35),
    adressefournisseur VARCHAR(100) not null,
	PRIMARY KEY (numerofournisseur)
);

create table if not exists Planrepas (
	numeroplan SERIAL not null,
	numerofournisseur integer not null,
    categorie VARCHAR(35) not null,
    frequence integer not null check (frequence > 0),
    nbrpersonnes integer not null check (nbrpersonnes > 0),
    nbrcalories integer not null check (nbrcalories > 0),
    prix NUMERIC(9, 2) not null check (prix > 0),
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numerofournisseur) REFERENCES Fournisseur(numerofournisseur) on update cascade on delete cascade
);

create table if not exists Abonner (
	duree integer not null,
	numeroplan integer not NULL,
	numeroclient integer not null,
	PRIMARY KEY (numeroplan, numeroclient),
	FOREIGN KEY (numeroclient) REFERENCES Client(numeroclient) on update cascade on delete cascade,
	FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) on update cascade on delete cascade
);

create table if not exists Famille (
	numeroplan integer not NULL,
	PRIMARY kEY (numeroplan),
    FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) on update cascade on delete cascade
);

create table if not exists Vegetarien (
    typederepas VARCHAR(35) not null,
	numeroplan integer not NULL,
	PRIMARY KEY (numeroplan),
    FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) on update cascade on delete cascade
);

create table if not exists Pescaterien (
    numeroplan integer not NULL, 
    typepoisson VARCHAR(35) not null,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) on update cascade on delete cascade
);

create table if not exists Rapide (
	numeroplan integer not NULL,
    tempsdepreparation TIME(0) not null,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan) REFERENCES Famille(numeroplan) on update cascade on delete cascade
);

create table if not exists Facile (
	numeroplan integer not NULL,
    nbringredients integer not null,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan) REFERENCES Famille(numeroplan) on update cascade on delete cascade
);

create table if not exists Kitrepas (
	numeroplan integer not NULL,
    numerokitrepas SERIAL not null, 
    description VARCHAR(250) not null,
	PRIMARY KEY (numerokitrepas),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) on update cascade on delete cascade
);

create table if not exists Image (
    numeroimage SERIAL not null,
    donnees VARCHAR(1000) not null, 
	numerokitrepas integer not null,
	PRIMARY KEY (numeroimage),
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas(numerokitrepas) on update cascade on delete cascade
);

create table if not exists Ingredient (
    numeroingredient SERIAL not null,
    nomingredient VARCHAR(75) not null,
    paysingredient VARCHAR(35) not null,
	PRIMARY KEY (numeroingredient)
);

create table if not exists Contenir (
	numeroingredient integer not null,
	numerokitrepas integer not null,
	PRIMARY KEY (numerokitrepas, numeroingredient),
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas(numerokitrepas) on update cascade on delete cascade,
	FOREIGN KEY (numeroingredient) REFERENCES Ingredient(numeroingredient) on update cascade on delete cascade
);

-- Nous avons modifie etape par rapport au schema relationnel pour tenir compte de sa propriete cyclique.
create table if not exists etape (
	numeroetape integer not null check (numeroetape > 0),
	numerosousetape integer not null check (numerosousetape > 0),
	numerokitrepas integer not null check (numerokitrepas > 0),
	descriptionetape VARCHAR(500) not null,
    dureeetape TIME(0) not null,
	PRIMARY KEY (numerokitrepas, numeroetape, numerosousetape),
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas(numerokitrepas) on update cascade on delete cascade
);


insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('michel', 'tremblay', 'michel.tremblay@gmail.com', 'rue gilford', 'montréal', 'h2i1n4');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('nicolas', 'leblanc', 'nicolas.leblanc@gmail.com', 'rue rachel', 'montréal', 'h2t1k1');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('mathieu', 'grenier', 'mathieu.grenier@gmail.com', 'boulevard saint-laurent', 'montréal', 'h2s2m9');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('manon', 'hébert', 'manon.hébert@gmail.com', 'avenue christophe-colomb', 'montréal', 'h2j3m7');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('andréanne', 'lafayette', 'andréanne.lafayette@gmail.com', 'boulevard thimmens', 'montréal', 'h3s2f6');


insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'michel' and nomclient = 'tremblay')), '15142344657');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'nicolas' and nomclient = 'leblanc')), '15143533578');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'mathieu' and nomclient = 'grenier')), '15144656699');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'manon' and nomclient = 'hébert')), '15143384532');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'andréanne' and nomclient = 'lafayette')), '15142344657');


insert into fournisseur (nomfournisseur, adressefournisseur) 
VALUES ('QC Transport', 'montréal');

insert into fournisseur (nomfournisseur, adressefournisseur) 
VALUES ('AB Transport', 'montréal');

insert into fournisseur (nomfournisseur, adressefournisseur) 
VALUES ('Benjamin', 'montréal');

insert into fournisseur (adressefournisseur) 
VALUES ('montréal');

insert into fournisseur (adressefournisseur) 
VALUES ('laval');


insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('cétogène', 3, 1500, 4, 84.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('cétogène', 2, 1000, 2, 54.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'AB Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('cétogène', 1, 500, 2, 24.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'AB Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('canadien', 3, 1400, 3, 39.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'AB Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('canadien', 3, 1400, 3, 21.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('canadien', 1, 400, 2, 29.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('keto', 3, 1400, 3, 39.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('keto', 2, 1100, 4, 33.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('mexicain', 2, 1100, 4, 33.99, (select numerofournisseur from fournisseur where (adressefournisseur = 'montréal' and nomfournisseur is null)));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('mexicain', 3, 1230, 3, 37.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('delicioso', 1, 10000, 10, 12500.99, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));


insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 1500 and prix = 84.99)));

insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 1000 and prix = 54.99)));

insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'keto' and nbrcalories = 1400 and prix = 39.99)));

insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'keto' and nbrcalories = 1100 and prix = 33.99)));


insert into Vegetarien (numeroplan, typederepas)
VALUES ((select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 500 and prix = 24.99)), 'trash');

insert into Vegetarien (numeroplan, typederepas)
VALUES ((select numeroplan from planrepas where (categorie = 'canadien' and nbrcalories = 1400 and prix = 39.99)), 'ordinaire');


insert into Pescaterien (numeroplan, typepoisson)
VALUES ((select numeroplan from planrepas where (categorie = 'canadien' and nbrcalories = 1400 and prix = 21.99)), 'saumon');

insert into Pescaterien (numeroplan, typepoisson)
VALUES ((select numeroplan from planrepas where (categorie = 'canadien' and nbrcalories = 400 and prix = 29.99)), 'truite');


insert into rapide (numeroplan, tempsdepreparation)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 1500 and prix = 84.99))), '00:12:30');

insert into rapide (numeroplan, tempsdepreparation)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 1000 and prix = 54.99))), '00:11:00');


insert into facile (numeroplan, nbringredients)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'keto' and nbrcalories = 1400 and prix = 39.99))), 5);

insert into facile (numeroplan, nbringredients)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'keto' and nbrcalories = 1100 and prix = 33.99))), 6);


insert into Kitrepas (numeroplan, description)
VALUES ((select numeroplan from planrepas where (categorie = 'mexicain' and nbrcalories = 1100 and prix = 33.99)), 'Un mijoté de pleins de bonnes choses');

insert into Kitrepas (numeroplan, description)
VALUES ((select numeroplan from planrepas where (categorie = 'mexicain' and nbrcalories = 1230 and prix = 37.99)), 'Un chili beaucoup trop épicé, mais délicieux');


insert into Image (donnees, numerokitrepas)
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
(select numerokitrepas from Kitrepas where description = 'Un mijoté de pleins de bonnes choses'));

insert into Image (donnees, numerokitrepas)
VALUES ('Iaculis eu non diam phasellus vestibulum lorem. Sed felis eget velit aliquet sagittis id consectetur purus. Leo integer malesuada nunc vel risus commodo.',
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));


insert into ingredient (nomingredient, paysingredient) 
VALUES ('tomate', 'canada');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('boeuf haché', 'canada');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('ail', 'portugal');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('oignon', 'canada');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('jalapeno', 'mexique');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('courgette', 'canada');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('carotte', 'canada');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('haricots rouges', 'liban');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('aubergine', 'chine');


insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'tomate' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'boeuf haché' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'ail' and paysingredient = 'portugal')), 
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'oignon' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'haricots rouges' and paysingredient = 'liban')), 
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'jalapeno' and paysingredient = 'mexique')), 
(select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'tomate' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un mijoté de pleins de bonnes choses'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'oignon' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un mijoté de pleins de bonnes choses'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'aubergine' and paysingredient = 'chine')), 
(select numerokitrepas from Kitrepas where description = 'Un mijoté de pleins de bonnes choses'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'carotte' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un mijoté de pleins de bonnes choses'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'courgette' and paysingredient = 'canada')), 
(select numerokitrepas from Kitrepas where description = 'Un mijoté de pleins de bonnes choses'));


insert into etape (numeroetape, numerosousetape, numerokitrepas, descriptionetape, dureeetape)
VALUES (1, 1, (select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'), 'Hacher les oignons, l''ail, tomates et le jalapeno.', '00:10:45');

insert into etape (numeroetape, numerosousetape, numerokitrepas, descriptionetape, dureeetape)
VALUES (2, 1, (select numerokitrepas from Kitrepas where description = 'Un chili beaucoup trop épicé, mais délicieux'), 'Faire revenir les oignons et le boeuf.', '00:5:30');


insert into Abonner (duree, numeroplan, numeroclient)
VALUES (235, 
(select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 1500 and prix = 84.99)), 
(select numeroclient from client where (prenomclient = 'michel' and nomclient = 'tremblay')));

insert into Abonner (duree, numeroplan, numeroclient)
VALUES (127, 
(select numeroplan from planrepas where (categorie = 'keto' and nbrcalories = 1100 and prix = 33.99)), 
(select numeroclient from client where (prenomclient = 'nicolas' and nomclient = 'leblanc')));

insert into Abonner (duree, numeroplan, numeroclient)
VALUES (104, 
(select numeroplan from planrepas where (categorie = 'mexicain' and nbrcalories = 1230 and prix = 37.99)), 
(select numeroclient from client where (prenomclient = 'manon' and nomclient = 'hébert')));

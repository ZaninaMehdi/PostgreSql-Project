-- 4.1
select numeroclient, nomclient 
from client 
where client.numeroclient in 
(select numeroclient from abonner where abonner.numeroplan in 
 (select numeroplan from planrepas where prix between 20.00 and 40.00)); 


-- 4.2
select numeroplan from planrepas
except
select numeroplan from planrepas
where numerofournisseur in 
(select numerofournisseur from fournisseur where nomfournisseur = 'QC Transport');  


-- 4.3
select numeroplan from famille
where numeroplan in
(select numeroplan from planrepas
where categorie = 'cétogène');


-- 4.4
select count(*) as "nombre de fournisseurs sans nom" from fournisseur 
where nomfournisseur is null;


-- 4.5
select nomfournisseur
from planrepas inner join fournisseur 
on planrepas.numerofournisseur = fournisseur.numerofournisseur
where prix > (select max(prix)
from planrepas inner join fournisseur
on planrepas.numerofournisseur = fournisseur.numerofournisseur
where nomfournisseur = 'AB Transport')
group by nomfournisseur;


-- 4.6
select nomfournisseur, adressefournisseur, sum(prix) as "total des prix"
from planrepas inner join fournisseur 
on planrepas.numerofournisseur = fournisseur.numerofournisseur
group by fournisseur.numerofournisseur
order by sum(prix) desc limit 2;


-- 4.7
select count(*) as "nbr de kit repas jamais réservés chez les fournisseurs" 
from kitrepas 
where numerokitrepas not in 
(select numerokitrepas 
 from abonner inner join kitrepas 
 on abonner.numeroplan = kitrepas.numeroplan);

    -- OU --

-- Nous n'étions pas sûre de ce que vous vouliez, donc nous avons cette solution aussi.
-- Ceux-ci sont les kits repas qui ne font pas partie d'un plan repas 
-- donc ils ont pas de fournisseur et les kit repas qui font partie des plan repas
-- qui nont pas de fournisseur (s'il est possible d'avoir un numérofournisseur null).

select count(*) as "nbr de kit repas jamais réservés chez les fournisseurs"  from kitrepas
where numeroplan in (select numeroplan 
                    from planrepas 
                    where numerofournisseur is null)
and numerokitrepas in (select numeroplan
                      from kitrepas
                      where numeroplan is null);

-- 4.8
select numeroclient, nomclient, prenomclient from client
where left(prenomclient, 1) not in ('a', 'e', 'i', 'o', 'u', 'y', 'A', 'E', 'I', 'O', 'U', 'Y')
and villeclient = (select adressefournisseur from fournisseur 
where nomfournisseur = 'Benjamin')
order by nomclient asc;


-- 4.9
select paysingredient, count(*) as "nbringrédients par pays" 
from ingredient 
where left(right(paysingredient, 3), 1) <> 'g'
group by paysingredient
order by paysingredient desc;


-- 4.10
CREATE VIEW V_fournisseur(V_categorie, V_adresse, V_tot) as
SELEct p.categorie, f.adressefournisseur, SUM(p.prix) from planrepas p, fournisseur f
where  p.numerofournisseur = f.numerofournisseur 
and p.categorie LIKE '%e%' and p.categorie LIKE '%o__'
and p.numerofournisseur in (select numerofournisseur from planrepas
group by numerofournisseur
having SUM(prix) > 12500)
group by  p.categorie, f.adressefournisseur
order by p.categorie, SUM(p.prix) DESC;
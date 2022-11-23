'Mission 1'

CREATE DATABASE finance

CREATE TABLE Trader 
( nom VARCHAR(100) PRIMARY KEY, classe_actif VARCHAR(100), anneeExperience INT, nomEquipe VARCHAR(100) );

CREATE TABLE Equipe 
( nom VARCHAR(100) PRIMARY KEY, style VARCHAR(255), chef VARCHAR(100) );

CREATE TABLE Transaction 
( nom VARCHAR(100) PRIMARY KEY, nomEquipe VARCHAR(255), date DATE, lieu VARCHAR(100), prix INT);

ALTER TABLE trader 
ADD FOREIGN KEY (nomEquipe) 
REFERENCES equipe (nom);

ALTER TABLE transaction 
ADD FOREIGN KEY (nomEquipe) 
REFERENCES equipe (nom);

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe1', 'market making', 'leonardo');

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe2', 'arbitrage', 'michaelgelo');

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe3', 'trading de volatilite', 'raphael');

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe4', 'trading haute frequence', 'donatello');

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe5', 'arbitrage statistique', 'Smith');

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe6', 'arbitrage statistique', 'Smith');

INSERT INTO equipe (nom, style, chef) 
VALUES ('equipe7', 'strategie fond de fond', 'Ray')

INSERT INTO trader (nom, classe_actif, anneeExperience, nomEquipe) 
VALUES ('Yannick', 'fixed income', 10, 'equipe1');

INSERT INTO trader (nom, classe_actif, anneeExperience, nomEquipe) 
VALUES ('Patrick', 'action', 10, 'equipe1');    

INSERT INTO trader (nom, classe_actif, anneeExperience, nomEquipe) 
VALUES ('Cedrik', 'commodities', 10, 'equipe1'); 

INSERT INTO trader (nom, classe_actif, anneeExperience, nomEquipe) 
VALUES ('Jordan', 'change', 2, 'equipe2');

INSERT INTO trader (nom, classe_actif, anneeExperience, nomEquipe) 
VALUES ('Gaelle', 'exotic', 4, 'equipe3');

INSERT INTO trader (nom, classe_actif, anneeExperience, nomEquipe) 
VALUES ('Georges', 'CDS', 20, 'equipe6');

'Mission 2'
'Niveau facile'

'mf01'   
SELECT nom, classe_actif 
FROM trader 
WHERE anneeExperience < 5;

'mf02'
SELECT classe_actif 
FROM `trader` 
WHERE nomEquipe = 'equipe1';

'mf03'
SELECT * 
FROM `trader` 
WHERE classe_actif = 'commodities';

'mf04'
SELECT classe_actif 
FROM `trader` 
WHERE anneeExperience > 20;

'mf05'
SELECT nom 
FROM `trader` 
WHERE anneeExperience BETWEEN 5 AND 10;

'mf06'
SELECT classe_actif 
FROM `trader` 
WHERE `classe_actif` LIKE 'ch%';

'mf07'
SELECT nom 
FROM `equipe` 
WHERE style = 'arbitrage statistique';

'mf08'
SELECT nom 
FROM `equipe` 
WHERE chef = 'Smith';

'mf09'
SELECT * 
FROM `transaction` 
ORDER BY nom ASC;

'mf10' 
SELECT * 
FROM `transaction` 
WHERE date = '2019-04-20' AND lieu = 'HONG KONG';

'mf11'
SELECT lieu 
FROM `transaction` 
WHERE prix > 150;

'mf12'
SELECT * 
FROM `transaction` 
WHERE lieu = 'PARIS' AND prix < 50;

'mf13'
SELECT lieu 
FROM `transaction` 
WHERE date LIKE '2014%';

'Niveau moyen'
'Multi-tables avec jointure'

'mmtj01'
SELECT trader.nom, trader.classe_actif 
FROM trader 
LEFT JOIN equipe ON trader.nomEquipe = equipe.nom 
WHERE trader.anneeExperience > 3 AND equipe.style = 'arbitrage statistique' 
ORDER BY trader.nom;

'mmtj02'
SELECT transaction.lieu 
FROM transaction 
LEFT JOIN equipe ON transaction.nomEquipe = equipe.nom 
WHERE transaction.prix < 20 AND equipe.chef = 'Smith' 
ORDER BY transaction.lieu;

'mmtj03'
SELECT COUNT(lieu) 
FROM transaction 
LEFT JOIN equipe ON transaction.nomEquipe = equipe.nom 
WHERE transaction.date LIKE '2021%' AND equipe.style = 'market making';

'mmtj04'
SELECT AVG(prix),transaction.lieu 
FROM transaction 
LEFT JOIN equipe ON transaction.nomEquipe = equipe.nom 
WHERE equipe.style = 'market making' 
GROUP BY transaction.lieu;

'mmtj05'
SELECT trader.classe_actif 
FROM trader 
LEFT JOIN equipe ON trader.nomEquipe = equipe.nom 
LEFT JOIN transaction ON trader.nomEquipe = transaction.nomEquipe 
WHERE equipe.chef = 'Smith' AND date = '2016-01-01';

'mmtj21'
SELECT AVG(anneeExperience),equipe.style 
FROM trader 
LEFT JOIN equipe ON trader.nomEquipe = equipe.nom 
GROUP BY equipe.style;

'Niveau moyen'
'Multi-tables sans jointure'


'mmts01'
SELECT nom, classe_actif 
FROM trader 
WHERE trader.anneeExperience > 3 AND nomEquipe IN ( SELECT nom FROM `equipe` WHERE style = 'arbitrage statistique' ) 
ORDER BY trader.nom ASC;

'mmts02'
SELECT lieu 
FROM transaction 
WHERE prix < 20 AND nomEquipe IN ( SELECT nom FROM `equipe` WHERE chef = 'Smith' ) 
ORDER BY lieu ASC;

'mmts03'
SELECT COUNT(lieu) 
FROM transaction 
WHERE date LIKE '2015%' AND nomEquipe IN (SELECT nom FROM equipe WHERE style = 'trading de volatilite');

'mmts04'
SELECT AVG(prix) 
FROM transaction 
WHERE nomEquipe IN (SELECT nom FROM equipe WHERE style = 'market making') 
GROUP BY lieu;

'mmts05'
SELECT classe_actif 
FROM trader 
WHERE nomEquipe IN (SELECT nom FROM equipe WHERE chef = 'Smith' AND nom IN (SELECT nomEquipe FROM transaction WHERE date = '2016-01-01'));
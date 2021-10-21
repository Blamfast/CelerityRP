USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_banker','Banque',1),
	('bank_savings','Livret Bleu',0)
;

INSERT INTO `jobs` (name, label) VALUES
	('banker','Banquier')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('banker',0,'advisor','Stagiaire',1500,'{}','{}'),
	('banker',1,'banker','Garde Du Corps',1750,'{}','{}'),
	('banker',2,'business_banker',"Banquier",2000,'{}','{}'),
	('banker',3,'trader','Trader',2250,'{}','{}'),
	('banker',4,'boss','Patron',3000,'{}','{}')
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_banker', 'Banque', 1),
('society_banker_reserve', 'Banque (réserve)', 1);

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_banker', 'Banque', 1)
;

INSERT INTO `items` (`name`, `label`) VALUES  
    ('bil', 'Sac de billet')
;

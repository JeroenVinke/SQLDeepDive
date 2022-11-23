-- QUERY 1
-- Vraag: Hoeveel records heeft SQL Server doorzocht om tot het resultaat (1000 rows) te komen?
-- Vraag: Hoeveel pages (8kb blokken) is van het databestand uitlezen?
SELECT [Id], [FirstName]
FROM [dbo].[User] 
WHERE [FirstName] = 'Zoya'

-- QUERY 2
-- Vraag: Hoeveel records heeft SQL Server doorzocht om tot het resultaat (1 rows) te komen?
-- Vraag: Hoeveel pages (8kb blokken) is van het databestand uitlezen?
SELECT [Id], [FirstName]
FROM [dbo].[User] 
WHERE [Id] = 990025

-- QUERY 3
-- Vraag: Wat doet SQL Server allemaal om tot het resultaat (1 row) te komen?
-- Vraag: Is dit snel of traag?
SELECT TOP 1 [Id], [FirstName]
FROM [dbo].[User] 
ORDER BY [FirstName] ASC

-- QUERY 4
-- Vraag: Wat doet SQL Server allemaal om tot het resultaat te komen?
-- Vraag: Wat is de duurste operator in dit queryplan?
-- Vraag: Hoe zou je dit kunnen versnellen?
SELECT [FirstName], [LastName]
FROM [dbo].[User]
INNER JOIN [dbo].[UserAddress] ON  [dbo].[UserAddress].[UserId] = [dbo].[User].[Id]
WHERE [dbo].[UserAddress].[StreetName] = 'Main Street 15'
OPTION (LOOP JOIN)

-- INDEX AANMAKEN
CREATE INDEX [IX_Naam] ON [dbo].[User] ([FirstName])

-- QUERY 5
-- Vraag: is de query met de nieuwe index sneller geworden dan zonder de index?
SELECT [Id], [FirstName]
FROM [dbo].[User] 
WHERE [FirstName] = 'Zoya'

SELECT [Id], [FirstName]
FROM [dbo].[User_Original] 
WHERE [FirstName] = 'Zoya'

-- QUERY 6
-- Vraag: Wat doet SQL Server allemaal om tot het resultaat van de eerste query te komen?
-- Vraag: Heeft de nieuwe index deze query veel sneller gemaakt?
-- Vraag: Hoe zou je de index kunnen aapassen zodat de eerste query geen key lookup meer hoeft te doen?
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [FirstName] = 'Zoya'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User_Original] 
WHERE [FirstName] = 'Zoya'

-- QUERY 7
-- Hierbij moet je het queryplan van twee queries met elkaar vergelijken
-- De eerste query laat SQL Server zelf besluiten hoe hij de data op moet halen
-- De tweede query forceert SQL Server de nieuwe index op FirstName te gebruiken
-- Vraag: Waarom gebruikt SQL Server bij de eerste query niet de index op FirstName?
-- Tip: Kijk hoeveel logical reads elke operator heeft gedaan
-- Welk queryplan doet de minste logical reads?
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [FirstName] <> 'Zoya'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] WITH(INDEX([IX_Naam]))
WHERE [FirstName] <> 'Zoya'


-- INDEX AANPASSEN
DROP INDEX [IX_Naam] ON [dbo].[User]
CREATE INDEX [IX_Naam] ON [dbo].[User] ([FirstName], [LastName])

-- QUERY 8
-- Vraag: Voor welke queries gebruikt SQL Server de nieuwe index efficiënt en voor welke niet?
-- Vraag: Waarom wel/niet?
-- Vraag: Welke queries zijn snel en welke zijn traag?
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [LastName] = 'Vesper'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [LastName] = 'Vesper' AND [FirstName] = 'SQL Server Deepdive'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [FirstName] = 'SQL Server Deepdive'
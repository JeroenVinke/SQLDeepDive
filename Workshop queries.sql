-- QUERY 1
-- Vraag: Hoeveel records heeft SQL Server doorzocht om tot het resultaat (1000 rows) te komen?
-- Vraag: Hoeveel pages (8kb blokken) is van het databestand uitlezen?
SELECT [Id], [FirstName]
FROM [dbo].[User] 
WHERE [FirstName] = 'Zoya'

-- QUERY 2
-- Vraag: Hoeveel records heeft SQL Server doorzocht om tot het resultaat (1 rows) te komen?
-- Vraag: Is de Clustered Index SEEK van Query 2 beter dan de Clustered Index SCAN van Query 1?
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
-- Vraag: Waarom is deze operator zo duur?
-- Vraag: Welke index zou je kunnen maken om deze query te versnellen?
SELECT [FirstName], [LastName]
FROM [dbo].[User]
INNER JOIN [dbo].[UserAddress] ON  [dbo].[UserAddress].[UserId] = [dbo].[User].[Id]
WHERE [dbo].[UserAddress].[StreetName] = 'mulberry 134'
OPTION (LOOP JOIN)

-- TUSSENSTAP: INDEX AANMAKEN
CREATE INDEX [IX_Naam] ON [dbo].[User] ([FirstName])

-- QUERY 5
-- De tabel [dbo].[User] heeft nu een index op FirstName
-- De tabel [dbo].[User_Original] heeft deze index niet
-- Vraag: Vergelijk het queryplan van de onderste twee queries. Heeft de nieuwe index geholpen?
SELECT [Id], [FirstName]
FROM [dbo].[User] 
WHERE [FirstName] = 'Zoya'

SELECT [Id], [FirstName]
FROM [dbo].[User_Original] 
WHERE [FirstName] = 'Zoya'

-- QUERY 6
-- Vraag: Hoeveel logical reads doet de eerste query?
-- Vraag: Waarom doet SQL Server een Key lookup?
-- Tip: Kijk bij de Output List van de properties van de Key Lookup. Welke kolom geeft de key lookup terug?
-- Vraag: Hoe zou je de index kunnen aapassen zodat de eerste query geen key lookup meer hoeft te doen?
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [FirstName] = 'Zoya'


-- QUERY 7
-- LET OP: onderstaande queries kunnen 10 sec duren
-- De eerste query laat SQL Server zelf besluiten hoe hij de data op moet halen
-- De tweede query forceert SQL Server om de nieuwe index op FirstName te gebruiken
-- Vraag: Waarom gebruikt SQL Server bij de eerste query niet de index op FirstName?
-- Tip: Kijk hoeveel logical reads elke operator heeft gedaan in beide queryplannen
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE [FirstName] <> 'Zoya'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] WITH(INDEX([IX_Naam]))
WHERE [FirstName] <> 'Zoya'


-- TUSSENSTAP: INDEX AANPASSEN
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
-- QUERY 1
SELECT Id, FirstName 
FROM [dbo].[User] 
WHERE FirstName = 'Zoya'

-- QUERY 2
SELECT * 
FROM [dbo].[User] 
WHERE Id = 990025

-- QUERY 3
SELECT TOP 1 * 
FROM [dbo].[User] 
ORDER BY FirstName ASC

-- QUERY 4
SELECT FirstName, LastName 
FROM [dbo].[User]
INNER JOIN [dbo].[UserAddress] ON  [dbo].[UserAddress].[UserId] = [dbo].[User].[Id]
WHERE [dbo].[UserAddress].[StreetName] = 'Main Street 15'
OPTION (LOOP JOIN)

-- INDEX AANMAKEN
CREATE INDEX Naam ON [dbo].[User] ([FirstName])

-- QUERY 5
SELECT Id, FirstName 
FROM [dbo].[User] 
WHERE FirstName = 'Zoya'

SELECT Id, FirstName 
FROM [dbo].[User_Original] 
WHERE FirstName = 'Zoya'

-- QUERY 6
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE FirstName <> 'Zoya'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User_Original] 
WHERE FirstName <> 'Zoya'

-- QUERY 7
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE FirstName = 'Zoya'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User_Original] 
WHERE FirstName = 'Zoya'

-- INDEX AANPASSEN
DROP INDEX Naam ON [dbo].[User]
CREATE INDEX Naam ON [dbo].[User] ([FirstName]) INCLUDE ([LastName])

-- QUERY 8
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE FirstName = 'Zoya'

SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User_Original] 
WHERE FirstName = 'Zoya'

-- INDEX AANPASSEN
DROP INDEX Naam ON [dbo].[User]
CREATE INDEX Naam ON [dbo].[User] ([FirstName], [LastName])

-- QUERY 9
SELECT [Id], [FirstName], [LastName] 
FROM [dbo].[User] 
WHERE LastName = 'Vesper'
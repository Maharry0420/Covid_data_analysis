-- checking all the songs from the data -
SELECT * 
FROM My_Top_100_apple_music.dbo.['My Apple Playlist$']

-- List all the songs that does have a feature artist --
select * 
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where [Feature Artist] not Like '%None%'

-- List all the songs that The Weeknd feature or is on the song --
Select * 
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where [Feature Artist] Like '%Weeknd' or [Artist name] Like '%Weeknd%' 

-- List all the songs that Future feature or is on the song --
Select * 
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where [Feature Artist] Like '%Future' or [Artist name] Like '%Future%' 

-- List all the songs that has been on the list for multiple years
Select [Track name],[Feature Artist],[Artist name],Album, Count(*) as Multiples
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Group By [Track name],[Feature Artist],[Artist name],Album
Having Count(*) > 1
Order by Multiples DESC

-- List all the artist (as the artist not feature) with at least 10 songs.
Select [Artist name], Count(*) as Multiples
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Group By [Artist name]
Having Count(*) >= 10
Order by Multiples DESC

-- List all the artist (as the feature not the artist) with at least 3 songs.
Select [Feature Artist], Count(*) as Multiples
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where [Feature Artist] not Like '%None%'
Group By [Feature Artist]
Having Count(*) >= 3
Order by Multiples DESC

-- List all the singles songs that was not attached to an album
Select *
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where Album Like '%Single%'

-- List all the songs that are not duplicates
Select DISTINCT [Track name], [Feature Artist], [Artist name], Album 
FROM My_Top_100_apple_music.dbo.['My Apple Playlist$']


-- List all the songs where the song has the same name but different artist 
Select subquery.[Track name], COUNT (*) as Multiples
FROM
(Select DISTINCT [Track name], [Feature Artist], [Artist name] 
FROM My_Top_100_apple_music.dbo.['My Apple Playlist$']) as subquery
Group by [Track name]
Having count(*) > 1
Order by Multiples desc

-- List all the songs that has a number in the track name
Select DISTINCT [Track name], [Artist name], [Feature Artist]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where [Track name] Like '%[0-9]%'

-- List all the songs that Youngboy Never Broke Again has featured AND all his songs
Select DISTINCT [Track name]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Where [Artist name] Like '%Youngboy Never Broke Again%' OR [Feature Artist] Like '%Youngboy Never Broke Again%' 
order by [Track name] 		  

-- Count the times the artist who has songs on the list AND featured on songs (multiple songs inc.)

select 
    e.Artist,  
	(select count(*) from My_Top_100_apple_music.dbo.['My Apple Playlist$'] c where c.[Feature Artist]=e.Artist) as Feature_Count,
	(select count(*) from My_Top_100_apple_music.dbo.['My Apple Playlist$'] c where c.[Artist name]=e.Artist) as Artist_count
from (
    select Artist=[Feature Artist] from My_Top_100_apple_music.dbo.['My Apple Playlist$'] where [Feature Artist] NOT LIKE 'None'
    union
    select Artist=[Artist name] from My_Top_100_apple_music.dbo.['My Apple Playlist$']
) e

-- Figure out which album has the most entries NO SINGLES

Select Album, Count(Album) as Album_Count
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE Album NOT LIKE '%Single%'
Group By Album
Order by Count(Album) desc

-- Find all the songs that came from a deluxe Album
Select Album, Count(Album) as Album_Count
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE Album  LIKE '%Deluxe%'
Group By Album
Order by Count(Album) desc

-- Find the most artist who had the most songs from 2019
Select [Artist name],COUNT([Artist name]) AS Artist_count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2019
Group by [Artist name], [Year in Top 100]
Order by Artist_count desc

-- Find the most artist who had the most feature songs from 2019
Select [Feature Artist],COUNT([Feature Artist]) AS Feature_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2019 AND [Feature Artist] NOT LIKE 'None'
Group by [Feature Artist], [Year in Top 100]
Order by Feature_Count desc

-- Find the most artist who had the most songs from 2020
Select [Artist name],COUNT([Artist name]) AS Artist_count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2020
Group by [Artist name], [Year in Top 100]
Order by Artist_count desc

-- Find the most artist who had the most feature songs from 2020
Select [Feature Artist],COUNT([Feature Artist]) AS Feature_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2020 AND [Feature Artist] NOT LIKE 'None'
Group by [Feature Artist], [Year in Top 100]
Order by Feature_Count desc

-- Find the most artist who had the most songs from 2021
Select [Artist name],COUNT([Artist name]) AS Artist_count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2021
Group by [Artist name], [Year in Top 100]
Order by Artist_count desc

-- Find the most artist who had the most feature songs from 2021
Select [Feature Artist],COUNT([Feature Artist]) AS Feature_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2021 AND [Feature Artist] NOT LIKE 'None'
Group by [Feature Artist], [Year in Top 100]
Order by Feature_Count desc

-- Find the most artist who had the most songs from 2022
Select [Artist name],COUNT([Artist name]) AS Artist_count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2022
Group by [Artist name], [Year in Top 100]
Order by Artist_count desc

-- Find the most artist who had the most feature songs from 2022
Select [Feature Artist],COUNT([Feature Artist]) AS Feature_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE [Year in Top 100] = 2022 AND [Feature Artist] NOT LIKE 'None'
Group by [Feature Artist], [Year in Top 100]
Order by Feature_Count desc

-- Find the most artist in all of the 4 years
Select top 21 [Artist name],COUNT([Artist name]) AS Artist_count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
Group by [Artist name], [Year in Top 100]
Order by Artist_count desc

-- Find the most feature artist in all of the 4 years
Select top 24[Feature Artist],COUNT([Feature Artist]) AS Feature_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
--WHERE [Feature Artist] NOT LIKE 'None'
Group by [Feature Artist], [Year in Top 100]
Order by Feature_Count desc

-- Find all the albums that was in 2019 (no singles & more than 1)
Select Album,COUNT(Album) AS Album_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE Album NOT LIKE '%Single%' AND [Year in Top 100] = 2019
Group by Album, [Year in Top 100]
Having COUNT(Album) > 1
Order by Album_Count desc

-- Find all the albums that was in 2020 (no singles & more than 1)
Select Album,COUNT(Album) AS Album_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE Album NOT LIKE '%Single%' AND [Year in Top 100] = 2020
Group by Album, [Year in Top 100]
Having COUNT(Album) > 1
Order by Album_Count desc

-- Find all the albums that was in 2021 (no singles & more than 1)
Select Album,COUNT(Album) AS Album_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE Album NOT LIKE '%Single%' AND [Year in Top 100] = 2021
Group by Album, [Year in Top 100]
Having COUNT(Album) > 1
Order by Album_Count desc

-- Find all the albums that was in 2022 (no singles & more than 1)
Select Album,COUNT(Album) AS Album_Count, [Year in Top 100]
From My_Top_100_apple_music.dbo.['My Apple Playlist$']
WHERE Album NOT LIKE '%Single%' AND [Year in Top 100] = 2022
Group by Album, [Year in Top 100]
Having COUNT(Album) > 1
Order by Album_Count desc

-- Change all the feature artist where None is now Null
Update My_Top_100_apple_music.dbo.['My Apple Playlist$'] set [Feature Artist] = NULL where [Feature Artist] = 'None'
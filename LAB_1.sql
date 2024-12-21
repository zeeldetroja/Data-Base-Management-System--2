--Part – A
--1. Retrieve a unique genre of songs.
SELECT DISTINCT GENRE
FROM Songs;

--2. Find top 2 albums released before 2010.
SELECT TOP 2 ALBUM_TITLE
FROM ALBUMS 
WHERE RELEASE_YEAR < 2010

--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
INSERT INTO SONGS VALUES (1245, 'Zaroor', 2.55, 'Feel good', 1005)

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’
UPDATE SONGS 
SET GENRE = 'HAPPY'
WHERE SONG_TITLE = 'Zaroor'

--5. Delete an Artist ‘Ed Sheeran’
DELETE 
FROM ARTISTS
WHERE ARTIST_NAME = 'Ed Sheeran'

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
ALTER TABLE SONGS 
ADD RATINGS DECIMAL(3,2)

--7. Retrieve songs whose title starts with 'S'.
SELECT * 
FROM SONGS
WHERE SONG_TITLE LIKE 'S%'

--8. Retrieve all songs whose title contains 'Everybody'.
SELECT * 
FROM SONGS
WHERE SONG_TITLE LIKE '%EVERYBODY%'

--9. Display Artist Name in Uppercase.
SELECT UPPER(ARTIST_NAME) FROM ARTISTS

--10. Find the Square Root of the Duration of a Song ‘Good Luck’
SELECT SQRT(DURATION) 
FROM SONGS
WHERE SONG_TITLE = 'GOOD LUCK'

--11. Find Current Date.
SELECT GETDATE() AS 'CURRENT_DATE' 

--12. Find the number of albums for each artist.
SELECT ARTIST_NAME , COUNT(ALBUM_TITLE) AS 'NO_OF_ALBUM'
FROM ALBUMS JOIN ARTISTS
ON ALBUMS.ARTIST_ID = ARTISTS.ARTIST_ID
GROUP BY ARTIST_NAME

--13. Retrieve the Album_id which has more than 5 songs in it.
SELECT ALBUM_ID 
FROM SONGS 
GROUP BY ALBUM_ID
HAVING COUNT(SONG_TITLE) > 5

--14. Retrieve all songs from the album 'Album1'. (using Subquery)
SELECT * 
FROM SONGS 
WHERE ALBUM_ID IN (SELECT ALBUM_ID FROM ALBUMS WHERE ALBUM_TITLE = 'ALBUM1')

--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
SELECT ALBUM_TITLE 
FROM ALBUMS
WHERE ARTIST_ID IN (SELECT ARTIST_ID FROM ARTISTS WHERE ARTIST_NAME = 'Aparshakti Khurana')

--16. Retrieve all the song titles with its album title.
Select s.Song_title , a.Album_Title from songs as s join albums as a
on s.album_id = a.album_id

--17. Find all the songs which are released in 2020.
Select s.Song_title , a.Album_Title from songs as s join albums as a
on s.album_id = a.album_id
where a.Release_year = 2020

--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
Create view Fav_Songs 
as 
select * from songs 
where Song_id between 101 and 105

select * from Fav_Songs

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
Update Fav_Songs
Set Song_Title = 'Jannat'
where Song_id = 101

--20. Find all artists who have released an album in 2020.
Select * 
from Albums as al join Artists as ar
on al.Artist_id = ar.Artist_id
where al.Release_year = 2020

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
Select *
from Albums as al join Songs as s 
on al.Album_id = s.Album_id
join Artists as ar 
on al.Artist_id = ar.Artist_id
where ar.Artist_Name = 'Shreya Ghoshal'
order by s.Duration


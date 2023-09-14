
---------------------------------------------------------------------------------------------------------------------------------------
VIEWS
--1.Create a view that show Popular Movies

Create or alter view Popular_Movies (Title , ReleasedDate , Popularity) As 
Select m.Title ,m.ReleasedDate , MAX(Popularity) as Popular_Movies
from Movie m , REL_MovieEvaluation r join Evaluation e 
on e.SerialNumber = r.Sno
GROUP BY m.Title ,m.ReleasedDate

select * from Popular_Movies;


--2. Create a view that displays all movies with a rating greater than 8.0,
--ordered by their rating in descending order.
go
Create or alter view Good_Rate as 
Select m.Title ,m.ReleasedDate  , e.E_imdbRating 
from Movie m , REL_MovieEvaluation r join Evaluation e 
on e.SerialNumber = r.Sno
WHERE E_imdbRating > 8.0
--ORDER BY E_imdbRating  DESC;

select * from Good_Rate
ORDER BY E_imdbRating  DESC;

--3  Create a view that shows the number of movies in each genre.
Create or alter view Genre_Count as 
Select m.genre , Count(imdbID) as number_of_movies
from Movie m 
Group by m.genre ;

Select * from Genre_Count

--4 Create a view that lists movies released in the last year,
--ordered by their release date in descending order
Create or alter view Recnte_Released as 
select m.ReleasedDate , m.Title
from Movie m 
where ReleasedDate < getdate()

select * from Recnte_Released
Order by ReleasedDate DEsc;

-- create view that display movie name , gross , budget, pc name
create or alter view vmovie
as 
select distinct Title ,ProductionCompany, Gross,Budget
from Movie , PC 
where PC_ID=ProductionCoID
select * from vmovie

-- create view that show top(5) evaluation of movies 
create view vevaluations 
as
select top(5) mid , Metascore, E_imdbRating,E_imdbVotes,Popularity
from Evaluation, REL_MovieEvaluation
where SerialNumber=sno 
select * from vevaluations
------------------------------------------------------------------------------------------------------------------------------------------
--3 FUNCTIONS

update  Awards set Oscar = 0 where Oscar IS NULL
update  Awards set Nominations = 0 where Nominations IS NULL
update  Awards set Other = 0 where Other IS NULL
update  Awards set Wins = 0 where Wins IS NULL

-- calculate total awards for each movie
create or alter function Cal_total()
returns @t1 table (TotalPrices int , MovieName nvarchar(100), ProductionCo nvarchar(50))
as
 begin
  INSERT @t1 
  select  sum( cast(a.Oscar as int)+cast(a.Nominations as int)+cast(a.Other as int)+cast(a.Wins as int)) as total,m.Title, c.ProductionCompany 
  from Movie m, Awards a, REL_MovieAwards rel, PC c
  where m.imdbID = rel.MovieID and a.AwardsTID= rel.TID and m.PC_ID= c.ProductionCoID --and m.imdbID = 'tt0101414'
  group by c.ProductionCompany, m.Title
  Order by m.Title
    RETURN
 end
 select * from Cal_total ()

-- Creating a SQL Function to Retrieve the Top 10 Movies Based on IMDb Ratings
CREATE OR ALTER FUNCTION Get_Top10_Movies ()
RETURNS @T TABLE (imdbID NVARCHAR(50), Title VARCHAR(250), E_imdbRating float )
AS 
BEGIN 
    INSERT INTO @T 
    SELECT TOP (10) m.imdbID AS Movie_ID, m.Title, e.E_imdbRating
    FROM Movie m
    JOIN REL_MovieEvaluation r ON m.imdbID = r.mID
    JOIN Evaluation e ON r.Sno = e.SerialNumber  
    ORDER BY e.E_imdbRating DESC;

    RETURN;
END;
SELECT * FROM dbo.Get_Top10_Movies();


-- Creating a SQL Function to Identify Movies with the Most Oscar
create or alter function Movie_With_TheMost_Oscar ()
returns @T2 table (imdbID nvarchar(50) , Title Varchar (200) , Oscar tinyint)
as 
	Begin
		Insert into @T2 
		select Top (5)  m.imdbID AS Movie_ID, m.Title, a.Oscar 
		From Movie m 
		join REL_MovieAwards r on m.imdbID = r.MovieID
		join Awards a on a.AwardsTID =r.TID
		Order By a.Oscar DESC ;
		return
	end
SELECT * FROM dbo.Movie_With_TheMost_Oscar();

-- Creating a SQL function to spotlight the top five films in the database,
--balancing their notable gross earnings with production budgets
create or alter function Get_Top10_HighestGrossing_WithBudget_Movies ()
returns @T3 Table (imdbID nvarchar(50) , Title Varchar (200) , Gross nvarchar(50) , Budget INT )
as 
	Begin
		Insert Into @T3
		select Top (10)m.imdbID AS Movie_ID, m.Title, m.Gross , m.Budget
		from Movie m 
		Order By m.Gross Desc , m.budget Desc 
		return;
	end
Select * from dbo.Get_Top10_HighestGrossing_WithBudget_Movies ()

-------Multi_Table_Statement.
create or alter function Get_Top5_HighestGrossing_Movies_With_Details ()
returns  @T TABLE ( imdbID NVARCHAR(50), Title Varchar(255), Gross Nvarchar(255),
Budget INT, DirectorName Nvarchar(255), ActorName Nvarchar(255) )
AS 
BEGIN 
    INSERT INTO @T
    SELECT TOP (5) m.imdbID, m.Title, m.Gross, m.Budget, d.DirectorName, a.ActorName     
   FROM Movie m
    JOIN Directors d ON m.Director_ID = d.DirectorID
    JOIN REL_ActorDirector r ON d.DirectorID = r.Director_id
    JOIN Actor a ON r.Actor_id = a.ActorID
    ORDER BY m.Gross DESC, m.Budget DESC;
    RETURN;
END;
select * from Get_Top5_HighestGrossing_Movies_With_Details ()

--Get_Top5_HighestGrossing_Movies_With_Details2
CREATE OR ALTER FUNCTION Get_Top5_HighestGrossing_Movies_With_Details2()
returns  @T TABLE ( imdbID NVARCHAR(50), Title Varchar(255), Gross Nvarchar(255),
Budget INT, DirectorName Nvarchar(255), ActorName Nvarchar(255) )
AS 
BEGIN 
    INSERT INTO @T
    SELECT DISTINCT TOP (5)
        m.imdbID,
        m.Title,
        m.Gross,
        m.Budget,
        d.DirectorName,
        a.ActorName
    FROM Movie m
    JOIN Directors d ON m.Director_ID = d.DirectorID
    OUTER APPLY (
        SELECT TOP 1 a1.ActorName 
        FROM Actor a1
        JOIN REL_ActorDirector r ON a1.ActorID = r.Actor_id
        WHERE r.Director_id = d.DirectorID
    ) a
    ORDER BY m.Gross DESC, m.Budget DESC;

    RETURN;
END;
select * from Get_Top5_HighestGrossing_Movies_With_Details2()

--1 scalar function 
--Write a function that take castid and retrun actor1 id  
create function getcast(@id nvarchar(50) )
returns nvarchar(50)
begin 
declare @actor nvarchar(50)
select @actor = actor1 from Cast 
where @id = CastID
return @actor
end
select dbo.getcast('C_n10')


--2- scalar function 
--write afunction that take movie title and return gross
create function getgross(@name nvarchar(100))
returns nvarchar(50)
begin
declare @gross nvarchar(50)
select @gross=gross from Movie
where @name= Title
return @gross 
end 
select dbo.getgross('All Quiet on the Western Front')


--3--inline function 
--write a function that take movie id and awards,title 
create function getawards(@mid nvarchar(50))
returns table
as
return 
(
select movieid ,tid,oscar,nominations,wins,other,title 
from Awards,REL_MovieAwards,Movie
where MovieID=@mid and AwardsTID=TID and MovieID=imdbID
)
select * from getawards('tt0025316')


--4-
--inline function
-- write afunction that take movie id  and return writer name , production name , actors , movie title 
create function getmovie(@mid nvarchar(50))
returns table 
as 
return 
(
select title , WriterName,ProductionCompany,DirectorName,Actor1,Actor2,Actor3,Actor4 , Cast_ID
from Movie , Writers,PC,Directors,Cast
where imdbID=@mid and CastID=Cast_ID and DirectorID=Director_ID and PC_ID=ProductionCoID and Writer_ID=WriterID
)
select * from getmovie('tt0032551')


--5--
-- write a function that take actor id and return actor name , movie title , movie id 
create function getactors(@id nvarchar(50))
returns table 
as 
return
(
select distinct ActorName , title ,  m_id
from  movie , Actor , REL_ActorMovie
where Actorid=@id and imdbID=m_id 
)
select * from getactors('A_n77')


--6
-- create function that take writer id and return w.name , title , genre , country 
create function getwriter(@id tinyint)
returns table
as return 
(
select WriterName ,title , genre , country
from movie , Writers
where Writer_ID=@id and Writer_ID=WriterID
)
select * from getwriter(23)

 --------------------------------------------------------------------------------------------------------------------------------------
 --DENSE RANKING FUNCTIONS
 --dense rank order by rating 
select * from (
select *,DENSE_RANK()over(order by E_imdbRating desc) as DR
from Evaluation) as Rating
where DR<=8
-----------------------------------------------------------------------------------------------------------------------------------------
--triggers-- 

--trigger for checking budget greater than zero 
--that it is firing and display "Budget must be greater than 0" 
--beginning trigger one 
CREATE  or alter TRIGGER check_buget
ON MOVIE
INSTEAD OF INSERT
AS
BEGIN
 IF EXISTS (
   SELECT 1
   FROM inserted i
   WHERE i.Budget <= 0 )
BEGIN
  select ('Budget must be greater than 0');
END;
ELSE
    BEGIN
 INSERT INTO Movie
         (imdbID,ReleasedDate,Language,
         Title,Description,Runtime,Year,Country,Genre, Cast_ID,DVD, Website,Director_ID, PC_ID, Writer_ID,Gross,Budget)
SELECT imdbID,
                ReleasedDate,
                Language,
                Title,
                Description,
                Runtime,
                Year,
                Country,
                Genre,
                Cast_ID,
                DVD,
                Website,
                Director_ID,
                PC_ID,
                Writer_ID,
                Gross,
                Budget
 FROM inserted;
SELECT * FROM INSERTED;
END; 
END;
--ending trigger one 

-- then running the test case for budget 0 for trigger one 
INSERT INTO Movie
    (imdbID,
    Language,
    ReleasedDate,
    Title,
    Description,
    Runtime,
    Year,
    Country,
    Genre,
    Cast_ID,
    DVD,
    Website,
    Director_ID,
    PC_ID,
    Writer_ID,
    Gross,
    Budget)
VALUES
    ('0y896d',
    'English', 
    '2021-02-06', 
    'The gwaeier', 
    'The Tramp cares for an abandoned child, but events put that relationship in jeopardy.', -- Description
    '68 min', 
    1921,
    'USA', 
    'Comedy, Drama, Family', 
    'C_n218', 
    '2004-03-02', 
    NULL, 
    25, 
    66, 
    23, 
    '$2.38M',
    0 
);
-- end of test cases for trigger one 


--beginning trigger two 
--trigger to prevent deletion and truncation from tables --
create or alter trigger delet_prevention 
on DBO.MOVIE
INSTEAD OF DELETE  
AS
BEGIN 
 SELECT (' SORRY , THE DELETION FROM THIS TABLE NOT ALLAWED ') Attention;
END
DELETE FROM MOVIE 

--beginning trigger three< this scope create table first and then fire triggers to end
-- trigger to creation updating_table to store detailes
-- for updating such username,date,new_title,old_title--
drop table updating_table
CREATE TABLE updating_table
(
UserName varchar(100),
Modified_Date date ,
new_title varchar(100),
old_title varchar(100)
)


create or alter trigger updating_history
on movie 
after update 
as
begin 
declare @inserting_id varchar(50);
declare @DATE_INSERTED DATE ;
declare @new_title varchar(100);
declare @old_title varchar(100);
select @inserting_id = (select imdbID FROM INSERTED); 
select @DATE_INSERTED = GETDATE();
select @new_title = (select Title FROM INSERTED); 
select @old_title = (select Title FROM deleted); 
insert into updating_table 
values (@inserting_id,@DATE_INSERTED,@new_title,@old_title);
select * from  updating_table;
end
go
update movie set Title= 'the march' 
where imdbID ='tt0012349';

--beginning trigger five 
--prevent drop from database --
CREATE OR ALTER TRIGGER prevent_drop
ON DATABASE
FOR drop_TABLE 
AS 
BEGIN
SELECT (' SORRY , THE DELETION FROM THIS data base NOT ALLAWED ')
END;
go
create table im (i int)
drop table im
--DISABLE TRIGGER prevent ON database
-----------------------------------------------------------------------------------------------------------------------------------------
  --indexing--

-- implemantation for unique indexes 
CREATE unique INDEX index_title ON Movie (Title);
DROP INDEX index_title ON Movie;

-- implemantation for nonclustered indexes 
CREATE nonclustered INDEX index_Cast_ID ON Movie (Cast_ID);
DROP INDEX index_Cast_ID ON Movie;

-- implemantation for nonclustered indexes 
CREATE nonclustered INDEX index_ReviewTitle ON [MovieOverview] (ReviewTitle);
DROP INDEX index_Cast_ID ON Movie;

-----------------------------------------------------------------------------------------------------------------------------------------
--CURSORS
declare c2 cursor
for 
   select m.Title, m.Budget,p.ProductionCompany
   from  Movie m , PC p
   where m.PC_ID = p.ProductionCoID
   update Movie 
   set Budget= Budget+ 50000
   where Budget < 50000
declare @name nvarchar(100), @b int ,@n nvarchar(30)
open c2
fetch c2 into  @name, @b, @n
while @@FETCH_STATUS=0
begin 
   select  @name, @b , @n
   fetch c2 into @name, @b , @n
end
close c2

select  @name, @b , @n
deallocate c2
--For a given list of movies, use a cursor to iterate over each movie and
--retrieve the total number of awards and nominations it received, as listed in the IMDb database
 DECLARE c1 CURSOR
For 
SELECT  
    SUM(a.Nominations) , SUM(a.Oscar) ,  m.imdbID,  m.Title
FROM  Movie m 
JOIN  REL_MovieAwards r ON m.imdbID = r.MovieID
JOIN  Awards a ON a.AwardsTID = r.TID
GROUP BY   m.imdbID, m.Title;

DECLARE @Nominations INT, @Oscars INT, @Movie_ID NVARCHAR(50), @Movie_Title NVARCHAR(255);
Open c1
Fetch c1 into  @Nominations, @Oscars ,@Movie_ID , @Movie_Title
while @@FETCH_STATUS=0
begin
Select @Nominations as Nominations , @Oscars as Oscar ,@Movie_ID  as Movie_ID , @Movie_Title as Title
Fetch c1 into  @Nominations, @Oscars ,@Movie_ID , @Movie_Title
End;
Close c1;
DEALLOCATE c1;



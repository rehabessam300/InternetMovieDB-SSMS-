select * from Actor 
select * from Awards
select * from Cast
select * from Directors
select * from Evaluation
select * from Movie
select * from MovieOverview
select * from PC
select * from Writers
select * from REL_Actor_Cast
select * from REL_ActorDirector
select * from REL_ActorMovie
select * from REL_MovieAwards
select * from REL_MovieEvaluation
select * from REL_ProductionCampany_Director
select * from REL_ProductionCampany_Writer
----------------------------------------------------------------------------------------------------------------
--1
select a.ActorName from Cast c ,Actor a , REL_Actor_Cast R
where a.ActorID = R.Actorid and c.CastID ='C_n1' and R.Castid = c.CastID
--2
select DISTINCT DirectorName, ActorName from Cast c ,Actor a , Directors D, REL_ActorDirector REL
where a.ActorID = REL.Actor_id and D.DirectorID = 224 and D.DirectorID = REL.Director_id
--3
select DISTINCT m.Title ,a.ActorName, a.ActorID from Movie m, Actor a, REL_ActorMovie rel
where a.ActorID = rel.actor_id and m.imdbID = 'tt0012349' and rel.m_id = m.imdbID 
--4
select DISTINCT a.ActorName, a.ActorID from Movie m, Actor a, REL_ActorMovie rel , REL_Actor_Cast r , Cast c
where a.ActorID = rel.actor_id and rel.m_id = m.imdbID and m.Title = 'Shutter Island' 
--5
SELECT a.ActorName
FROM Actor a
JOIN REL_ActorMovie am1 ON a.ActorID = am1.actor_id
JOIN REL_ActorMovie  am2 ON a.ActorID = am2.actor_id
JOIN Movie m1 ON am1.m_id = m1.imdbID
JOIN Movie m2 ON am2.m_id = m2.imdbID
WHERE m1.Title = 'Shutter Island' AND m2.Title = 'Inception';
--6
SELECT actor.ActorName
FROM Actor
JOIN REL_Actor_Cast rel ON Actor.ActorID = rel.Actorid
JOIN Movie ON REL_ActorMovie.m_id = Movie.imdbID
WHERE Movie.Title = 'Shutter Island' AND Actor.ActorID IN (
  SELECT Actor.ActorID
  FROM Actor
  JOIN REL_Actor_Cast rel ON Actor.ActorID = rel.Actorid
  JOIN Movie ON REL_ActorMovie.m_id = Movie.imdbID
  WHERE Movie.Title = 'Inception'
)
--7
 select m.Cast_ID, m.Title, a.ActorName from Movie m, Actor a, REL_ActorMovie rel
 where a.ActorID = 'A_n102' and m.imdbID = rel.m_id and rel.actor_id = a.ActorID
--8
select distinct d.DirectorName, w.WriterName, c.ProductionCompany from Directors d, Writers w, PC c, REL_ProductionCampany_Director P, REL_ProductionCampany_Writer R
where  c.ProductionCoID = 1 and R.PC_no = c.ProductionCoID and R.Wid = w.WriterID and p.PCno = c.ProductionCoID and p.Did = d.DirectorID
--9
select a.AwardsTID from Movie m, REL_MovieAwards rel , Awards a
where m.imdbID ='tt0101414' and rel.MovieID = m.imdbID and rel.TID = a.AwardsTID 


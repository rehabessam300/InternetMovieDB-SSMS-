------------------------------------------------------------------------------------------------------------------------
--PROC

/*  PROCEDURE Insert_Delete_Update_Writer*/
CREATE or Alter  PROCEDURE Insert_Delete_Update_Writer(@WriterID  INTEGER, @WriterName    VARCHAR(50),@StatementType NVARCHAR(20) = '')
AS
begin
 IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Writers (WriterID,WriterName)
    VALUES ( @WriterID, @WriterName)
 end
  IF @StatementType = 'Update'
        BEGIN
            UPDATE Writers
            SET    WriterName = @WriterName
            WHERE  WriterID = @WriterID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM Writers
            WHERE  WriterID = @WriterID
        END
END

Insert_Delete_Update_Writer 204 ,'kareem','insert'
select * from Writers
go

/*  PROCEDURE Insert_Delete_Update_Actor   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_Actor(@ActorID  VARCHAR(50),@ActorName    VARCHAR(50),@StatementType NVARCHAR(20) = ''	)
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Actor
                (ActorName,
                 ActorID
				 )
                  
    VALUES     ( @ActorName,
                 @ActorID)
	end
	 IF @StatementType = 'Update'
        BEGIN
            UPDATE Actor
            SET    ActorName = @ActorName
            WHERE  ActorID = @ActorID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM Actor
            WHERE  ActorID = @ActorID
        END
END

Insert_Delete_Update_Actor 0 ,'kareeeem','insert'
select * from Actor
go

/*  PROCEDURE Insert_Delete_Update_Director */
CREATE or Alter  PROCEDURE Insert_Delete_Update_Director(@DirectorID  tinyint,@DirectorName    VARCHAR(50), @StatementType NVARCHAR(20) = '')
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Directors
                (DirectorName,
                 DirectorID
				 )
                  
    VALUES     ( @DirectorName,
                 @DirectorID)
	end
	  IF @StatementType = 'Update'
        BEGIN
            UPDATE Directors
            SET    DirectorName = @DirectorName
            WHERE  DirectorID = @DirectorID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN 
            DELETE FROM Directors 
            WHERE  DirectorID = @DirectorID
        END
END
Insert_Delete_Update_Director 250 ,'Dkareeeem','insert'
select * from Directors
go

/*  PROCEDURE Insert_Delete_Update_ProductionComp   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_ProductionComp(@ProductionCoID  tinyint, @ProductionCompany    VARCHAR(50),@StatementType NVARCHAR(20) = '')
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO PC
                (ProductionCompany,
                 ProductionCoID
				 )
                  
    VALUES     ( @ProductionCompany,
                 @ProductionCoID)
	end
	  IF @StatementType = 'Update'
        BEGIN
            UPDATE PC
            SET    ProductionCompany = @ProductionCompany
            WHERE  ProductionCoID = @ProductionCoID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM PC
            WHERE  ProductionCoID = @ProductionCoID
        END
END
Insert_Delete_Update_ProductionComp 204 ,'CGkareeeem','insert'
select * from Directors

go

/*  PROCEDURE Insert_Delete_Update_Cast   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_Cast(@Actor1  VARCHAR(50),
                              @Actor2    VARCHAR(50),
							  @Actor3    VARCHAR(50),
							  @Actor4    VARCHAR(50),
							  @CASTID    VARCHAR(50),
							  @StatementType NVARCHAR(20) = ''
							  )
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Cast
                (Actor1 ,
                Actor2  ,  
				Actor3   ,
				Actor4   ,
				CASTID   
				 )
                  
    VALUES     ( @Actor1 ,
                @Actor2  ,  
				@Actor3   ,
				@Actor4   ,
				@CASTID )
	end
	  IF @StatementType = 'Update'
        BEGIN
            UPDATE Cast
            SET    Actor1 = @Actor1
            WHERE  CASTID = @CASTID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM Cast
            WHERE  CASTID = @CASTID
        END
END
Insert_Delete_Update_Cast 'k1','k2','k3','k4','c2','insert'
select * from Cast

go

/*  PROCEDURE Insert_Delete_Update_Awards   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_Awards(@Oscars  tinyint,
							  @Wins tinyint,
							  @Nominations tinyint,
							  @Other tinyint,
							  @AwardsTID varchar(50),
							  @StatementType NVARCHAR(20) = ''
							  )
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Awards
                (Oscar  ,
				Wins ,
				Nominations ,
				Other ,
				AwardsTID
				 )
                  
    VALUES     ( @Oscars  ,
				@Wins ,
				@Nominations ,
				@Other,
				@AwardsTID)
	end

	  IF @StatementType = 'Update'
        BEGIN
            UPDATE Awards
            SET    Other = @Other
            WHERE  AwardsTID = @AwardsTID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM Awards
            WHERE  AwardsTID = @AwardsTID
        END
END
Insert_Delete_Update_Awards 1,1,1,1,'kareeeem2','insert'
select * from Awards

go

/*  PROCEDURE Insert_Delete_Update_Evaluation   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_Evaluation(@Metascore  tinyint,
							  @E_imdbRating float,
							  @E_imdbVotes int,
							  @SerialNumber nvarchar(50),
							  @Popularity float,
							  @StatementType NVARCHAR(20) = ''
							  )
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Evaluation
                (Metascore  ,
				E_imdbRating ,
				E_imdbVotes ,
				SerialNumber ,
				Popularity
				 )
                  
    VALUES     ( @Metascore  ,
				@E_imdbRating ,
				@E_imdbVotes ,
				@SerialNumber ,
				@Popularity )
	end
	  IF @StatementType = 'Update'
        BEGIN
            UPDATE Evaluation
            SET    E_imdbVotes = @E_imdbVotes
            WHERE  SerialNumber = @SerialNumber
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM Evaluation
            WHERE  SerialNumber = @SerialNumber
        END
END
Insert_Delete_Update_Evaluation 1,1,1,'##4',10,'insert'
select * from Evaluation
go

/*  PROCEDURE Insert_Delete_Update_MovieOverview   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_MovieOverview(@ReviewTitle  nvarchar(50),
							  @UserName varchar(max),
							  @ReviewRating varchar(max),
							  @ReviewDate date,
							  @ReviewID nvarchar(50),
							  @StatementType NVARCHAR(20) = ''
							  )
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO MovieOverview
                (ReviewTitle  ,
				UserName ,
				ReviewRating,
				ReviewDate ,
				ReviewID
				 )
                  
    VALUES     ( @ReviewTitle  ,
				@UserName ,
				@ReviewRating,
				@ReviewDate ,
				@ReviewID )
	end
	  IF @StatementType = 'Update'
        BEGIN
            UPDATE MovieOverview
            SET    UserName = @UserName
            WHERE  ReviewID = @ReviewID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM MovieOverview
            WHERE  ReviewID = @ReviewID
        END
END
Insert_Delete_Update_MovieOverview 'asd','asd','89','2019-02-27','1','insert'
select * from MovieOverview
GO
/*  PROCEDURE Insert_Delete_Update_Movie   */
CREATE or Alter  PROCEDURE Insert_Delete_Update_Movie(@imdbID  nvarchar(50),
							  @Language varchar(50),
							  @ReleasedDate date,
							  @Title varchar(100),
							  @Description nvarchar(350),
							  @Runtime nvarchar(50),
							  @Year smallint,
							  @Country nvarchar(50),
							  @Genre nvarchar(50),
							  @Cast_ID nvarchar(50),
							  @DVD date,
							  @Website nvarchar(50),
							  @Director_ID tinyint,
							  @PC_ID tinyint,
							  @Writer_ID tinyint,
							  @Gross nvarchar(50),
							  @Budget int,
							  @StatementType NVARCHAR(20) = ''
							  )
AS
 BEGIN
  IF @StatementType = 'Insert'
    BEGIN
    INSERT INTO Movie
                (imdbID  ,
				ReleasedDate,
				Language ,
				Title ,
				Description ,
				Runtime ,
				Year ,
				Country ,
				Genre ,
				Cast_ID ,
				DVD ,
				Website ,
				Director_ID,
				PC_ID ,
				Writer_ID ,
				Gross ,
				Budget
				 )
                  
    VALUES     ( @imdbID  ,
				@ReleasedDate,
				@Language ,
				@Title ,
				@Description ,
				@Runtime ,
				@Year ,
				@Country ,
				@Genre ,
				@Cast_ID ,
				@DVD ,
				@Website ,
				@Director_ID,
				@PC_ID ,
				@Writer_ID ,
				@Gross ,
				@Budget  )
		end
		  IF @StatementType = 'Update'
        BEGIN
            UPDATE Movie
            SET    Language = @Language
            WHERE  imdbID = @imdbID
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM Movie
            WHERE  imdbID = @imdbID
        END
END
Insert_Delete_Update_Movie 'tt0000000','English','2019-02-27','asd','asd','50',9,'Egypt','Action','c1','2019-02-27',
'www',0,1,0,'1000',8000,'insert'

select * from  Movie

--Updating Awards proc
select * from Awards --1
create or alter proc UpdateAwards --2
@new_Oscars  tinyint, @new_Wins  tinyint,@new_Nominations  smallint,@Other  tinyint, @Awards_TID nvarchar(50)
as
begin
   if exists 
    (
     select * from Awards  
     where @Awards_TID = AwardsTID)
     update Awards 
     set  Oscar = @new_Oscars, Wins = @new_Wins, Nominations= @new_Nominations, Other= @Other 
     where AwardsTID= @Awards_TID  --and pno =  @project_number
   else 
     print 'There is no Awards Transaction has that ID'
	 --(Oscar, wins, nominations, other)
end
exec UpdateAwards  10,10,10,10 , 'T-1' --3
exec UpdateAwards  10,10,10,10 , 'T-0' --There is no Awards Transaction has that ID --4
select * from Awards --5-

--Deleting proc
select * from MovieOverview --3
CREATE or alter PROCEDURE Delete_Review
@REV_ID nvarchar(50)
--@R_date date
AS
BEGIN
IF EXISTS (SELECT * FROM MovieOverview WHERE ReviewID = @REV_ID)
BEGIN
DELETE FROM MovieOverview WHERE  ReviewID = @REV_ID
print 'Done' 
END
if not EXISTS (SELECT * FROM MovieOverview WHERE ReviewID = @REV_ID)
BEGIN
print 'Not found' 
END 
END
exec Delete_Review 'rno_10'--2
select * from MovieOverview --3
where ReviewID = 'rno_10'
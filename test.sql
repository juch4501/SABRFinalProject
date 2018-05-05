use lahman2016;

show tables;

#create table with batting and fielding join
drop table if exists substats;
create table substats as
select b.playerID, b.yearID, b.teamID, b.lgID, b.G, b.AB, b.R, b.H, b.2B, b.3B, b.HR, b.RBI, b.SB, b.CS, b.BB, b.SO, b.IBB, b.HBP, b.SH, b.SF, b.GIDP, b.BA, b.PA, b.OBP, b.SLG, b.TB, b.bbrefID, f.POS, f.G as FieldingGames, f.GS, f.InnOuts, f.PO, f.A, f.E, f.DP, f.PB, f.WP, f.SB as FieldingSB, f.CS as FieldingCS, f.ZR
from batting b join fielding2017 f on f.playerID = b.playerID and f.yearID = b.yearID and f.teamID = b.teamID
Where b.yearID > 2012;

# add to substats table the master stats
drop table if exists FullStats;
create table FullStats as 
select b.playerID, b.yearID, b.teamID, b.lgID, b.G, b.AB, b.R, b.H, b.2B, b.3B, b.HR, b.RBI, b.SB, b.CS, b.BB, b.SO, b.IBB, b.HBP, b.SH, b.SF, b.GIDP, b.BA, b.PA, b.OBP, b.SLG, b.TB, b.bbrefID, b.POS, b.FieldingGames, b.GS, b.InnOuts, b.PO, b.A, b.E, b.DP, b.PB, b.WP, b.FieldingSB, b.FieldingCS, b.ZR,
m.nameFirst, m.nameLast, m.nameGiven, m.weight, m.bats, m.throws, m.debut, m.finalGame, m.retroID from substats b
JOIN master2017 m on m.playerID = b.playerID;

select * from FullStats;

#Remove Duplicates from full stats
Drop table if exists AllStats;
CREATE TABLE AllStats LIKE FullStats;
INSERT INTO AllStats Select * from FullStats group by playerID, yearID, teamID;

#Check for uniqueness
select playerID, teamID, yearID, Count(teamID) from AllStats
GROUP BY playerID, teamID, yearID;

select yearID, SUM((PO + A) - E) as RP, count(yearID) as Players, SUM((PO + A) - E)/ count(yearID) as RCPLA from AllStats group by yearID;

select SUM((PO + A) - E)/ count(yearID) as RPLA13 from AllStats where yearID = 2013;
select SUM((PO + A) - E)/ count(yearID) as RPLA14 from AllStats where yearID = 2014;
select SUM((PO + A) - E)/ count(yearID) as RPLA15 from AllStats where yearID = 2015;
select SUM((PO + A) - E)/ count(yearID) as RPLA16 from AllStats where yearID = 2016;
select SUM((PO + A) - E)/ count(yearID) as RPLA17 from AllStats where yearID = 2017;



select SUM(((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB))/ count(yearID) as RCLA13 from AllStats where yearID = 2013;
select SUM(((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB))/ count(yearID) as RCLA14 from AllStats where yearID = 2014;
select SUM(((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB))/ count(yearID) as RCLA15 from AllStats where yearID = 2015;
select SUM(((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB))/ count(yearID) as RCLA16 from AllStats where yearID = 2016;
select SUM(((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB))/ count(yearID) as RCLA17 from AllStats where yearID = 2017;




select nameFirst, nameLast, SUM((PO + A) - E) as RP from AllStats where yearID = 2016 group by nameFirst, nameLast;

select nameFirst, nameLast, teamID, yearID, 
IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)), 1) / ((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB))) as RCPPS,
IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC
from AllStats;

select * from AllStats where nameLast = "Piscotty" and yearID = 2016;

select * from AllStats;

create table test (
	first int,
    second int
    );
    INSERT INTO test (first, second)
VALUES (0, 7);
    
select * from test;

select IfNULL(first/second, 1) as score from test;

# RC = ((Total Bases (TB) * (Hits (H) + Walks (BB) + Hits by Pitch (HBP) – Caught Stealing (CS) – Grounded into Double Plays (GiDP))) / (At-Bats (AB) + Walks (BB)))
# TB = (Singles (HITS)) + (Doubles ) + (Triples x 2) + (Home Runs x 3)
# RP = (Putouts + Assists - Errors)
# RCPPS = RC / RP

select * from Master;
select * from batterwar; 


ALTER TABLE Batting ADD bbrefID varchar(255);

UPDATE Batting B
Inner JOIN Master M on M.bbrefID = B.playerID
SET B.bbrefID = M.bbrefID;


ALTER TABLE Pitching ADD bbrefID varchar(255);

UPDATE Pitching P
Inner JOIN Master M on M.bbrefID = P.playerID
SET P.bbrefID = M.bbrefID;

SELECT @@sql_mode;
SET sql_mode='NO_ENGINE_SUBSTITUTION';
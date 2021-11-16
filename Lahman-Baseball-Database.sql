create temporary table Combined as
select yearID from allstarfull
union
select yearID from appearances
union
select yearID from awardsmanagers
union
select yearID from awardsplayers
union
select yearID from awardssharemanagers
union
select yearID from awardsshareplayers
union
select yearID from batting
union
select yearID from battingpost
union
select yearID from collegeplaying
union
select yearID from fielding
union
select yearID from fieldingof
union
select yearID from fieldingofsplit
union
select yearID from fieldingpost
union
select yearID from halloffame
union
select yearID from managers
union
select yearID from managershalf
union
select yearID from pitching
union
select yearID from pitchingpost
union
select yearID from salaries
union
select yearID from seriespost
union
select yearID from teams
union
select yearID from teamshalf;

#1
select MIN(yearID), MAX(yearID) from Combined;

#2
SELECT nameFirst, nameLast, teamID, height, G_all
FROM people
INNER JOIN appearances
ON people.playerID = appearances.playerID
WHERE height IS NOT NULL
ORDER BY height;
SELECT name
FROM teams
WHERE teamID = 'SLA';

#3
SELECT schoolID
FROM schools
WHERE name_full = 'Vanderbilt University';
SELECT people.nameFirst, people.nameLast, collegeplaying.schoolID, SUM(salary)
FROM people
INNER JOIN salaries ON salaries.playerID = people.playerID
INNER JOIN collegeplaying ON collegeplaying.playerID = people.playerID
WHERE collegeplaying.schoolID = 'vandy'
GROUP BY people.nameFirst,people.nameLast,schoolID
ORDER BY SUM(salary)desc;


 #5
SELECT CONCAT(SUBSTRING(yearID, 1, 3), 0)  AS decade,
	ROUND(AVG(SO),2) AS strikeout,
    ROUND(AVG(HR),2) AS homeruns
FROM pitching
WHERE (yearid*10)/10 >= 1920
GROUP BY decade;

#6
SELECT nameFirst,nameLast, SUCCESS
FROM(SELECT playerID, yearID, SB, ATTEMPTS, ROUND(SB/ATTEMPTS* 100,2) AS SUCCESS
FROM(SELECT SB, yearID, playerID, SUM(SB + CS) AS ATTEMPTS
FROM batting
WHERE yearID =2016
GROUP BY SB, yearID, playerID) STOLEN
WHERE ATTEMPTS >= 20
ORDER BY SUCCESS DESC) STOLEN2
LEFT JOIN people
ON STOLEN2.playerID =people.playerID
ORDER BY SUCCESS DESC;

#8
SELECT t.name, p.parkname, h.attendance, h.games,
ROUND(CAST(h.attendance as dec) / CAST(h.games as dec), 1) as avg_attendance
FROM homegames h
LEFT JOIN parks p ON h.parkkey = p.parkkey
LEFT JOIN teams as t ON t.yearid = h.yearkey AND h.teamkey = t.teamid
WHERE yearid = 2016 AND h.games >= 10
ORDER BY avg_Attendance desc;

#10
SELECT s.yearid, s.teamid, t.name, team_salary, t.w as wins
FROM (SELECT salaries.yearid, salaries.teamid, SUM(salary) as team_salary
FROM salaries
WHERE salaries.yearid >= 2000
GROUP BY salaries.yearid, salaries.teamid) s
LEFT JOIN teams t on s.teamid = t.teamid AND s.yearid = t.yearid
ORDER BY name;








WITH
Shots AS (SELECT *, (101 IN UNNEST(tags.id)) AS isGoal, /* tag ID 101='goals' from goals table */
      /* Translate 0-100 (x,y) coordinate-based distances to absolute positions
      using "average" field dimensions of 102x60 before combining in 2D dist calc */
      SQRT(
        POW((110 - positions[ORDINAL(1)].x) * 102/100, 2) +
        POW((55 - positions[ORDINAL(1)].y) * 60/100, 2)) AS shotDistance
FROM `soccer.events365`
WHERE eventName = 'Shot') 
SELECT 
    ROUND(shotDistance) AS ShotDistRound,
    COUNT(*) AS numShots,
    SUM(IF(isGoal, 1, 0)) AS numGoals,
    AVG(IF(isGoal, 1, 0)) AS goalPercentage
FROM Shots
WHERE shotDistance < 50
GROUP BY ShotDistRound
ORDER BY ShotDistRound
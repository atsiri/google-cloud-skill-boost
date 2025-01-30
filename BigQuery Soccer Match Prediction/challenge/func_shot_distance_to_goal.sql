CREATE FUNCTION `soccer.GetShotDistanceToGoal365`(x INT64, y INT64)
RETURNS FLOAT64
AS (
 /* Translate 0-100 (x,y) coordinate-based distances to absolute positions
 using "average" field dimensions of 102x60 before combining in 2D dist calc */
 SQRT(
   POW((110 - x) * 102/100, 2) +
   POW((55 - y) * 60/100, 2)
   )
 );
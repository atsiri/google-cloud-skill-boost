CREATE MODEL `soccer.xg_logistic_reg_model_365`
  OPTIONS (model_type = 'LOGISTIC_REG', input_label_cols = ['isGoal']) AS
  SELECT Events.subEventName AS shotType, /* 101 is known Tag for 'goals' from goals table */
        (101 IN UNNEST(Events.tags.id)) AS isGoal, 
        `soccer.GetShotDistanceToGoal365`(Events.positions[ORDINAL(1)].x, Events.positions[ORDINAL(1)].y) AS shotDistance,
        `soccer.GetShotAngleToGoal365`(Events.positions[ORDINAL(1)].x, Events.positions[ORDINAL(1)].y) AS shotAngle
  FROM `soccer.events365` Events
  LEFT JOIN `soccer.matches` Matches 
    ON Events.matchId = Matches.wyId
  LEFT JOIN `soccer.competitions` Competitions 
    ON Matches.competitionId = Competitions.wyId
  /* Filter out World Cup matches for model fitting purposes */
  WHERE Competitions.name != 'World Cup' AND
  /* Includes both "open play" & free kick shots (including penalties) */
  (eventName = 'Shot' OR 
  (eventName = 'Free Kick' AND subEventName IN ('Free kick shot', 'Penalty')))
;
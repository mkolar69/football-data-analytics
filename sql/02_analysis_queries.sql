SELECT
    player_name,
    SUM(goals) AS total_goals
FROM appearances
GROUP BY player_name
ORDER BY total_goals DESC
LIMIT 10;

SELECT
    player_name,
    SUM(assists) AS total_assists
FROM appearances
GROUP BY player_name
ORDER BY total_assists DESC
LIMIT 10;

SELECT
    player_name,
    SUM(minutes_played) AS total_minutes
FROM appearances
GROUP BY player_name
ORDER BY total_minutes DESC
LIMIT 10;

SELECT
    player_name,
    SUM(goals) AS total_goals,
    SUM(minutes_played) AS total_minutes,
    ROUND((SUM(goals)::NUMERIC / (SUM(minutes_played)::NUMERIC / 90)), 2) AS goals_per_90
FROM appearances
GROUP BY player_name
HAVING SUM(minutes_played) >= 1000
ORDER BY goals_per_90 DESC
LIMIT 10;

SELECT
    name,
    position,
    current_club_name,
    market_value_in_eur
FROM players
WHERE market_value_in_eur IS NOT NULL
ORDER BY market_value_in_eur DESC
LIMIT 10;

SELECT
    home_club_name,
    SUM(home_club_goals) AS total_home_goals,
    COUNT(game_id) AS total_home_games,
    ROUND(AVG(home_club_goals), 2) AS avg_goals_per_home_game
FROM games
GROUP BY home_club_name
ORDER BY total_home_goals DESC
LIMIT 10;

SELECT
    away_club_name,
    SUM(away_club_goals) AS total_away_goals,
    COUNT(game_id) AS total_away_games,
    ROUND(AVG(away_club_goals), 2) AS avg_goals_per_away_game
FROM games
GROUP BY away_club_name
ORDER BY total_away_goals DESC
LIMIT 10;

SELECT
    c.name AS competition_name,
    COUNT(g.game_id) AS total_games,
    SUM(g.home_club_goals + g.away_club_goals) AS total_goals,
    ROUND(AVG(g.home_club_goals + g.away_club_goals), 2) AS avg_goals_per_match
FROM games g
JOIN competitions c ON g.competition_id = c.competition_id
GROUP BY c.name
ORDER BY avg_goals_per_match DESC;

SELECT
    player_name,
    SUM(yellow_cards) AS total_yellows,
    SUM(red_cards) AS total_reds,
    (SUM(yellow_cards) + SUM(red_cards) * 2) AS penalty_points
FROM appearances
GROUP BY player_name
ORDER BY penalty_points DESC
LIMIT 10;

SELECT
    player_name,
    COUNT(appearance_id) AS games_played,
    SUM(goals) AS total_goals,
    SUM(assists) AS total_assists,
    SUM(minutes_played) AS total_minutes,
    ROUND((SUM(goals)::NUMERIC / (SUM(minutes_played)::NUMERIC / 90)), 2) AS goals_per_90
FROM appearances
WHERE player_name IN ('Lionel Messi', 'Cristiano Ronaldo')
GROUP BY player_name;

SELECT
    home_club_name,
    COUNT(*) as total_home_games,
    SUM(CASE WHEN home_club_goals > away_club_goals THEN 1 ELSE 0 END)AS home_wins,
    ROUND (
    (SUM(CASE WHEN home_club_goals >away_club_goals THEN 1 ELSE 0 END):: NUMERIC / COUNT(*)) * 100, 2
    )AS home_win_percentage
FROM games
group by home_club_name
HAVING COUNT(*) >=30
ORDER BY home_win_percentage DESC
LIMIT 10;

SELECT
    away_club_name,
    count(*)as total_away_games,
    SUM(CASE WHEN away_club_goals > home_club_goals THEN 1 ELSE 0 END) AS away_wins,
    ROUND(
        (SUM(CASE WHEN away_club_goals > home_club_goals THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2
    )AS away_win_percentage
FROM games
group by away_club_name
HAVING COUNT(*)>=30
ORDER BY away_win_percentage DESC
LIMIT 10;

 SELECT
    date,
    home_club_name,
    away_club_name,
    home_club_goals,
    away_club_goals,
    (home_club_goals + away_club_goals) AS total_goals
FROM games
ORDER BY total_goals DESC
LIMIT 10;

SELECT
    position,
    COUNT(player_id) as total_players,
    ROUND(AVG(market_value_in_eur), 0)AS avg_market_value_eur,
    MAX(market_value_in_eur) AS max_market_value_eur
FROM players
WHERE position IS NOT NULL AND market_value_in_eur IS NOT NULL
GROUP BY position
ORDER BY avg_market_value_eur DESC;

SELECT
    current_club_name,
    COUNT(player_id) AS total_players,
    SUM(market_value_in_eur) AS total_squad_value_eur,
    ROUND(AVG(market_value_in_eur), 0) AS avg_player_value_eur
FROM players
WHERE current_club_name IS NOT NULL AND market_value_in_eur IS NOT NULL
GROUP BY current_club_name
ORDER BY total_squad_value_eur DESC
LIMIT 10;

SELECT
    player_name,
    SUM(goals) AS total_goals,
    SUM(assists) AS total_assists,
    (SUM(goals) + SUM(assists)) AS total_points
FROM appearances
GROUP BY player_name
ORDER BY total_points DESC
LIMIT 10;

SELECT
    player_name,
    COUNT(*) AS super_sub_goals
FROM appearances
WHERE minutes_played < 45 AND goals > 0
GROUP BY player_name
ORDER BY super_sub_goals DESC
LIMIT 10;

SELECT
    foot,
    COUNT(*) AS player_count,
    ROUND((COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM players WHERE foot IS NOT NULL)) * 100, 2) AS percentage
FROM players
WHERE foot IS NOT NULL
GROUP BY foot
ORDER BY player_count DESC;

SELECT
    season,
    COUNT(game_id) AS total_games,
    SUM(home_club_goals + away_club_goals) AS total_goals,
    ROUND(AVG(home_club_goals + away_club_goals), 2) AS avg_goals_per_game
FROM games
GROUP BY season
ORDER BY season ASC;
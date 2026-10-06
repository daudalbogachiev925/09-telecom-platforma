SELECT
    CASE WHEN caller = :msisdn THEN callee ELSE caller END AS peer,
    COUNT(*) AS calls,
    SUM(duration) AS total_sec,
    AVG(duration) AS avg_sec
FROM cdr
WHERE caller = :msisdn OR callee = :msisdn
GROUP BY peer
ORDER BY calls DESC
LIMIT 20;

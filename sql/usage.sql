SELECT s.id, s.msisdn, s.name,
       COUNT(c.id) AS calls,
       COALESCE(SUM(c.duration),0) AS total_seconds,
       ROUND(COALESCE(SUM(c.duration),0)/60.0, 2) AS total_minutes
FROM subscribers s
LEFT JOIN cdr c ON (c.caller = s.msisdn OR c.callee = s.msisdn)
WHERE c.started >= date_trunc('month', NOW())
GROUP BY s.id
ORDER BY total_minutes DESC;

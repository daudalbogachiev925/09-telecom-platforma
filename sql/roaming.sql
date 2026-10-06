SELECT s.msisdn, COUNT(*) AS calls,
       SUM(c.duration) AS seconds,
       SUM(c.duration) * 0.05 AS roaming_cost
FROM cdr c
JOIN subscribers s ON s.msisdn = c.caller
WHERE c.roaming = TRUE
GROUP BY s.msisdn
ORDER BY roaming_cost DESC;

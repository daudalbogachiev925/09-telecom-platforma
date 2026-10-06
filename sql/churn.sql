SELECT s.id, s.msisdn, s.name, s.status,
       MAX(c.started) AS last_activity,
       NOW() - MAX(c.started) AS inactive_for
FROM subscribers s
LEFT JOIN cdr c ON (c.caller = s.msisdn OR c.callee = s.msisdn)
WHERE s.status = 'active'
GROUP BY s.id
HAVING MAX(c.started) < NOW() - INTERVAL '60 days'
    OR MAX(c.started) IS NULL;

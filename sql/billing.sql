WITH usage AS (
    SELECT s.id AS sub_id, t.*,
           COALESCE(SUM(c.duration),0) AS sec,
           COUNT(*) FILTER (WHERE c.kind='sms') AS sms
    FROM subscribers s
    JOIN tariffs t ON t.id = s.tariff_id
    LEFT JOIN cdr c ON (c.caller = s.msisdn OR c.callee = s.msisdn)
        AND c.started >= date_trunc('month', NOW())
    GROUP BY s.id, t.id
)
SELECT sub_id,
       monthly,
       GREATEST(0, sec/60 - minutes_included) * 1.5 AS voice_cost,
       GREATEST(0, sms - sms_included) * sms_price AS sms_cost,
       monthly
       + GREATEST(0, sec/60 - minutes_included) * 1.5
       + GREATEST(0, sms - sms_included) * sms_price AS total
FROM usage;

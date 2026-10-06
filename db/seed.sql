INSERT INTO tariffs (name, monthly, minutes_included, sms_included, gb_included) VALUES
('Базовый',300,300,100,5),
('Смарт',600,600,300,15),
('Премиум',1500,2000,1000,50);

INSERT INTO subscribers (msisdn, name, tariff_id) VALUES
('+79001112233','Аня',1),
('+79002223344','Петя',2),
('+79003334455','Катя',3);

INSERT INTO cdr (caller, callee, duration, started, kind) VALUES
('+79001112233','+79002223344',120,'2024-01-10 10:00','voice'),
('+79001112233','+79003334455',60,'2024-01-10 11:00','voice'),
('+79002223344','+79001112233',300,'2024-01-11 12:00','voice'),
('+79003334455','+79001112233',45,'2024-01-12 09:00','voice');

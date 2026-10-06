CREATE TABLE subscribers (
    id BIGSERIAL PRIMARY KEY,
    msisdn TEXT UNIQUE NOT NULL,
    name TEXT,
    tariff_id INT,
    activated DATE DEFAULT CURRENT_DATE,
    status TEXT DEFAULT 'active'
);

CREATE TABLE tariffs (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    monthly NUMERIC(10,2),
    minutes_included INT DEFAULT 0,
    sms_included INT DEFAULT 0,
    gb_included NUMERIC(5,2) DEFAULT 0,
    min_price NUMERIC(10,2) DEFAULT 1,
    sms_price NUMERIC(10,2) DEFAULT 2,
    gb_price NUMERIC(10,2) DEFAULT 100
);

CREATE TABLE cdr (
    id BIGSERIAL PRIMARY KEY,
    caller TEXT NOT NULL,
    callee TEXT NOT NULL,
    duration INT NOT NULL,
    started TIM

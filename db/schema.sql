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
    started TIMESTAMP NOT NULL,
    cell_id TEXT,
    kind TEXT DEFAULT 'voice',
    roaming BOOLEAN DEFAULT FALSE
);

CREATE TABLE billing (
    id BIGSERIAL PRIMARY KEY,
    subscriber_id BIGINT REFERENCES subscribers(id),
    period TEXT NOT NULL,
    monthly NUMERIC(10,2),
    voice_cost NUMERIC(10,2),
    sms_cost NUMERIC(10,2),
    data_cost NUMERIC(10,2),
    total NUMERIC(10,2),
    created TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_cdr_caller ON cdr(caller);
CREATE INDEX idx_cdr_callee ON cdr(callee);
CREATE INDEX idx_cdr_started ON cdr(started);

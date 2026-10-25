CREATE TABLE membership_plan (
    plan_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    plan_name VARCHAR(100),
    monthly_fee NUMERIC(8, 2),
    duration_months INTEGER
);

CREATE TABLE member (
    member_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    plan_id INTEGER REFERENCES membership_plan(plan_id),
    full_name VARCHAR(150),
    join_date DATE,
    birth_date DATE
);

CREATE TABLE trainer (
    trainer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(150),
    specialization VARCHAR(100)
);

CREATE TABLE fitness_class (
    class_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trainer_id INTEGER REFERENCES trainer(trainer_id),
    class_name VARCHAR(100),
    start_datetime TIMESTAMP,
    capacity INTEGER
);

CREATE TABLE class_registration (
    registration_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INTEGER REFERENCES member(member_id),
    class_id INTEGER REFERENCES fitness_class(class_id),
    registration_date DATE
);

CREATE TABLE regions
(
    region_id   INT         NOT NULL,
    region_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (region_id)
);

ALTER TABLE regions
    MODIFY region_id INT NOT NULL;


CREATE TABLE countries
(
    country_id   VARCHAR(5)  NOT NULL,
    country_name VARCHAR(74) NOT NULL,
    region_id    INT         NOT NULL,
    FOREIGN KEY region_fk (region_id) REFERENCES regions (region_id),
    PRIMARY KEY (country_id)
);


CREATE TABLE locations
(
    location_id    INT          NOT NULL,
    street_address VARCHAR(100) NOT NULL,
    postal_code    VARCHAR(10),
    city           VARCHAR(50)  NOT NULL,
    state_province VARCHAR(20),
    country_id     VARCHAR(5)   NOT NULL,
    FOREIGN KEY countries_fk (country_id) REFERENCES countries (country_id),
    PRIMARY KEY (location_id)
);

ALTER TABLE locations
    MODIFY postal_code VARCHAR(30);


CREATE TABLE departments
(
    department_id   INT         NOT NULL,
    department_name VARCHAR(20) NOT NULL,
    manager_id      INT,
    location_id     INT         NOT NULL,
    FOREIGN KEY locations_fk (location_id) REFERENCES locations (location_id),
    PRIMARY KEY (department_id)
);

ALTER TABLE departments
    ADD FOREIGN KEY employees_fk (manager_id) REFERENCES employees (employee_id);


CREATE TABLE employees
(
    employee_id    INT         NOT NULL,
    first_name     VARCHAR(20) NOT NULL,
    last_name      VARCHAR(20) NOT NULL,
    email          VARCHAR(50) NOT NULL UNIQUE,
    phone_number   VARCHAR(50),
    hire_date      DATE,
    job_id         VARCHAR(10) NOT NULL,
    salary         INT,
    commission_pct DECIMAL(3, 2),
    manager_id     INT,
    department_id  INT,
    FOREIGN KEY jobs_fk (job_id) REFERENCES jobs (job_id),
    FOREIGN KEY departments_fk (department_id) REFERENCES departments (department_id),
    PRIMARY KEY (employee_id)
);

ALTER TABLE employees
    ADD FOREIGN KEY employees_fk (manager_id) REFERENCES employees (employee_id);


CREATE TABLE jobs
(
    job_id     VARCHAR(10) NOT NULL,
    job_title  VARCHAR(20) NOT NULL,
    min_salary INT         NOT NULL,
    max_salary INT         NOT NULL,
    PRIMARY KEY (job_id)
);

ALTER TABLE jobs
    MODIFY job_title VARCHAR(50) NOT NULL;


CREATE TABLE job_history
(
    employee_id   INT         NOT NULL,
    start_date    DATE        NOT NULL,
    end_date      DATE        NOT NULL,
    job_id        VARCHAR(10) NOT NULL,
    department_id INT         NOT NULL,
    FOREIGN KEY jobs_fk (job_id) REFERENCES jobs (job_id),
    FOREIGN KEY departments_fk (department_id) REFERENCES departments (department_id),
    FOREIGN KEY employees_fk (employee_id) REFERENCES employees (employee_id),
    PRIMARY KEY (employee_id, start_date)
);


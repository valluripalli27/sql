CREATE TABLE Employee (
    Ssn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    salary FLOAT,
    dno VARCHAR(20),  -- Foreign key to Department
    supervisor_snn VARCHAR(20),  -- Self-referential foreign key for supervisor
    CONSTRAINT fk_works_for FOREIGN KEY (dno) REFERENCES Department(dno),
    CONSTRAINT fk_supervisor FOREIGN KEY (supervisor_snn) REFERENCES Employee(Ssn)
);

CREATE TABLE Department (
    dno VARCHAR(20) PRIMARY KEY,
    dname VARCHAR(100),
    manager_snn VARCHAR(20) UNIQUE, -- Each department has one manager
    CONSTRAINT fk_manager FOREIGN KEY (manager_snn) REFERENCES Employee(Ssn)
);

CREATE TABLE Department_Locations (
    dno VARCHAR(20),
    location VARCHAR(255),
    PRIMARY KEY (dno, location),
    CONSTRAINT fk_dept_loc FOREIGN KEY (dno) REFERENCES Department(dno)
);

CREATE TABLE Project (
    pno VARCHAR(20) PRIMARY KEY,
    pname VARCHAR(100),
    location VARCHAR(255),
    controlling_dno VARCHAR(20), -- Foreign key to Department
    CONSTRAINT fk_controlling_dept FOREIGN KEY (controlling_dno) REFERENCES Department(dno)
);

CREATE TABLE Works_On (
    Ssn VARCHAR(20),
    pno VARCHAR(20),
    PRIMARY KEY (Ssn, pno),
    CONSTRAINT fk_works_on_emp FOREIGN KEY (Ssn) REFERENCES Employee(Ssn),
    CONSTRAINT fk_works_on_proj FOREIGN KEY (pno) REFERENCES Project(pno)
);

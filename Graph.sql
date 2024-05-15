USE master;
DROP DATABASE IF EXISTS MedSystem;
CREATE DATABASE MedSystem;
USE MedSystem;



CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(2) NOT NULL,
    Age INT NOT NULL
) AS NODE;


INSERT INTO Patients (Name, Gender, Age)
VALUES
    ('Иван Иванов', 'М', 35),
    ('Елена Петрова', 'Ж', 45),
    ('Алексей Смирнов', 'М', 25),
    ('Ольга Козлова', 'Ж', 30),
    ('Дмитрий Николаев', 'М', 40),
    ('Наталья Иванова', 'Ж', 28),
    ('Петр Сидоров', 'М', 55),
    ('Мария Петрова', 'Ж', 33),
    ('Андрей Васильев', 'М', 38),
    ('Екатерина Смирнова', 'Ж', 42);





CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Specialization NVARCHAR(100) NOT NULL
) AS NODE;

INSERT INTO Doctors (Name, Specialization)
VALUES
    ('Анна Иванова', 'Терапевт'),
    ('Павел Петров', 'Хирург'),
    ('Ольга Сидорова', 'Педиатр'),
    ('Ирина Николаева', 'Гинеколог'),
    ('Александр Васильев', 'Онколог'),
    ('Марина Козлова', 'Офтальмолог'),
    ('Евгений Смирнов', 'Невролог'),
    ('Татьяна Попова', 'Психиатр'),
    ('Алексей Новиков', 'Кардиолог'),
    ('Ольга Морозова', 'Эндокринолог');






CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    Floor INT NOT NULL
) AS NODE;

INSERT INTO Departments (Name, Location, Floor)
VALUES
    ('Отделение терапии', 'Главное корпус', 2),
    ('Хирургическое отделение', 'Новое крыло', 3),
    ('Детское отделение', 'Главное корпус', 1),
    ('Отделение гинекологии', 'Главное корпус', 3),
    ('Отделение онкологии', 'Старое крыло', 5),
    ('Отделение офтальмологии', 'Новое крыло', 4),
    ('Отделение неврологии', 'Старое крыло', 2),
    ('Психиатрическое отделение', 'Главное корпус', 5),
    ('Отделение кардиологии', 'Старое крыло', 4),
    ('Отделение эндокринологии', 'Главное корпус', 3);





CREATE TABLE Medications (
    MedicationID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Type NVARCHAR(100) NOT NULL
) AS NODE;

INSERT INTO Medications (Name, Type)
VALUES
    ('Аспирин', 'Анальгетик'),
    ('Амоксициллин', 'Антибиотик'),
    ('Ибупрофен', 'Противовоспалительное средство'),
    ('Парацетамол', 'Анальгетик'),
    ('Цефтриаксон', 'Антибиотик'),
    ('Дексаметазон', 'Глюкокортикостероид'),
    ('Лоратадин', 'Антигистаминное средство'),
    ('Фенилэфрин', 'Дезконгестант'),
    ('Валериана', 'Травяное средство'),
    ('Атенолол', 'Бета-блокатор');



	--Пациент знаком с  другими пациентами по палате
	CREATE TABLE Knows as Edge;

	--Врач лечит пациента
	CREATE TABLE TreatedBy (Diagnosis  nvarchar(50)) as Edge;

	--Пациент принадлежит отделению
	CREATE TABLE BelongsToDepartment as Edge;
	
	--врач работает в отделении
	CREATE TABLE WorksInDepartment as edge;

	--пациент принимает лекартсва
	CREATE TABLE TakesMedication as edge;

	--врач назначает лекартсва
	CREATE TABLE PrescribesMedication as edge;


	
	ALTER TABLE Knows
	ADD CONSTRAINT EC_Knows CONNECTION (Patients TO Patients);

	ALTER TABLE TreatedBy
	ADD CONSTRAINT EC_TreatedBy CONNECTION (Doctors TO Patients);

		ALTER TABLE BelongsToDepartment
	ADD CONSTRAINT EC_BelongsToDepartment CONNECTION (Patients TO Departments);

		ALTER TABLE WorksInDepartment
	ADD CONSTRAINT EC_WorksInDepartment CONNECTION (Doctors TO Departments);

	ALTER TABLE TakesMedication
	ADD CONSTRAINT EC_TakesMedication CONNECTION (Patients TO Medications );

	ALTER TABLE PrescribesMedication
	ADD CONSTRAINT EC_PrescribesMedication CONNECTION (Doctors TO Medications );



	
	INSERT INTO Knows ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Patients WHERE PatientID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 2)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 3)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 4)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 2),
 (SELECT $node_id FROM Patients WHERE PatientID  = 3)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 3),
 (SELECT $node_id FROM Patients WHERE PatientID  = 6)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 3),
 (SELECT $node_id FROM Patients WHERE PatientID  = 4)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 4),
 (SELECT $node_id FROM Patients WHERE PatientID  = 6)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 5),
 (SELECT $node_id FROM Patients WHERE PatientID  = 7)),



((SELECT $node_id FROM Patients WHERE PatientID  = 5),
 (SELECT $node_id FROM Patients WHERE PatientID  = 8)),



 ((SELECT $node_id FROM Patients WHERE PatientID  = 6),
 (SELECT $node_id FROM Patients WHERE PatientID  = 8)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 6),
 (SELECT $node_id FROM Patients WHERE PatientID  = 9)),


 ((SELECT $node_id FROM Patients WHERE PatientID  = 7),
 (SELECT $node_id FROM Patients WHERE PatientID  = 8)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 8),
 (SELECT $node_id FROM Patients WHERE PatientID  = 9)),


 ((SELECT $node_id FROM Patients WHERE PatientID  = 8),
 (SELECT $node_id FROM Patients WHERE PatientID  = 10)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 9),
 (SELECT $node_id FROM Patients WHERE PatientID  = 10)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 9),
 (SELECT $node_id FROM Patients WHERE PatientID  = 1)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 10),
 (SELECT $node_id FROM Patients WHERE PatientID  = 1)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 10),
 (SELECT $node_id FROM Patients WHERE PatientID  = 2))


	INSERT INTO TreatedBy ($from_id, $to_id, Diagnosis)
VALUES ((SELECT $node_id FROM Doctors WHERE DoctorID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 1), 'Грипп'),

 ((SELECT $node_id FROM Doctors WHERE DoctorID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 2), 'Гастрит'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 4), 'Грипп'),



  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 3),
 (SELECT $node_id FROM Patients WHERE PatientID  = 3), 'Пневмония'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 4),
 (SELECT $node_id FROM Patients WHERE PatientID  = 5), 'Диабет'),



  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 4),
 (SELECT $node_id FROM Patients WHERE PatientID  = 6), 'Мигрень'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 7),
 (SELECT $node_id FROM Patients WHERE PatientID  = 7), 'Ангина'),



  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 9),
 (SELECT $node_id FROM Patients WHERE PatientID  = 8), 'Ангина'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 9),
 (SELECT $node_id FROM Patients WHERE PatientID  = 9), 'Язва желудка'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 10),
 (SELECT $node_id FROM Patients WHERE PatientID  = 10), 'Диабет')

 select *
 from TreatedBy



 	INSERT INTO BelongsToDepartment ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Patients WHERE PatientID  = 1),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 1)),

((SELECT $node_id FROM Patients WHERE PatientID  = 2),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 2)), 

 ((SELECT $node_id FROM Patients WHERE PatientID  = 3),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 3)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 4),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 1)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 5),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 6)),




 ((SELECT $node_id FROM Patients WHERE PatientID  = 6),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 6)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 7),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 6)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 8),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 8)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 9),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 10)),

 ((SELECT $node_id FROM Patients WHERE PatientID  = 10),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 9))

 select *
 from BelongsToDepartment



 	INSERT INTO WorksInDepartment ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 1),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 1)),

 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 2),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 1)),

  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 3),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 3)),

  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 4),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 5)),
  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 5),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 9)),

  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 6),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 5)),
  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 7),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 8)),

  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 8),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 1)),
  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 9),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 10)),
  ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 10),
 (SELECT $node_id FROM Departments WHERE DepartmentID   = 10))
 
 select *
 from WorksInDepartment



 INSERT INTO TakesMedication ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Patients  WHERE PatientID   = 1),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 1)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 2),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 1)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 3),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 5)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 4),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 4)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 5),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 7)),

 ((SELECT $node_id FROM Patients  WHERE PatientID   = 6),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 8)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 9),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 9)),

 ((SELECT $node_id FROM Patients  WHERE PatientID   = 7),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 1)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 8),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 8)),
 ((SELECT $node_id FROM Patients  WHERE PatientID   = 10),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 10))


  INSERT INTO PrescribesMedication ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 1),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 10)),

 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 2),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 4)),
 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 3),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 3)),
 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 4),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 2)),

 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 5),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 8)),
 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 6),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 5)),
 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 7),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 9)),
 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 8),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 10)),

 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 9),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 5)),
 ((SELECT $node_id FROM Doctors  WHERE DoctorID   = 10),
 (SELECT $node_id FROM Medications WHERE MedicationID   = 8))




 --Кто лечащий врач пациента: "Иван Иванов"
 SELECT Doctors.Name as [Лечащий врач]
 , Patients.Name AS [Пациент]
FROM Doctors AS Doctors
 , TreatedBy 
 , Patients AS Patients
WHERE MATCH(Doctors-(TreatedBy)->Patients)
 AND Patients.Name = N'Иван Иванов';


 --Кто принимает Аспирин
 SELECT Patients.Name AS [Пациент], Medications.Name AS [Лекарство]
FROM Patients,
 TakesMedication,
 Medications
WHERE Match(Patients-(TakesMedication)->Medications) And  Medications.Name = N'Аспирин'

--Кто из врачей работает в отделении, находящемся на первом этаже?
SELECT Doctors.Name AS [Врач], Departments.Name AS [Отделение], Departments.Floor AS [Этаж]
FROM Doctors, WorksInDepartment, Departments
WHERE MATCH(Doctors-(WorksInDepartment)->Departments) and Departments.Floor = 1;


-- Какие лекарства принимают пациенты, лечащиеся у доктора Анны Ивановой?
SELECT Patients.Name AS [Пациент], Medications.Name AS [Лекарство], Medications.Type AS [Тип]
FROM Patients, Doctors, TreatedBy, TakesMedication, Medications
WHERE MATCH(Patients-(TakesMedication)->Medications) AND MATCH(Doctors-(TreatedBy)->Patients) and Doctors.Name = N'Анна Иванова'

--Какие пациенты принадлежат отделению, находящемуся на 3 этаже, и принимают лекарства?
SELECT Patients.Name AS [Пациент], Departments.Name AS [Отделение], Medications.Name as [Лекартсво]
FROM Patients, BelongsToDepartment, Departments, TreatedBy, Doctors, PrescribesMedication, Medications
WHERE MATCH(Doctors-(TreatedBy)->Patients) and  MATCH(Patients-(BelongsToDepartment)->Departments) and  MATCH(Doctors-(PrescribesMedication)->Medications) and  Departments.Floor = 3 



SELECT *
FROM (
    SELECT
        Person1.name AS PersonName,
        STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Пациент,
        COUNT(Person2.name) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Doctors AS Person1,
        TreatedBy FOR PATH AS fo,
        Patients FOR PATH  AS Person2
    WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
    AND Person1.name = 'Анна Иванова'
) Q
WHERE Q.levels = 1



SELECT PersonName, Friends
FROM (
    SELECT
        Person1.name AS PersonName,
        STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
        COUNT(Person2.name) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Patients AS Person1,
        Knows FOR PATH AS fo,
        Patients FOR PATH  AS Person2
    WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
    AND Person1.name = 'Иван Иванов'
) Q
WHERE Q.levels = 2





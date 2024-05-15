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
    ('���� ������', '�', 35),
    ('����� �������', '�', 45),
    ('������� �������', '�', 25),
    ('����� �������', '�', 30),
    ('������� ��������', '�', 40),
    ('������� �������', '�', 28),
    ('���� �������', '�', 55),
    ('����� �������', '�', 33),
    ('������ ��������', '�', 38),
    ('��������� ��������', '�', 42);





CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Specialization NVARCHAR(100) NOT NULL
) AS NODE;

INSERT INTO Doctors (Name, Specialization)
VALUES
    ('���� �������', '��������'),
    ('����� ������', '������'),
    ('����� ��������', '�������'),
    ('����� ���������', '���������'),
    ('��������� ��������', '�������'),
    ('������ �������', '�����������'),
    ('������� �������', '��������'),
    ('������� ������', '��������'),
    ('������� �������', '���������'),
    ('����� ��������', '������������');






CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    Floor INT NOT NULL
) AS NODE;

INSERT INTO Departments (Name, Location, Floor)
VALUES
    ('��������� �������', '������� ������', 2),
    ('������������� ���������', '����� �����', 3),
    ('������� ���������', '������� ������', 1),
    ('��������� �����������', '������� ������', 3),
    ('��������� ���������', '������ �����', 5),
    ('��������� �������������', '����� �����', 4),
    ('��������� ����������', '������ �����', 2),
    ('��������������� ���������', '������� ������', 5),
    ('��������� �����������', '������ �����', 4),
    ('��������� ��������������', '������� ������', 3);





CREATE TABLE Medications (
    MedicationID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Type NVARCHAR(100) NOT NULL
) AS NODE;

INSERT INTO Medications (Name, Type)
VALUES
    ('�������', '����������'),
    ('������������', '����������'),
    ('���������', '��������������������� ��������'),
    ('�����������', '����������'),
    ('�����������', '����������'),
    ('������������', '�������������������'),
    ('���������', '��������������� ��������'),
    ('����������', '�������������'),
    ('���������', '�������� ��������'),
    ('��������', '����-��������');



	--������� ������ �  ������� ���������� �� ������
	CREATE TABLE Knows as Edge;

	--���� ����� ��������
	CREATE TABLE TreatedBy (Diagnosis  nvarchar(50)) as Edge;

	--������� ����������� ���������
	CREATE TABLE BelongsToDepartment as Edge;
	
	--���� �������� � ���������
	CREATE TABLE WorksInDepartment as edge;

	--������� ��������� ���������
	CREATE TABLE TakesMedication as edge;

	--���� ��������� ���������
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
 (SELECT $node_id FROM Patients WHERE PatientID  = 1), '�����'),

 ((SELECT $node_id FROM Doctors WHERE DoctorID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 2), '�������'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 1),
 (SELECT $node_id FROM Patients WHERE PatientID  = 4), '�����'),



  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 3),
 (SELECT $node_id FROM Patients WHERE PatientID  = 3), '���������'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 4),
 (SELECT $node_id FROM Patients WHERE PatientID  = 5), '������'),



  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 4),
 (SELECT $node_id FROM Patients WHERE PatientID  = 6), '�������'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 7),
 (SELECT $node_id FROM Patients WHERE PatientID  = 7), '������'),



  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 9),
 (SELECT $node_id FROM Patients WHERE PatientID  = 8), '������'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 9),
 (SELECT $node_id FROM Patients WHERE PatientID  = 9), '���� �������'),

  ((SELECT $node_id FROM Doctors WHERE DoctorID  = 10),
 (SELECT $node_id FROM Patients WHERE PatientID  = 10), '������')

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




 --��� ������� ���� ��������: "���� ������"
 SELECT Doctors.Name as [������� ����]
 , Patients.Name AS [�������]
FROM Doctors AS Doctors
 , TreatedBy 
 , Patients AS Patients
WHERE MATCH(Doctors-(TreatedBy)->Patients)
 AND Patients.Name = N'���� ������';


 --��� ��������� �������
 SELECT Patients.Name AS [�������], Medications.Name AS [���������]
FROM Patients,
 TakesMedication,
 Medications
WHERE Match(Patients-(TakesMedication)->Medications) And  Medications.Name = N'�������'

--��� �� ������ �������� � ���������, ����������� �� ������ �����?
SELECT Doctors.Name AS [����], Departments.Name AS [���������], Departments.Floor AS [����]
FROM Doctors, WorksInDepartment, Departments
WHERE MATCH(Doctors-(WorksInDepartment)->Departments) and Departments.Floor = 1;


-- ����� ��������� ��������� ��������, ��������� � ������� ���� ��������?
SELECT Patients.Name AS [�������], Medications.Name AS [���������], Medications.Type AS [���]
FROM Patients, Doctors, TreatedBy, TakesMedication, Medications
WHERE MATCH(Patients-(TakesMedication)->Medications) AND MATCH(Doctors-(TreatedBy)->Patients) and Doctors.Name = N'���� �������'

--����� �������� ����������� ���������, ������������ �� 3 �����, � ��������� ���������?
SELECT Patients.Name AS [�������], Departments.Name AS [���������], Medications.Name as [���������]
FROM Patients, BelongsToDepartment, Departments, TreatedBy, Doctors, PrescribesMedication, Medications
WHERE MATCH(Doctors-(TreatedBy)->Patients) and  MATCH(Patients-(BelongsToDepartment)->Departments) and  MATCH(Doctors-(PrescribesMedication)->Medications) and  Departments.Floor = 3 



SELECT *
FROM (
    SELECT
        Person1.name AS PersonName,
        STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS �������,
        COUNT(Person2.name) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Doctors AS Person1,
        TreatedBy FOR PATH AS fo,
        Patients FOR PATH  AS Person2
    WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
    AND Person1.name = '���� �������'
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
    AND Person1.name = '���� ������'
) Q
WHERE Q.levels = 2





CREATE TABLE STUDENT
( USN     VARCHAR2(20),
  SNAME   VARCHAR2(10),
  ADDRESS VARCHAR2(10),
  PHONE   NUMBER(10),
  GENDER  VARCHAR2(10), 
  PRIMARY KEY(USN));

CREATE TABLE SEMSEC1
( SSID   NUMBER(5),
  SEM   NUMBER(2),
  SECTION  VARCHAR2(1),
  PRIMARY KEY(ssid));

CREATE TABLE CLASS
( SSID NUMBER(5),  
  USN  VARCHAR2(20),
  PRIMARY KEY(USN),
  FOREIGN KEY(ssid) REFERENCES semsec(ssid),
  FOREIGN KEY(USN) REFERENCES student(USN));

CREATE TABLE SUBJECT1
( SUBCODE VARCHAR2(7) PRIMARY KEY, 
  TITLE VARCHAR2(20),
  SEM NUMBER(4),
  credit NUMBER(2));

CREATE TABLE IAMARKS
(  USN  VARCHAR2(20),                                                                     SSID number(5),
   SUBCODE VARCHAR2(7),
   SSID NUMBER(5),
   TEST1 NUMBER(3),
   TEST2 NUMBER(3),
   TEST3 NUMBER(3),
   FINALIA NUMBER(3),
   PRIMARY KEY(USN,SUBCODE,SSID),
   FOREIGN KEY(USN) REFERENCES STUDENTs(USN),
   FOREIGN KEY(SUBCODE) REFERENCES SUBJECT1(SUBCODE),
   FOREIGN KEY(SSID) REFERENCES SEMSEC1(SSID));



SQL> DESC STUDENT;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 USN                                       NOT NULL VARCHAR2(20)
 SNAME                                              VARCHAR2(10)
 ADRESS                                             VARCHAR2(10)
 PHONE                                              NUMBER(10)
 GENDER                                             VARCHAR2(10)

SQL> DESC SEMSEC;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SSID                                      NOT NULL NUMBER(5)
 SEM                                                NUMBER(2)
 SECTION                                            VARCHAR2(1)

SQL> DESC CLASS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SSID                                               NUMBER(5)
 USN                                       NOT NULL VARCHAR2(20)

SQL> DESC SUBJECT;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SUBCODE                                   NOT NULL VARCHAR2(10)
 TITLE                                              VARCHAR2(20)
 SEM                                                NUMBER(4)
 CREDIT                                             NUMBER(2)

SQL> DESC IAMARKS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 USN                                       NOT NULL VARCHAR2(20)
 SSID                                      NOT NULL NUMBER(5)
 SUBCODE                                   NOT NULL VARCHAR2(10)
 TEST1                                             NUMBER(3)
 TEST2                                              NUMBER(3)
 TEST3                                              NUMBER(3)
 FINALIA                                            NUMBER(3)








INSERT INTO STUDENT VALUES('4SF20CS089','AJAY','MANGALORE',733825,'MALE');
INSERT INTO STUDENT VALUES('4SF20IS109 ','VARSHINI','BANTWAL',896523,'FEMALE');
INSERT INTO STUDENT VALUES('4SF20CS098 ','NAVISH','UDUPI',9956258,'MALE');
INSERT INTO STUDENT VALUES('4SF20CD001','SAHANA','SURATHKAL',8752683,'FEMALE');
INSERT INTO STUDENT VALUES('4SF20CS088','KAVYA','MANGALORE',78965231,'FEMALE');

5 row created.

SQL> SELECT * FROM STUDENT;

SQL> SELECT * FROM STUDENT;

USN                  SNAME      ADRESS          PHONE GENDER
-------------------- ---------- ---------- ---------- ----------
4SF20CS089           AJAY       MANGALORE      733825 MALE
4SF20IS109           VARSHINI   BANTWAL        896523 FEMALE
4SF20CS098           NAVISH     UDUPI         9956258 MALE
4SF20CD001           SAHANA     SURATHKAL     8752683 FEMALE
4SF20CS088           KAVYA      MANGALORE    78965231 FEMALE



 INSERT INTO SEMSEC VALUES(1,4,'A');

1 row created.

SQL> SELECT * FROM SEMSEC;
 
      SSID        SEM S
---------- ---------- -
         1          4 A
         2          4 C
         3          8 A
         4          8 B
         5          8 C
         6          5 A


INSERT INTO CLASS VALUES(1,'4SF20CD001')

1 row created.

SQL> SELECT * FROM CLASS;

      SSID USN
---------- --------------------
         1 4SF20CD001
         2 4SF20CS088
         3 4SF20CS089
         4 4SF20IS109
         5 4SF20CS098


INSERT INTO SUBJECT VALUES('20CS31','DATA STRUCTURE',4,4)

1 row created.

SQL> SELECT * FROM SUBJECT;

SUBCODE    TITLE                       SEM     CREDIT
---------- -------------------- ---------- ----------
20CS31     DATA STRUCTURE                4          4
20CS32     UNIX                          4          3
20CS33     DBMS                          5          4
20CS34     DCN                           5          3
20CS35     AIML                          8          4


INSERT INTO IAMARKS VALUES('4SF20CD001',1,'20CS31',38,35,32,0)

1 row created.

SQL> SELECT * FROM IAMARKS;

USN                        SSID SUBCODE        TESTT1      TEST2      TEST3    FINALIA
-------------------- ---------- ---------- ---------- ---------- ---------- ----------
4SF20CD001                    1 20CS31             38         35         32          0
4SF20CD001                    1 20CS32             28         26         29          0
4SF20CS088                    2 20CS31             38         42         32          0
4SF20CS089                    3 20CS33             42         46         41          0
4SF20IS109                    4 20CS34             28         26         29          0
4SF20CS098                    5 20CS35             48         46         50          0

QUERY 1:
SQL> SELECT A.*,B.SEM,B.SECTION FROM STUDENT A,SEMSEC B,CLASS C WHERE A.USN=C.USN AND B.SSID=C.SSID
  2  AND B.SEM=4 AND B.SECTION='C';

USN                  SNAME      ADRESS          PHONE GENDER            SEM S
-------------------- ---------- ---------- ---------- ---------- ---------- -
4SF20CS088           KAVYA      MANGALORE    78965231 FEMALE              4 C

QUERY 2:

SQL> SELECT sem,section,gender,count(*) FROM student s, semsec s1,class c WHERE s.usn=c.usn AND s1.s
sid=c.ssid GROUP BY (gender,sem,section) ORDER BY(sem);

       SEM S GENDER       COUNT(*)
---------- - ---------- ----------
         4 A FEMALE              1
         4 C FEMALE              1
         8 B FEMALE              1
         8 A MALE                1
         8 C MALE                1
QUERY 3:
 SQL> CREATE VIEW internal2 AS SELECT 
 usn,s.subcode,title,TESTT1 FROM subject s,
 iamarks i WHERE i.subcode=s.subcode 
 and i.usn='4SF20CD001';

View created.

OR

SQL>  CREATE VIEW TEST_MARKS 
AS SELECT SUBCODE ,TESTT1 FROM IAMARKS 
WHERE USN='4SF20CD001';

View created.

SQL> SELECT  * FROM TEST_MARKS;

SUBCODE        TESTT1
---------- ----------
20CS31             38
20CS32             28


QUERY 4:

SQL> UPDATE iamarks SET 
finalia=GREATEST((testT1+test2),
(testT1+test3),(test3+test2))/2;

or

UPDATE iamarks SET 
finalia=(testT1+test2+test3)/3;

6 rows updated.

SQL> SELECT * FROM IAMARKS;

USN                        SSID SUBCODE        TESTT1      TEST2      TEST3    FINALIA
-------------------- ---------- ---------- ---------- ---------- ---------- ----------
4SF20CD001                    1 20CS31             38         35         32         37
4SF20CD001                    1 20CS32             28         26         29         29
4SF20CS088                    2 20CS31             38         42         32         40
4SF20CS089                    3 20CS33             42         46         41         44
4SF20IS109                    4 20CS34             28         26         29         29
4SF20CS098                    5 20CS35             48         46         50         49

6 rows selected.

     Query 5:
SQL> SELECT usn,finalia, 
  2   CASE 
  3  WHEN finalia BETWEEN 45 AND 50 THEN 'outstanding' 
  4  WHEN finalia BETWEEN 40 AND 45 THEN 'GOOD' 
  5  WHEN finalia BETWEEN 30 AND 40 THEN 'AVERAGE' 
  6  WHEN finalia <30  THEN 'weak'  
  7  END
  8   AS CATEGORY FROM iamarks i,
      semsec s WHERE i.ssid=s.ssid 
      AND sem=8 AND section IN('A','B','C');


USN                     FINALIA CATEGORY
-------------------- ---------- -----------
4SF20CS089                   44 GOOD
4SF20IS109                   29 weak
4SF20CS098                   49 outstanding











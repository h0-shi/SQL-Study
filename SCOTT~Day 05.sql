select TRUNC(To_DATE('23/12/25','YY/MM/DD') - sysdate)
    from dual;
    
SELECT *
    FROM EMP
WHERE HIREDATE >= TO_DATE('1985/06/01','YY/MM/DD');

SELECT * FROM EMP
WHERE HIREDATE> TO_DATE('1985/06/01'); 

SELECT COUNT(*)
    FROM EMP
WHERE DEPTNO = 30;

SELECT DEPTNO, MAX(SAL)
    FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, AVG(SAL)
    FROM EMP
    WHERE SAL >  2000
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
SELECT JOB, COUNT(*)
    FROM EMP
GROUP BY JOB
    HAVING COUNT(*) >= 3;
    
SELECT E.ENAME, E.JOB, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.ENAME = 'SCOTT';

SELECT E.ENAME, E.JOB, E.SAL, S.GRADE, D.LOC
    FROM EMP E, DEPT D, SALGRADE S
    WHERE E.DEPTNO = D.DEPTNO
    AND E.SAL >= 1400
    AND E.SAL BETWEEN S.LOSAL AND S.HISAL;
    
SELECT E1.ENAME, E1.JOB, E2.ENAME
    FROM EMP E1, EMP E2
WHERE E1.SAL > 1400
    AND E1.MGR = E2.EMPNO;
    
SELECT ENAME
    FROM EMP
    WHERE SAL > (SELECT SAL FROM EMP
        WHERE ENAME = 'SCOTT');
        
SELECT ENAME, SAL
    FROM EMP
WHERE SAL = (SELECT MAX(SAL)
    FROM EMP);
    
SELECT DEPTNO, ENAME, SAL
    FROM EMP
WHERE SAL > ANY(SELECT SAL
    FROM EMP)
GROUP BY DEPTNO;

SELECT DEPTNO, ENAME, SAL 
    FROM EMP
WHERE SAL 
    IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO); 

CREATE VIEW VM_EMP300ALL
    AS (SELECT * FROM EMP WHERE DEPTNO=30);
    
DROP VIEW VM_EMP300ALL;

SELECT 234*567 FROM DUAL;

SELECT ROWNUM, E.*
FROM EMP E;

SELECT ROWNUM, E.*
FROM (SELECT ENAME, JOB, SAL
    FROM EMP
ORDER BY SAL DESC) E
    WHERE ROWNUM <= 5;
    
DROP TABLE DEPT_TEMP;
    
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP;

INSERT INTO DEPT_TEMP ( DNAME, LOC ) 
    VALUES ('SALES','SEOUL');

CREATE SEQUENCE SEQ_DEPT
    INCREMENT BY 5
    START WITH 50
    MAXVALUE 70
    CYCLE
    CACHE 2 ;
    
CREATE TABLE DEPT_SEQ AS SELECT * FROM DEPT_TEMP;
 SELECT * FROM DEPT_TEMP;
 
 INSERT INTO DEPT_SEQ ( DEPTNO, DNAME, LOC)
    VALUES (SEQ_DEPT.NEXTVAL, 'SALES', 'SEOUR');
    
SELECT * FROM DEPT_SEQ;

DROP SEQUENCE SEQ_DEPT;

CREATE SYNONYM E FOR EMP;

CREATE VIEW VW_D AS SELECT E.*, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;

SELECT * FROM E;

DROP SYNONYM E;

--ER
INSERT INTO EMP (SAL, DEPTNO) 
    VALUES (7369,20);

INSERT INTO EMP (EMPNO, DEPTNO) 
    VALUES (7777,20);

ROLLBACK;

DELETE FROM EMP WHERE DEPTNO = 40;

INSERT INTO EMP (EMPNO, DEPTNO) 
    VALUES (7777,40);

COMMIT;

SELECT * FROM DEPT;

DELETE FROM DEPT WHERE DEPTNO = 10;

DELETE FROM EMP WHERE DEPTNO = 10;
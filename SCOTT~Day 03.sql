-- 복습
SELECT Sal*12+nvl(Comm,0) AS SAL_YEAR
    FROM EMP;
    
SELECT ENAME, JOB
    FROM EMP
    ORDER BY ENAME;
    
SELECT *
    FROM EMP
    WHERE DeptNo IN (10,20,30);

SELECT *
    FROM EMP
    WHERE DeptNo != 10; --DeptNo[ NOT IN or <>] 10;
    
SELECT *
    FROM EMP
    WHERE DeptNo NOT IN (10,20,30);
    
SELECT *
    FROM EMP
    WHERE Sal BETWEEN 4000 AND 5000;
    
SELECT *
    FROM EMP
    WHERE Ename LIKE 'A%';
    
SELECT *
    FROM EMP
    WHERE Ename LIKE '%T_';
    
SELECT *
    FROM EMP
    WHERE Comm IS NULL;
    
SELECT *
    FROM EMP
    WHERE Comm IS NOT NULL;
    
SELECT Ename, NVL(Comm,0) AS Comm, Sal*12+NVL(Comm,0) AS Sal_Year
    FROM EMP
    WHERE Comm Is NOT NULL or Comm != 0;
    
SELECT Ename, NVL2(Comm,Comm,0) AS Comm, Sal*12+NVL2(Comm,Comm,0) AS Sal_Year
    FROM EMP;
    
SELECT COUNT(Comm)
    FROM EMP
    WHERE Comm IS NOT NULL;
    
SELECT LOWER(Ename) AS Lower_Name
    FROM EMP
    WHERE LOWER(Ename) LIKE '%mi%' AND LOWER(Ename) NOT LIKE 'mi%';
    
SELECT 1+1
    FROM DUAL;
    
SELECT SUBSTR('990723-2824014',-7) --('990723-2824014',8,14)
    FROM DUAL;
    
SELECT SUBSTR('990723-2824014',1,6)
    FROM DUAL;
        
SELECT CONCAT('******',SUBSTR('990723-2824014',7,13)) AS Num
    FROM DUAL;
    
SELECT 'HELLO, HELLO, HELLO' AS HELLO, INSTR('HELLO, HELLO, HELLO','O',3,3) AS Location_O
    FROM DUAL;
    
SELECT DeptNo, AVG(Sal)
    FROM EMP
    WHERE SAL > 1000
    GROUP BY DeptNo
    HAVING AVG(Sal) >1600 
    ORDER BY DeptNo;
    
SELECT DeptNo, Job, AVG(Sal)
    FROM EMP
    GROUP BY DeptNo, Job
    HAVING AVG(Sal) BETWEEN 2000 AND 3000
    ORDER BY DeptNo;

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    WHERE JOB IN ('MANAGER', 'ANALYST')
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO; 

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 500;
    
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL)
    FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, NVL(JOB,'SUB_TOTAL') AS JOB, COUNT(*), MAX(SAL), SUM(SAL)
    FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL)
    FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
GROUP BY JOB, ROLLUP(DEPTNO)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, TRUNC(AVG(SAL)) AS AV_SAL, MAX(SAL) AS MAX_SAL, MIN(SAL) AS MIN_SAL, COUNT(*) AS CNT
    FROM EMP
    GROUP BY DEPTNO;

SELECT JOB, COUNT(*)
    FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

SELECT CONCAT('19',SUBSTR(HIREDATE,1,2)) AS HIRE_YEAR, DEPTNO, COUNT(*)
    FROM EMP
    GROUP BY CONCAT('19',SUBSTR(HIREDATE,1,2)), DEPTNO; 

--GOOD   
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR, DEPTNO, COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO; 

SELECT NVL2(COMM,'O','X') AS EXIST_COMM, COUNT(*) AS CNT
    FROM EMP
GROUP BY NVL2(COMM,'O','X');

SELECT ENAME, JOB, DNAME, LOC
    FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.EMPNO, D.DEPTNO
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.SAL > 3000;

-- SMITH 의 JOB과 LOC
SELECT E.ENAME, E.JOB, D.LOC
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.ENAME = 'SMITH';

-- 급여가 2500이하이고 부서번호가 9999 이하인 사람 정보
SELECT * -- E.ENAME, E.SAL, E.EMPNO
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.SAL <= 2500 AND E.EMPNO <= 9999;

-- EMP 테이블 사용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수 출력
-- 평균급여는 소수점 제외 및 부서번호별로 출력
SELECT DEPTNO, TRUNC(AVG(SAL)) AS AVG_SAL, MAX(SAL) AS MAX_SAL, MIN(SAL) AS MIN_SAL,
COUNT(*) AS CNT
FROM EMP
GROUP BY DEPTNO;

/* 각 부서별 입사 연도별 사원수, 최고급여, 급여 합, 평균 급여
부서별 소계, 총계 출력*/
SELECT DEPTNO, NVL(TO_CHAR(HIREDATE,'YYYY'),' ') AS HIRE_YEAR, COUNT(*) AS CNT, 
MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
GROUP BY ROLLUP(DEPTNO,TO_CHAR(HIREDATE,'YYYY'))
ORDER BY DEPTNO;

-- PRIMARY FORIEGN KEY 관계가 없는 테이블끼리 우야 연결?
SELECT E.ENAME, E.SAL, S.GRADE 
    FROM EMP E, SALGRADE S 
WHERE E.SAL >= S.LOSAL 
    AND E.SAL <=S.HISAL;

SELECT E.ENAME, E.SAL, S.GRADE 
    FROM EMP E, SALGRADE S 
WHERE E.SAL 
    BETWEEN S.LOSAL AND S.HISAL; 
    
/*SMITH의 급여액과 등급*/
SELECT E.ENAME, E.SAL, S.GRADE 
    FROM EMP E, SALGRADE S 
WHERE E.SAL 
    BETWEEN S.LOSAL AND S.HISAL
    AND E.ENAME = 'SMITH';

/*
 TABLE을 만들 때 ALTER USER 하듯이 함.
 
CREATE TABLE 신규테이블명 AS SELECT * FROM 복사할테이블명 [WHERE]
*/

CREATE TABLE EMP_NEW AS SELECT * FROM EMP ;

/* 테이블 복사해서 조인
SMITH 매니저 이름은?*/
SELECT E.ENAME, N.ENAME
    FROM EMP E, EMP_NEW N
    WHERE E.MGR = N.EMPNO AND E.ENAME = 'SMITH';

-- 자체조인
SELECT E.ENAME, N.ENAME
    FROM EMP E, EMP N
    WHERE E.MGR = N.EMPNO AND E.ENAME = 'SMITH';

-- 외부조인    
SELECT E.ENAME, N.ENAME
    FROM EMP E, EMP N
    WHERE E.MGR(+) = N.EMPNO;

SELECT E.ENAME, N.ENAME
    FROM EMP E, EMP N
    WHERE E.MGR = N.EMPNO(+);
    
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.SAL > 2000
    ORDER BY E.DEPTNO, EMPNO;
    
/*모든 부서 정보와 사원 정보를 부서번호, 사원이름순으로 정렬*/    
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    ORDER BY E.DEPTNO, E.ENAME;

--JONES의 급여 2975
SELECT ENAME, SAL
    FROM EMP
    WHERE ENAME = 'JONES';
    
--서브쿼리 쿼리 안의 쿼리
SELECT ENAME, SAL 
    FROM EMP
    WHERE SAL > (SELECT SAL FROM EMP
        WHERE ENAME = 'JONES');

--DALLAS    20    
SELECT * FROM DEPT;

--DALLAS에서 근무하는 사원의 이름? 서브쿼리 사용
SELECT ENAME
    FROM EMP
    WHERE DEPTNO = 
    (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
    
--DALLAS에서 근무하는 사원의 이름? 조인 사용
SELECT E.ENAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND D.LOC = 'DALLAS';
    
--'ALLEN'보다 추가수당 많이 받는 사람 누구냐!
SELECT ENAME, COMM
    FROM EMP
    WHERE COMM >=
    (SELECT COMM FROM EMP WHERE ENAME ='ALLEN');

-- SCOTT 보다 입사일 빠른 사람    
SELECT *
    FROM EMP
    WHERE HIREDATE <= (
        SELECT HIREDATE FROM EMP WHERE ENAME = 'SCOTT')
    ORDER BY HIREDATE;

--평균급여보다 많이 받는 사람 (부서번호 20 내에서)
SELECT E.DEPTNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.SAL <= (
        SELECT AVG(SAL) FROM EMP) 
    AND E.DEPTNO = 20;
    
--각 부서에서 급여 젤 많이 받는 사람 (다중행 서브쿼리)
SELECT DEPTNO, ENAME, SAL
    FROM EMP
    WHERE SAL IN 
        (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)
    ORDER BY DEPTNO;
        
SELECT SAL ,DEPTNO
    FROM EMP
    WHERE ENAME IN ('SCOTT', 'ADAMS');
    
CREATE TABLE DEPT_TEMP 
    AS SELECT * FROM DEPT WHERE 1 <> 1;

SELECT * FROM DEPT_TEMP;

CREATE TABLE EMP_TEMP 
    AS SELECT EMPNO, ENAME, JOB FROM EMP
        WHERE DEPTNO = 20;
    
SELECT * 
    FROM EMP_TEMP;
    
CREATE TABLE EMP_DEPT 
    AS SELECT E.EMPNO, D.DNAME, E.ENAME FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO;

DROP TABLE EMP_TEMP;

SELECT * FROM DEPT_TEMP; 

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
    VALUES (10,'DATABASAE', NULL);

DELETE FROM DEPT_TEMP WHERE LOC IS NULL;

CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO 
        FROM EMP
        WHERE DEPTNO = 20);
    
DROP VIEW VW_EMP20;

 SELECT DEPTNO, SAL
    FROM EMP
   WHERE SAL < ANY (SELECT SAL FROM EMP
        WHERE DEPTNO = 30) 
    ORDER BY DEPTNO, SAL;
    
SELECT DEPTNO, SAL FROM EMP
        WHERE DEPTNO = 30
            ORDER BY DEPTNO, SAL;
            
/*  각 부서별로 최소 급여보다 
높은 급여를 받는 직원의 정보를 조회*/
SELECT DEPTNO,ENAME,SAL
    FROM EMP E1
    WHERE SAL > ANY (
        SELECT E2.SAL
        FROM EMP E2
        WHERE E1.DEPTNO = E2.DEPTNO
        )
    ORDER BY DEPTNO, SAL;

SELECT DEPTNO,ENAME,SAL
    FROM EMP
    WHERE SAL IN (
        SELECT MIN(SAL)
        FROM EMP
        GROUP BY DEPTNO)
        ORDER BY DEPTNO, SAL;

 SELECT DEPTNO,ENAME,SAL
      FROM EMP
   2850     ORDER BY DEPTNO, SAL;
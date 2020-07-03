CREATE TABLE 극장
(
   극장번호   NUMBER (3) NOT NULL,
   극장이름   VARCHAR2 (5 CHAR) NOT NULL,
   위치         VARCHAR2 (5 CHAR) NOT NULL
);

ALTER TABLE 극장 ADD CONSTRAINT TH_PK PRIMARY KEY(극장번호);

INSERT INTO 극장
     VALUES (1, '롯데', '잠실');

INSERT INTO 극장
     VALUES (2, '메가', '강남');

INSERT INTO 극장
     VALUES (3, '대한', '잠실');


CREATE TABLE 상영관
(
   극장번호      NUMBER (3) NOT NULL,
   상영관번호   NUMBER (20) NOT NULL,
   영화제목      VARCHAR2 (20 CHAR) NOT NULL,
   가격            NUMBER (5) NOT NULL,
   좌석수         NUMBER (3) NOT NULL
);

INSERT INTO 상영관
     VALUES (1,
             1,
             '어려운 영화',
             15000,
             48);

INSERT INTO 상영관
     VALUES (3,
             1,
             '멋진 영화',
             7500,
             120);

INSERT INTO 상영관
     VALUES (3,
             2,
             '재밌는 영화',
             8000,
             110);

ALTER TABLE 상영관 ADD CONSTRAINT SC_PK PRIMARY KEY(극장번호, 상영관번호);

ALTER TABLE 상영관 ADD CONSTRAINT SC_FK FOREIGN KEY(극장번호) REFERENCES 극장(극장번호);

ALTER TABLE 상영관 MODIFY 가격 CHECK(가격<20000);

ALTER TABLE 상영관 MODIFY 상영관번호 CHECK(상영관번호 BETWEEN 0 AND 10);
DESC 상영관;


CREATE TABLE 예약
(
   극장번호      NUMBER (3) NOT NULL,
   상영관번호   NUMBER (2) NOT NULL,
   고객번호      NUMBER (10) NOT NULL,
   좌석번호      NUMBER (3) NOT NULL,
   날짜            DATE NOT NULL
);

INSERT INTO 예약
     VALUES (3,
             2,
             3,
             15,
             '2014-09-01');
             
UPDATE 예약 SET 날짜 = TO_DATE('2014-09-01', 'YYYY-MM-DD');

INSERT INTO 예약
     VALUES (3,
             1,
             4,
             16,
             '2014-09-01');

INSERT INTO 예약
     VALUES (1,
             1,
             9,
             48,
             '2014-09-01');

ALTER TABLE 예약 MODIFY 좌석번호 CONSTRAINT 좌벅선호_UQ UNIQUE;

ALTER TABLE 예약 ADD CONSTRAINT RV_PK PRIMARY KEY(극장번호, 상영관번호, 고객번호);

ALTER TABLE 예약 ADD CONSTRAINT RV_FK FOREIGN KEY(극장번호, 상영관번호) REFERENCES 상영관(극장번호, 상영관번호) ON DELETE CASCADE;

ALTER TABLE 예약 ADD CONSTRAINT RV_FK2 FOREIGN KEY(고객번호) REFERENCES 고객(고객번호) ON DELETE CASCADE;



CREATE TABLE 고객
(
   고객번호   NUMBER (10) NOT NULL,
   이름         VARCHAR2 (10 CHAR) NOT NULL,
   주소         VARCHAR2 (20 CHAR) NOT NULL
);

INSERT INTO 고객
     VALUES (3, '홍길동', '강남');

INSERT INTO 고객
     VALUES (4, '김철수', '잠실');

INSERT INTO 고객
     VALUES (9, '박영희', '강남');

ALTER TABLE 고객 ADD CONSTRAINT CL_PK PRIMARY KEY(고객번호);

 SELECT ROUND(AVG(가격),0) AS 평균가격 FROM 상영관
 
 /*
(1) 단순질의
1. 모든 극장의 이름과 위치를 보이시오
-> SELECT 극장이름, 위치 FROM 극장;

2. '잠실'에 있는 극장을 보이시오
-> SELECT * FROM 극장 WHERE 위치='잠실';

3. '잠실'에 사는 고객의 이름을 오름차순으로 보이시오
-> SELECT 이름 FROM 고객 WHERE 주소='잠실' ORDER BY 이름 ASC;

4. 가격이 8,000원 이하인 영화의 극장번호, 상영관번호, 영화제목을 보이시오
-> SELECT 극장번호, 상영관번호, 영화제목 FROM 상영관 WHERE 가격<=8000; 

5. 극장 위치와 고객의 주소가 같은 고객을 보이시오
-> SELECT DISTINCT 고객.이름, 극장.위치 FROM 극장, 고객 WHERE 극장.위치 LIKE 고객.주소;

(2) 집계질의
1. 극장의 수는 몇 개 인가?
-> SELECT COUNT(극장번호) AS 극장의수 FROM 극장

2. 상영되는 영화의 평균 가격은 얼마인가?
-> SELECT ROUND(AVG(가격),0) AS 평균가격 FROM 상영관

3. 2014년 9월 1일 영화를 관람한 고객의 수는 얼마인가?
->SELECT COUNT(이름) FROM 예약, 고객 WHERE 예약.고객번호 = 고객.고객번호 AND 예약.날짜='2014-09-01'

(3) 부속질의와 조인
1. '대한'극장에서 상영된 영화제목을 보이시오.
-> SELECT 영화제목 FROM 극장, 상영관 WHERE 극장.극장번호 = 상영관.극장번호 AND 극장이름 LIKE '대한'

2. '대한'극장에서 영화를 본 고객의 이름을 보이시오
-> SELECT 이름 FROM 고객, 예약, 극장 WHERE 고객.고객번호 = 예약.고객번호 AND 극장.극장번호=예약.극장번호 AND 극장.극장이름='대한';

3. '대한' 극장의 전체 수입을 보이시오.
-> SELECT SUM(가격) FROM 극장, 상영관, 예약 WHERE  극장.극장번호 = 상영관.극장번호 AND 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 AND 극장.극장이름='대한'

(4) 그룹질의
1. 극장별 상영관 수를 보이시오.
-> SELECT 극장번호,  COUNT(상영관번호) FROM 상영관 GROUP BY 극장번호

2. '잠실'에 있는 극장의 상영관을 보이시오.
-> SELECT * FROM 극장, 상영관 WHERE 극장.극장번호=상영관.극장번호 AND 극장.위치 ='잠실'

3. 2014년 9월 1일의 극장별 평균 관람 고객 수를 보이시오.
->

4. 2014년 9월 1일에 가장 많은 고객이 관람한 영화를 보이시오.
->

*/


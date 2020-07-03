CREATE TABLE ����
(
   �����ȣ   NUMBER (3) NOT NULL,
   �����̸�   VARCHAR2 (5 CHAR) NOT NULL,
   ��ġ         VARCHAR2 (5 CHAR) NOT NULL
);

ALTER TABLE ���� ADD CONSTRAINT TH_PK PRIMARY KEY(�����ȣ);

INSERT INTO ����
     VALUES (1, '�Ե�', '���');

INSERT INTO ����
     VALUES (2, '�ް�', '����');

INSERT INTO ����
     VALUES (3, '����', '���');


CREATE TABLE �󿵰�
(
   �����ȣ      NUMBER (3) NOT NULL,
   �󿵰���ȣ   NUMBER (20) NOT NULL,
   ��ȭ����      VARCHAR2 (20 CHAR) NOT NULL,
   ����            NUMBER (5) NOT NULL,
   �¼���         NUMBER (3) NOT NULL
);

INSERT INTO �󿵰�
     VALUES (1,
             1,
             '����� ��ȭ',
             15000,
             48);

INSERT INTO �󿵰�
     VALUES (3,
             1,
             '���� ��ȭ',
             7500,
             120);

INSERT INTO �󿵰�
     VALUES (3,
             2,
             '��մ� ��ȭ',
             8000,
             110);

ALTER TABLE �󿵰� ADD CONSTRAINT SC_PK PRIMARY KEY(�����ȣ, �󿵰���ȣ);

ALTER TABLE �󿵰� ADD CONSTRAINT SC_FK FOREIGN KEY(�����ȣ) REFERENCES ����(�����ȣ);

ALTER TABLE �󿵰� MODIFY ���� CHECK(����<20000);

ALTER TABLE �󿵰� MODIFY �󿵰���ȣ CHECK(�󿵰���ȣ BETWEEN 0 AND 10);
DESC �󿵰�;


CREATE TABLE ����
(
   �����ȣ      NUMBER (3) NOT NULL,
   �󿵰���ȣ   NUMBER (2) NOT NULL,
   ����ȣ      NUMBER (10) NOT NULL,
   �¼���ȣ      NUMBER (3) NOT NULL,
   ��¥            DATE NOT NULL
);

INSERT INTO ����
     VALUES (3,
             2,
             3,
             15,
             '2014-09-01');
             
UPDATE ���� SET ��¥ = TO_DATE('2014-09-01', 'YYYY-MM-DD');

INSERT INTO ����
     VALUES (3,
             1,
             4,
             16,
             '2014-09-01');

INSERT INTO ����
     VALUES (1,
             1,
             9,
             48,
             '2014-09-01');

ALTER TABLE ���� MODIFY �¼���ȣ CONSTRAINT �¹���ȣ_UQ UNIQUE;

ALTER TABLE ���� ADD CONSTRAINT RV_PK PRIMARY KEY(�����ȣ, �󿵰���ȣ, ����ȣ);

ALTER TABLE ���� ADD CONSTRAINT RV_FK FOREIGN KEY(�����ȣ, �󿵰���ȣ) REFERENCES �󿵰�(�����ȣ, �󿵰���ȣ) ON DELETE CASCADE;

ALTER TABLE ���� ADD CONSTRAINT RV_FK2 FOREIGN KEY(����ȣ) REFERENCES ��(����ȣ) ON DELETE CASCADE;



CREATE TABLE ��
(
   ����ȣ   NUMBER (10) NOT NULL,
   �̸�         VARCHAR2 (10 CHAR) NOT NULL,
   �ּ�         VARCHAR2 (20 CHAR) NOT NULL
);

INSERT INTO ��
     VALUES (3, 'ȫ�浿', '����');

INSERT INTO ��
     VALUES (4, '��ö��', '���');

INSERT INTO ��
     VALUES (9, '�ڿ���', '����');

ALTER TABLE �� ADD CONSTRAINT CL_PK PRIMARY KEY(����ȣ);

 SELECT ROUND(AVG(����),0) AS ��հ��� FROM �󿵰�
 
 /*
(1) �ܼ�����
1. ��� ������ �̸��� ��ġ�� ���̽ÿ�
-> SELECT �����̸�, ��ġ FROM ����;

2. '���'�� �ִ� ������ ���̽ÿ�
-> SELECT * FROM ���� WHERE ��ġ='���';

3. '���'�� ��� ���� �̸��� ������������ ���̽ÿ�
-> SELECT �̸� FROM �� WHERE �ּ�='���' ORDER BY �̸� ASC;

4. ������ 8,000�� ������ ��ȭ�� �����ȣ, �󿵰���ȣ, ��ȭ������ ���̽ÿ�
-> SELECT �����ȣ, �󿵰���ȣ, ��ȭ���� FROM �󿵰� WHERE ����<=8000; 

5. ���� ��ġ�� ���� �ּҰ� ���� ���� ���̽ÿ�
-> SELECT DISTINCT ��.�̸�, ����.��ġ FROM ����, �� WHERE ����.��ġ LIKE ��.�ּ�;

(2) ��������
1. ������ ���� �� �� �ΰ�?
-> SELECT COUNT(�����ȣ) AS �����Ǽ� FROM ����

2. �󿵵Ǵ� ��ȭ�� ��� ������ ���ΰ�?
-> SELECT ROUND(AVG(����),0) AS ��հ��� FROM �󿵰�

3. 2014�� 9�� 1�� ��ȭ�� ������ ���� ���� ���ΰ�?
->SELECT COUNT(�̸�) FROM ����, �� WHERE ����.����ȣ = ��.����ȣ AND ����.��¥='2014-09-01'

(3) �μ����ǿ� ����
1. '����'���忡�� �󿵵� ��ȭ������ ���̽ÿ�.
-> SELECT ��ȭ���� FROM ����, �󿵰� WHERE ����.�����ȣ = �󿵰�.�����ȣ AND �����̸� LIKE '����'

2. '����'���忡�� ��ȭ�� �� ���� �̸��� ���̽ÿ�
-> SELECT �̸� FROM ��, ����, ���� WHERE ��.����ȣ = ����.����ȣ AND ����.�����ȣ=����.�����ȣ AND ����.�����̸�='����';

3. '����' ������ ��ü ������ ���̽ÿ�.
-> SELECT SUM(����) FROM ����, �󿵰�, ���� WHERE  ����.�����ȣ = �󿵰�.�����ȣ AND �󿵰�.�����ȣ = ����.�����ȣ AND �󿵰�.�󿵰���ȣ = ����.�󿵰���ȣ AND ����.�����̸�='����'

(4) �׷�����
1. ���庰 �󿵰� ���� ���̽ÿ�.
-> SELECT �����ȣ,  COUNT(�󿵰���ȣ) FROM �󿵰� GROUP BY �����ȣ

2. '���'�� �ִ� ������ �󿵰��� ���̽ÿ�.
-> SELECT * FROM ����, �󿵰� WHERE ����.�����ȣ=�󿵰�.�����ȣ AND ����.��ġ ='���'

3. 2014�� 9�� 1���� ���庰 ��� ���� �� ���� ���̽ÿ�.
->

4. 2014�� 9�� 1�Ͽ� ���� ���� ���� ������ ��ȭ�� ���̽ÿ�.
->

*/


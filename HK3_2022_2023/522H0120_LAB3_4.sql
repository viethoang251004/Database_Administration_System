﻿--Bai 1
CREATE DATABASE QLNV;
USE QLNV;

CREATE TABLE PHONG (
	MAPHONG CHAR(3) NOT NULL,
	TENPHONG NVARCHAR(40) NOT NULL,
	DIACHI NVARCHAR(50) NOT NULL,
	TEL CHAR(10) NOT NULL
);
ALTER TABLE PHONG ADD CONSTRAINT PK_MAPHONG_PHONG PRIMARY KEY(MAPHONG);

CREATE TABLE DMNN (
	MANN CHAR(2) NOT NULL,
	TENNN NVARCHAR(20) NOT NULL,
);
ALTER TABLE DMNN ADD CONSTRAINT PK_MANN_DMNN PRIMARY KEY(MANN);

CREATE TABLE NHANVIEN (
	MANV CHAR(5) NOT NULL,
	HOTEN NVARCHAR(40) NOT NULL,
	GIOITINH CHAR(3) NOT NULL,
	NGAYSINH DATE NOT NULL,
	LUONG INT NOT NULL,
	MAPHONG CHAR(3) NOT NULL,
	SDT CHAR(10) NOT NULL,
	NGAYBC DATE NOT NULL
);
ALTER TABLE NHANVIEN ADD CONSTRAINT PK_MANV_NHANVIEN PRIMARY KEY(MANV);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_MAPHONG_NHANVIEN FOREIGN KEY(MAPHONG) REFERENCES PHONG(MAPHONG);
alter TABLE NHANVIEN alter column GIOITINH nvarchar(3);

CREATE TABLE TDNN (
	MANV CHAR(5) NOT NULL,
	MANN CHAR(2) NOT NULL,
	TDO CHAR(1) NOT NULL
);
ALTER TABLE TDNN ADD CONSTRAINT PK_MANV_TDNN PRIMARY KEY(MANV, MANN);
ALTER TABLE TDNN ADD CONSTRAINT FK_MANV_TDNN FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV);
ALTER TABLE TDNN ADD CONSTRAINT FK_MANN_TDNN FOREIGN KEY(MANN) REFERENCES DMNN(MANN);

--Bai 2
INSERT INTO PHONG VALUES('HCA', N'Hành chính tổ hợp', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8585793');
INSERT INTO PHONG VALUES('KDA', 'Kinh Doanh', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8574943');
INSERT INTO PHONG VALUES('KTA', N'Kỹ thuật', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 9480485');
INSERT INTO PHONG VALUES('QTA', N'Quản trị', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8508585');

INSERT INTO DMNN VALUES('01', 'Anh');
INSERT INTO DMNN VALUES('02', 'Nga');
INSERT INTO DMNN VALUES('03', N'Pháp');
INSERT INTO DMNN VALUES('04', N'Nhật');
INSERT INTO DMNN VALUES('05', N'Trung Quốc');
INSERT INTO DMNN VALUES('06', N'Hàn Quốc');

INSERT INTO NHANVIEN VALUES('HC001', N'Nguyễn Thị Hà', N'Nữ', '8/27/1950', '2500000', 'HCA', 'NULL', '2/8/1975');
INSERT INTO NHANVIEN VALUES('HC002', N'Trần Văn Nam', 'Nam', '6/12/1975', '3000000', 'HCA', 'NULL', '6/8/1997');
INSERT INTO NHANVIEN VALUES('HC003', N'Nguyễn Thanh Huyền', N'Nữ', '7/3/1978', '1500000', 'HCA', 'NULL', '9/24/1999');
INSERT INTO NHANVIEN VALUES('KD001', N'Lê Tuyết Anh', N'Nữ', '2/3/1977', '2500000', 'KDA', 'NULL', '10/2/2001');
INSERT INTO NHANVIEN VALUES('KD002', N'Nguyễn Anh Tú', 'Nam', '7/4/1942', '2600000', 'KDA', 'NULL', '9/24/1999');
INSERT INTO NHANVIEN VALUES('KD003', N'Phạm An Thái', 'Nam', '5/9/1977', '1600000', 'KDA', 'NULL', '9/24/1999');
INSERT INTO NHANVIEN VALUES('KD004', N'Lê Văn Hải', 'Nam', '1/2/1976', '2700000', 'KDA', 'NULL', '6/8/1997');
INSERT INTO NHANVIEN VALUES('KD005', N'Nguyễn Phương Minh', 'Nam', '1/2/1980', '2000000', 'KDA', 'NULL', '10/2/2001');
INSERT INTO NHANVIEN VALUES('KT001', N'Trần Đình Khâm', 'Nam', '12/2/1981', '2700000', 'KTA', 'NULL', '1/1/2005');
INSERT INTO NHANVIEN VALUES('KT002', N'Nguyễn Mạnh Hùng', 'Nam', '8/16/1980', '2300000', 'KTA', 'NULL', '1/1/2005');
INSERT INTO NHANVIEN VALUES('KT003', N'Phạm Thanh Sơn', 'Nam', '8/20/1984', '2000000', 'KTA', 'NULL', '1/1/2005');
INSERT INTO NHANVIEN VALUES('KT004', N'Vũ Thị Hoài', N'Nữ', '12/5/1980', '2500000', 'KTA', 'NULL', '10/2/2001');
INSERT INTO NHANVIEN VALUES('KT005', N'Nguyễn Thu Lan', N'Nữ', '10/5/1977', '3000000', 'KTA', 'NULL', '10/2/2001');
INSERT INTO NHANVIEN VALUES('KT006', N'Trần Hoài Nam', 'Nam', '7/2/1978', '2800000', 'KTA', 'NULL', '6/8/1997');
INSERT INTO NHANVIEN VALUES('KT007', N'Hoàng Nam Sơn', 'Nam', '12/3/1940', '3000000', 'KTA', 'NULL', '7/2/1965');
INSERT INTO NHANVIEN VALUES('KT008', N'Lê Thu Trang', N'Nữ', '7/6/1950', '2500000', 'KTA', 'NULL', '8/2/1968');
INSERT INTO NHANVIEN VALUES('KT009', N'Khúc Nam Hải', 'Nam', '7/22/1980', '2000000', 'KTA', 'NULL', '1/1/2005');
INSERT INTO NHANVIEN VALUES('KT010', N'Phùng Trung Dũng', 'Nam', '8/28/1978', '2200000', 'KTA', 'NULL', '9/24/1999');

INSERT INTO TDNN VALUES('HC001', '01', 'A');
INSERT INTO TDNN VALUES('HC001', '02', 'B');
INSERT INTO TDNN VALUES('HC002', '01', 'C');
INSERT INTO TDNN VALUES('HC002', '03', 'C');
INSERT INTO TDNN VALUES('HC003', '01', 'D');
INSERT INTO TDNN VALUES('KD001', '01', 'C');
INSERT INTO TDNN VALUES('KD001', '02', 'B');
INSERT INTO TDNN VALUES('KD002', '01', 'D');
INSERT INTO TDNN VALUES('KD002', '02', 'A');
INSERT INTO TDNN VALUES('KD003', '01', 'B');
INSERT INTO TDNN VALUES('KD003', '02', 'C');
INSERT INTO TDNN VALUES('KD004', '01', 'C');
INSERT INTO TDNN VALUES('KD004', '04', 'A');
INSERT INTO TDNN VALUES('KD004', '05', 'A');
INSERT INTO TDNN VALUES('KD005', '01', 'B');
INSERT INTO TDNN VALUES('KD005', '02', 'D');
INSERT INTO TDNN VALUES('KD005', '03', 'B');
INSERT INTO TDNN VALUES('KD005', '04', 'B');
INSERT INTO TDNN VALUES('KT001', '01', 'D');
INSERT INTO TDNN VALUES('KT001', '04', 'E');
INSERT INTO TDNN VALUES('KT002', '01', 'C');
INSERT INTO TDNN VALUES('KT002', '02', 'B');
INSERT INTO TDNN VALUES('KT003', '01', 'D');
INSERT INTO TDNN VALUES('KT003', '03', 'C');
INSERT INTO TDNN VALUES('KT004', '01', 'D');
INSERT INTO TDNN VALUES('KT005', '01', 'C');

--Bai 3
---1
INSERT INTO NHANVIEN VALUES('QT001', N'Nguyễn Đình Việt Hoàng', 'Nam', '10/25/2004', '150000', 'QTA', 'NULL', '12/28/2022');
INSERT INTO TDNN VALUES('QT001', '01', 'C');
INSERT INTO TDNN VALUES('QT001', '04', 'A');

---2
select nhanvien.manv, nhanvien.hoten, nhanvien.luong, phong.maphong, phong.tenphong, tdnn.mann, dmnn.tennn, tdnn.tdo
from nhanvien, phong, tdnn, dmnn
where phong.maphong = nhanvien.maphong and nhanvien.manv = tdnn.manv and tdnn.mann = dmnn.mann and nhanvien.hoten = N'Nguyễn Đình Việt Hoàng';

--Bai 4
---1
select *
from nhanvien
where nhanvien.manv = 'KT001';

---3
select *
from NHANVIEN
where NHANVIEN.GIOITINH = N'Nữ';

---4
select *
from nhanvien
where nhanvien.hoten like N'Nguyễn%';

---5
select *
from nhanvien
where nhanvien.hoten like N'%Văn%';

---6
select *, (year(getdate()) - year(ngaysinh)) as TUOI
from nhanvien
where year(getdate()) - year(ngaysinh) < 30;

---7
select *, (year(getdate()) - year(ngaysinh)) as TUOI
from nhanvien
where year(getdate()) - year(ngaysinh) between 25 and 30;

---8
select tdnn.manv
from tdnn
where tdnn.mann = '01' and tdnn.tdo = 'C';

---9
select *
from nhanvien
where nhanvien.ngaybc < '2000'

---10
select *
from nhanvien
where year(getdate()) - year(nhanvien.ngaybc) > 10;

---11
select *, year(getdate()) - year(nhanvien.ngaysinh) as TUOI
from nhanvien
where (year(getdate()) - year(nhanvien.ngaysinh) >= 60 and nhanvien.gioitinh = 'Nam') or (year(getdate()) - year(nhanvien.ngaysinh) >= 55 and nhanvien.gioitinh = N'Nữ');

---12
select phong.maphong, phong.tenphong, phong.tel
from phong;

---13
SELECT TOP 2 HOTEN, NGAYSINH, NGAYBC
FROM NHANVIEN;

---14
select nhanvien.manv, nhanvien.hoten, nhanvien.ngaysinh, nhanvien.luong
from nhanvien
where nhanvien.luong between 2000000 and 3000000;

---15
select *
from nhanvien
where nhanvien.SDT = 'null';

---16
SELECT MANV, HOTEN, NGAYSINH
FROM NHANVIEN
WHERE MONTH(NGAYSINH) = 3;

---17
SELECT MANV, HOTEN, LUONG
FROM NHANVIEN
ORDER BY LUONG ASC;

---18
SELECT p.maphong, tenphong, AVG(luong) as luongtb
FROM nhanvien nv, phong p
WHERE nv.maphong = p.maphong and tenphong = N'KINH DOANH'
GROUP BY p.maphong, tenphong

---19
SELECT p.maphong, tenphong,count(*) as soluongnv, AVG(luong) as luongtb
FROM nhanvien nv, phong p
WHERE nv.maphong = p.maphong and tenphong = N'KINH DOANH'
GROUP BY p.maphong, tenphong

---20
SELECT p.maphong, tenphong, SUM(luong) as tongluong
FROM nhanvien nv, phong p
GROUP BY p.maphong, tenphong

---21
SELECT p.maphong, tenphong, SUM(luong) as tongluong
FROM nhanvien nv, phong p
GROUP BY p.maphong, tenphong
HAVING SUM(luong) > 500000

---22
SELECT manv, hoten, nv.maphong, tenphong
FROM nhanvien nv, phong p
WHERE p.maphong = nv.maphong

---23
SELECT *
FROM nhanvien nv, phong p
WHERE nv.maphong = p.maphong

---24
SELECT *
FROM phong p,nhanvien nv
WHERE nv.maphong = p.maphong
--Lab3_4
---Bai1
create database QLNV;
use QLNV;

create table phong (
	maphong char(3) not null,
	tenphong nvarchar(40),
	diachi nvarchar(50),
	tel char(10)
);
alter table phong add constraint pk_maphong1 primary key(maphong);

create table dmnn (
	mann char(2) not null,
	tennn nvarchar(20)
);
alter table dmnn add constraint pk_mann1 primary key(mann);

create table nhanvien (
	manv char(5) not null,
	hoten nvarchar(40),
	gioitinh nchar(3),
	ngaysinh date,
	luong int,
	maphong char(3),
	sdt char(10),
	ngaybc date
);
alter table nhanvien add constraint pk_manv1 primary key(manv);
alter table nhanvien add constraint fk_maphong_maphong1 foreign key(maphong) references phong(maphong);

create table tdnn(
	manv char(5) not null,
	mann char(2) not null,
	tdo char(1)
);
alter table tdnn add constraint pk_manv_mann1 primary key(manv, mann);
alter table tdnn add constraint fk_manv_manv1 foreign key(manv) references nhanvien(manv);
alter table tdnn add constraint fk_mann_mann1 foreign key(mann) references dmnn(mann);

---Bai2
Insert into phong values('HCA', N'Hành chính tổ hợp', N'123, Láng Hạ, Đống Đa, Hà Nội', 048585793);
Insert into phong values('KDA', N'Kinh Doanh', N'123, Láng Hạ, Đống Đa, Hà Nội', 048574943);
Insert into phong values('KTA', N'Kỹ thuật', N'123, Láng Hạ, Đống Đa, Hà Nội', 049480485);
Insert into phong values('QTA', N'Quản trị', N'123, Láng Hạ, Đống Đa, Hà Nội', 048508585);

Insert into dmnn values(01, 'Anh');
Insert into dmnn values(02, 'Nga');
Insert into dmnn values(03, N'Pháp');
Insert into dmnn values(04, N'Nhật');
Insert into dmnn values(05, N'Trung Quốc');
Insert into dmnn values(06, N'Hàn Quốc');

Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('HC001', N'Nguyễn Thị Hà', N'Nữ', '8/27/1950', 2500000, 'HCA', '2/8/1975');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('HC002', N'Trần Văn Nam', N'Nam', '6/12/1975', 3000000, 'HCA', '6/8/1997');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('HC003', N'Nguyễn Thanh Huyền', N'Nữ', '7/3/1978', 1500000, 'HCA', '9/24/1999');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KD001', N'Lê Tuyết Anh', N'Nữ', '2/3/1977', 2500000, 'KDA', '10/2/2001');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KD002', N'Nguyễn Anh Tú', N'Nam', '7/4/1942', 2600000, 'KDA', '9/24/1999');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KD003', N'Phạm An Thái', N'Nam', '5/9/1977', 1600000, 'KDA', '9/24/1999');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KD004', N'Lê Văn Hải', N'Nam', '1/2/1976', 2700000, 'KDA', '6/8/1997');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KD005', N'Nguyễn Phương Minh', N'Nam', '1/2/1980', 2000000, 'KDA', '10/2/2001');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT001', N'Trần Đình Khâm', N'Nam', '12/2/1981', 2700000, 'KTA', '1/1/2005');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT002', N'Nguyễn Mạnh Hùng', N'Nam', '8/16/1980', 2300000, 'KTA', '1/1/2005');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT003', N'Phạm Thanh Sơn', N'Nam', '8/20/1984', 2000000, 'KTA', '1/1/2005');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT004', N'Vũ Thị Hoài', N'Nữ', '12/5/1980', 2500000, 'KTA', '10/2/2001');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT005', N'Nguyễn Thu Lan', N'Nữ', '10/5/1977', 3000000, 'KTA', '10/2/2001');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT006', N'Trần Hoài Nam', N'Nam', '7/2/1978', 2800000, 'KTA', '6/8/1997');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT007', N'Hoàng Nam Sơn', N'Nam', '12/3/1940', 3000000, 'KTA', '7/2/1965');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT008', N'Lê Thu Trang', N'Nữ', '7/6/1950', 2500000, 'KTA', '8/2/1968');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT009', N'Khúc Nam Hải', N'Nam', '7/22/1980', 2000000, 'KTA', '1/1/2005');
Insert into nhanvien(manv, hoten, gioitinh, ngaysinh, luong, maphong, ngaybc) values('KT010', N'Phùng Trung Dũng', N'Nam', '8/28/1978', 2200000, 'KTA', '9/24/1999');

Insert into tdnn values('HC001', 01, 'A');
Insert into tdnn values('HC001', 02, 'B');
Insert into tdnn values('HC002', 01, 'C');
Insert into tdnn values('HC002', 03, 'C');
Insert into tdnn values('HC003', 01, 'D');
Insert into tdnn values('KD001', 01, 'C');
Insert into tdnn values('KD001', 02, 'B');
Insert into tdnn values('KD002', 01, 'D');
Insert into tdnn values('KD002', 02, 'A');
Insert into tdnn values('KD003', 01, 'B');
Insert into tdnn values('KD003', 02, 'C');
Insert into tdnn values('KD004', 01, 'C');
Insert into tdnn values('KD004', 04, 'A');
Insert into tdnn values('KD004', 05, 'A');
Insert into tdnn values('KD005', 01, 'B');
Insert into tdnn values('KD005', 02, 'D');
Insert into tdnn values('KD005', 03, 'B');
Insert into tdnn values('KD005', 04, 'B');
Insert into tdnn values('KT001', 01, 'D');
Insert into tdnn values('KT001', 04, 'E');
Insert into tdnn values('KT002', 01, 'C');
Insert into tdnn values('KT002', 02, 'B');
Insert into tdnn values('KT003', 01, 'D');
Insert into tdnn values('KT003', 03, 'C');
Insert into tdnn values('KT004', 01, 'D');
Insert into tdnn values('KT005', 01, 'C');

---Bai3
----Cau1
insert into nhanvien values ('QT001', N'Nguyễn Đình Việt Hoàng', N'Nam', '10/25/2004', 150000, 'HCA', 'null', '12/24/2023');
INSERT INTO tdnn VALUES('QT001', 01, 'C');
INSERT INTO tdnn VALUES('QT001', 04, 'A');

----Cau2
select nhanvien.manv, nhanvien.hoten, nhanvien.luong, phong.maphong, phong.tenphong, tdnn.mann, dmnn.tennn, tdnn.tdo
from nhanvien, phong, tdnn, dmnn
where phong.maphong = nhanvien.maphong and nhanvien.manv = tdnn.manv and tdnn.mann = dmnn.mann and nhanvien.hoten = N'Nguyễn Đình Việt Hoàng';

---Bai4
----Cau1
select *
from nhanvien, phong, dmnn, tdnn
where phong.maphong = nhanvien.maphong and nhanvien.manv = tdnn.manv and tdnn.mann = dmnn.mann and nhanvien.manv='KT001';

----Cau3
select *
from NHANVIEN
where NHANVIEN.GIOITINH = N'Nữ';

----Cau4
select *
from nhanvien
where nhanvien.hoten like N'Nguyễn%';

----Cau5
select *
from nhanvien
where nhanvien.hoten like N'%Văn%';

----Cau6
select *, (year(getdate()) - year(ngaysinh) as tuoi
from nhanvien
where (year(getdate()) - year(ngaysinh) < 30;

----Cau7
select *, (year(getdate()) - year(ngaysinh)) as TUOI
from nhanvien
where year(getdate()) - year(ngaysinh) between 25 and 30;

----Cau8
select tdnn.manv
from tdnn
where tdnn.mann = '01' and tdnn.tdo = 'C';

----Cau9
select *
from nhanvien
where nhanvien.ngaybc < '2000'

----Cau10
select *
from nhanvien
where year(getdate()) - year(nhanvien.ngaybc) > 10;

----Cau11
select *, year(getdate()) - year(nhanvien.ngaysinh) as TUOI
from nhanvien
where (year(getdate()) - year(nhanvien.ngaysinh) >= 60 and nhanvien.gioitinh = 'Nam') or (year(getdate()) - year(nhanvien.ngaysinh) >= 55 and nhanvien.gioitinh = N'Nữ');

----Cau12
select phong.maphong, phong.tenphong, phong.tel
from phong;

----Cau13
SELECT TOP 2 HOTEN, NGAYSINH, NGAYBC
FROM NHANVIEN;

----Cau14
select nhanvien.manv, nhanvien.hoten, nhanvien.ngaysinh, nhanvien.luong
from nhanvien
where nhanvien.luong between 2000000 and 3000000;

----Cau15
select *
from nhanvien
where nhanvien.SDT = 'null';

----Cau16
select manv, hoten, ngaysinh
from nhanvien
where month(ngaysinh) = 3;

----Cau17
select manv, hoten, luong
from nhanvien
order by luong asc;

----Cau18
select p.maphong, tenphong, avg(luong) as luongtb
from nhanvien nv, phong p
where nv.maphong = p.maphong and tenphong = N'Kinh Doanh'
group by p.maphong, tenphong;

----Cau19
SELECT p.maphong, tenphong,count(*) as soluongnv, AVG(luong) as luongtb
FROM nhanvien nv, phong p
WHERE nv.maphong = p.maphong and tenphong = N'Kinh Doanh'
GROUP BY p.maphong, tenphong;

----Cau20
SELECT p.maphong, tenphong, SUM(luong) as tongluong
FROM nhanvien nv, phong p
GROUP BY p.maphong, tenphong;

----Cau21
SELECT p.maphong, tenphong, SUM(luong) as tongluong
FROM nhanvien nv, phong p
GROUP BY p.maphong, tenphong
HAVING SUM(luong) > 500000

----Cau22
SELECT manv, hoten, nv.maphong, tenphong
FROM nhanvien nv, phong p
WHERE p.maphong = nv.maphong

----Cau23
SELECT *
FROM nhanvien nv, phong p
WHERE nv.maphong = p.maphong

----Cau24
SELECT *
FROM phong p,nhanvien nv
WHERE nv.maphong = p.maphong
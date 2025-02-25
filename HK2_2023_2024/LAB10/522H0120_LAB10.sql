--1
Create database qlsv
Use qlsv
--drop database qlsv
Create table lop
(
	malop	varchar(3) primary key,
	tenlop	nvarchar(20),
)

Create table sinhvien
(
	masv	varchar(5) primary key,
	hoten	nvarchar(30),
	ngaysinh	date,
	malop	varchar(3),
	constraint fk1 foreign key(malop) references lop(malop)
)

Create table monhoc
(
	mamh	varchar(3) primary key,
	tenmh	nvarchar(10),
	tinchi	int
)

Create table ketqua
(
	masv	varchar(5),
	mamh	varchar(3),
	diem	int,
	primary key(masv,mamh),
	constraint fk2 foreign key(masv) references sinhvien(masv),
	constraint fk3 foreign key(mamh) references monhoc(mamh)
)

--2
go

sp_addlogin	'login1','123','qlsv'
go
sp_adduser 'login1','login1'

--3
go

grant create table, delete , update to login1

--4
go

sp_addrole 'qlsv'
grant select
to qlsv
go
sp_addrolemember 'qlsv', 'login1'
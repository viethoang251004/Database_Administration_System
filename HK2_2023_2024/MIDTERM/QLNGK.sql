create database QLNGK;
use QLNGK;

--Cau1
---a
create table loaingk(
	maloai varchar(50) not null,
	tenloai nvarchar(50) unique
);
alter table loaingk add constraint pk_maloai1 primary key(maloai);

---b
create table ngk(
	mangk varchar(50) not null,
	tenngk nvarchar(50) unique,
	dvt nvarchar(50) check(dvt in ('chai', 'lon', N'thùng', N'kết')),
	soluong int check(soluong > 0),
	dongia int check(dongia > 0),
	maloaingk varchar(50)
);
alter table ngk add constraint pk_mangk1 primary key(mangk);
alter table ngk add constraint fk_maloaingk_maloai1 foreign key(maloaingk) references loaingk(maloai);

---c
create table khachhang(
	mskh varchar(50) not null,
	hoten nvarchar(50),
	diachi nvarchar(50),
	dienthoai nvarchar(50) default N'chưa có'
);
alter table khachhang add constraint pk_mskh1 primary key(mskh);

---d
create table hoadon(
	sohd varchar(50) not null,
	mskh varchar(50),
	nhanvien nvarchar(50),
	ngaylap date default getdate()
);
alter table hoadon add constraint pk_sohd1 primary key(sohd);
alter table hoadon add constraint fk_mskh_mskh1 foreign key(mskh) references khachhang(mskh);

---e
create table cthd(
	sohd varchar(50) not null,
	mangk varchar(50) not null,
	soluong int check(soluong > 0),
	dongia int
);
alter table cthd add constraint pk_sohd_mangk1 primary key(sohd, mangk);
alter table cthd add constraint fk_sohd_sohd1 foreign key(sohd) references hoadon(sohd);
alter table cthd add constraint fk_mangk_mangk1 foreign key(mangk) references ngk(mangk);

---f
alter table cthd add thanhtien int;
alter table cthd add constraint ck_dongia_cthd1 check(dongia > 1000);

---g
alter table cthd drop constraint fk_sohd_sohd1;
alter table cthd drop constraint fk_mangk_mangk1;
---h
alter table cthd add constraint ck_thanhtien1 check(thanhtien > 0);

--Cau2
---a
insert into loaingk values('NCG', N'Nước có gas');
insert into loaingk values('NCC', N'Nước có cồn');
insert into loaingk values('NGK', N'Nước giải khát');
insert into loaingk values('NN', N'Nước ngọt');

insert into ngk values('P001', 'Pepsi', 'lon', 100, 8000, 'NCG');
insert into ngk values('S001', 'Soju', 'chai', 200, 68000, 'NCC');
insert into ngk values('L001', 'Lavie', 'thùng', 300, 52000, 'NGK');
insert into ngk values('C001', 'CocaCola', 'thùng', 300, 200000, 'NN');

insert into khachhang values('KH001',N'Nguyễn Đình Việt Hoàng', N'004 lô K, Cx Thanh Đa, P.27, Q.BThanh', '');
insert into khachhang values('KH002', N'Nguyễn Đình Trí', N'004 lô K, Cx Thanh Đa, P.27, Q.BThanh', '0928182682');
insert into khachhang values('KH003',N'Nguyễn Đình Thành', N'009 lô 1, Cx Thanh Đa, P.27, Q.BThanh', '0908404157');
insert into khachhang values('KH004',N'Nguyễn Thị Hồng Loan', N'009 lô 1, Cx Thanh Đa, P.27, Q.BThanh, TPHCM', '0908394288');

insert into hoadon values('HD001', 'KH001', N'Nguyễn Đình Việt Hoàng', '4/5/2010');
insert into hoadon values('HD002', 'KH001', N'Nguyễn Đình Trí', '6/1/2001');
insert into hoadon values('HD003','KH003', N'Nguyễn Đình Thành', '3/20/2023');
insert into hoadon values('HD004','KH004', N'Nguyễn Thị Hồng Loan', '3/8/2023');

insert into cthd values('HD001', 'P001', 100, 8000, 8000*100);
insert into cthd values('HD002', 'S001', 200, 68000, 68000*200);
insert into cthd values('HD001', 'L001', 150, 52000, 52000*150);
insert into cthd values('HD004', 'C001', 50, 200000, 200000*50);

---b
update ngk
set dongia = dongia + 10000
where dvt = 'lon';

---c
delete from khachhang
where mskh not in (
	select mskh
	from hoadon
	where year(ngaylap) >= 2010);

---d
delete from ngk
where soluong = 0;

---e
update ngk
set dongia = case when dongia + 100000 > 500000
then 500000
else dongia + 100000
end
where dvt=N'thùng';
select * from ngk

--Cau3
---a
select * from ngk
where dvt='lon';

---b
select * from khachhang
where diachi like '%TPHCM%';

---c
----Cách 1
SELECT NGK.tenngk
FROM ngk
JOIN cthd ON ngk.mangk = cthd.mangk
JOIN hoadon ON cthd.sohd = hoadon.sohd
WHERE DATEPART(QUARTER, hoadon.ngaylap) = 3 AND DATEPART(YEAR, hoadon.ngaylap) = 2018;

----Cách 2
select ngk.tenngk
from ngk,hoadon,cthd
where hoadon.sohd = cthd.sohd and cthd.mangk = ngk.mangk and datepart(quarter, hoadon.ngaylap) = 3 and DATEPART(year, hoadon.ngaylap) = 2018;
---d
----Cách 1
SELECT ngk.tenngk, SUM(cthd.soluong) AS SoLuongBan
FROM ngk
JOIN cthd ON ngk.mangk = cthd.mangk
GROUP BY ngk.tenngk;

----Cách 2
SELECT ngk.tenngk, SUM(cthd.soluong) AS SoLuongBan
FROM ngk, cthd
where ngk.mangk = cthd.mangk
GROUP BY ngk.tenngk;

---e
----Cách 1
SELECT hoadon.sohd
FROM hoadon
JOIN cthd ON hoadon.sohd = cthd.sohd
JOIN ngk ON cthd.mangk = ngk.mangk
JOIN loaingk ON ngk.maloaingk = loaingk.maloai
WHERE loaingk.tenloai IN (N'Nước có ga', N'Nước ngọt');

----Cách 2
select hoadon.sohd
from ngk, hoadon,cthd,loaingk
where ngk.mangk=cthd.mangk and  cthd.sohd=hoadon.sohd and ngk.maloaingk= loaingk.maloai and loaingk.tenloai in (N'Nước có ga',N'Nước ngọt');

---f
----Cách 1
SELECT ngk.tenngk
FROM ngk
LEFT JOIN cthd ON ngk.mangk = cthd.mangk
WHERE cthd.mangk is null;

----Cách 2
SELECT ngk.tenngk
FROM ngk, cthd
where ngk.mangk = cthd.mangk and cthd.mangk is null;

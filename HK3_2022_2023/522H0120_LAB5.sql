--LAB5
---Cau1
create database quanlythuctap;
use quanlythuctap;

create table sinhvien (
	masv	varchar(3) primary key not null,
	ten		nvarchar(20) not null,
	quequan	nvarchar(20) not null,
	ngaysinh date not null,
	hocluc	float not null
);
alter table sinhvien add constraint check_1 check(hocluc >= 0 and hocluc <= 10);

create table detai (
	madt	varchar(4) primary key not null,
	tendt	nvarchar(50) not null,
	cndt	nvarchar(20) not null,
	kinhphi	float default 0 not null
);
alter table detai add constraint check_2 check(kinhphi < 100000000);

create table sinhvien_detai (
	masv	varchar(3) not null,
	madt	varchar(4) not null,
	noithuctap	nvarchar(50) not null,
	quangduong	float,
	ketqua	float not null,
	primary key(masv,madt)
);
alter table sinhvien_detai add constraint fk_1 foreign key(masv) references sinhvien(masv);
alter table sinhvien_detai add constraint fk_2 foreign key(madt) references detai(madt);
alter table sinhvien_detai add constraint check_3 check(ketqua >= 0 and ketqua <= 10);

INSERT INTO sinhvien values ('SV1', N'Nguyễn Văn A', N'Hải Phòng', '01/01/1971', 8.5), ('SV2', N'Lê Thị M', N'Hà Nội', '02/01/2001',7.9), ('SV3', N'Trần Lục B', N'TPHCM', '04/03/2000',10), ('SV4', N'Nguyễn Thị Mau D', N'Cà Mau', '06/05/1979',8), ('SV5', N'Công Tôn T', N'Bình Phước' ,'07/08/2009', 10), ('SV6', N'Công Bá K', N'Bình Thuận' ,'03/09/1981', 10);

INSERT INTO detai values ('001', 'dt1', N'Nhật Minh', 500000), ('002', 'dt2', 'Anh Khoa', 1000000), ('003', 'dt3', N'Thiên An', 700000), ('004', 'dt4', N'Thiên Phú', 650000), ('005', 'dt5', N'Việt Hoàng', 900000);

INSERT INTO sinhvien_detai values ('SV1', '001', N'Hà Nội ', '', 7.5), ('SV2', '002', N'Hải Phòng', '', 8), ('SV3', '003', 'TPHCM', '', 9), ('SV4', '004', N'Cà Mau', '', 6.8), ('SV5', '005', N'Bình Phước', '', 7.5);

---Cau2
----a)

go

create view cau2_a as
Select masv, ten
From sinhvien
Where year(getdate()) - year(ngaysinh) < 20 and hocluc > 8.5;

go

select * from cau2_a;

----b)

go

create view cau2_b as
select *
from detai
where kinhphi > 1000000;

go

select * from cau2_b;

----c)

go

create view cau2_c as
select sv.*
from sinhvien sv, sinhvien_detai sv_dt
where (year(getdate()) - year(ngaysinh)) < 20 and sv.hocluc > 8 and sv_dt.ketqua > 8 and sv.masv = sv_dt.masv;

go

select * from cau2_c;

----d)

go

create view cau2_d as
select cndt
from detai dt, sinhvien sv, sinhvien_detai sv_dt
where quequan = 'TPHCM' and sv.masv = sv_dt.masv and dt.madt = sv_dt.madt;

go

select * from cau2_d;

----e)

go

create view cau2_e as
select *
from sinhvien
where year(ngaysinh) < 1980 and quequan = N'Hải Phòng';

go

select * from cau2_e;

----f)

go

create view cau2_f as
select avg(sv.hocluc) as dtb
from sinhvien sv
where sv.quequan = N'Hà Nội';

go

select * from cau2_f;

----g)

go

create view cau2_g as
select count(*) as soluong
from sinhvien_detai sv_dt, detai dt
where sv_dt.madt = dt.madt and dt.madt = '005';

go

select * from cau2_g;

----h)

go

create view cau2_h as
select sv.quequan, count(*) as soluongsv
from sinhvien sv
group by sv.quequan;

go

select * from cau2_h;

go

---Cau3
----a)

SELECT dt.madt, dt.tendt, dt.cndt
FROM detai dt
JOIN sinhvien_detai sv_dt ON dt.madt = sv_dt.madt
GROUP BY dt.madt, dt.tendt, dt.cndt
HAVING COUNT(sv_dt.masv) >= 2;

go

----b)

SELECT sv.masv, sv.ten, sv.hocluc
FROM sinhvien sv
WHERE sv.hocluc > (
  SELECT MAX(hocluc)
  FROM sinhvien
  WHERE quequan = N'TPHCM'
);

go

----c)

UPDATE sinhvien_detai
SET ketqua = 
    CASE 
        WHEN masv IN (SELECT masv FROM sinhvien WHERE quequan = N'Lâm Đồng') THEN 
            CASE 
                WHEN ketqua + 2 > 10 THEN 10
                ELSE ketqua + 2
            END
        ELSE ketqua
    END;

go

----d)

SELECT sv.masv, sv.ten, sv.quequan, sv_dt.noithuctap
FROM sinhvien sv
JOIN sinhvien_detai sv_dt ON sv.masv = sv_dt.masv
WHERE sv.quequan = sv_dt.noithuctap;

go

----e)

SELECT dt.madt, dt.tendt, dt.cndt
FROM detai dt
LEFT JOIN sinhvien_detai sv_dt ON dt.madt = sv_dt.madt
WHERE sv_dt.masv IS NULL;

go

----f)

SELECT dt.madt, dt.tendt, dt.cndt
FROM detai dt
JOIN sinhvien_detai sv_dt ON dt.madt = sv_dt.madt
JOIN sinhvien sv ON sv_dt.masv = sv.masv
WHERE sv.hocluc = (SELECT MAX(hocluc) FROM sinhvien);

go

----g)

SELECT dt.madt, dt.tendt, dt.cndt
FROM detai dt
JOIN sinhvien_detai sv_dt ON dt.madt = sv_dt.madt
JOIN sinhvien sv ON sv_dt.masv = sv.masv
WHERE sv.hocluc > (SELECT MIN(hocluc) FROM sinhvien);

go

----h)

SELECT sv.masv, sv.ten, sv_dt.madt, dt.tendt, dt.kinhphi
FROM sinhvien sv
JOIN sinhvien_detai sv_dt ON sv.masv = sv_dt.masv
JOIN detai dt ON sv_dt.madt = dt.madt
WHERE dt.kinhphi > (SELECT SUM(kinhphi) / 5 FROM detai);

go

----i)

select sv.*
from sinhvien sv
where hocluc > (select avg(ketqua) from sinhvien_detai where madt = '001');

go
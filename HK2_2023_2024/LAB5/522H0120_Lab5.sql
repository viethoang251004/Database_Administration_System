create database quanlythuctap;
use quanlythuctap;

create table sinhvien(
	masv varchar(100) not null,
	ten nvarchar(100),
	quequan nvarchar(100),
	ngaysinh smalldatetime,
	hocluc nvarchar(100)
);
alter table sinhvien add constraint pk_masv primary key(masv);

create table detai(
	madt varchar(100) not null,
	tendetai nvarchar(100),
	chunhiemdetai nvarchar(100),
	kinhphi int
);
alter table detai add constraint pk_madt primary key(madt);
alter table detai add constraint df_kinhphi DEFAULT 0 FOR kinhphi;

create table sinhvien_detai(
	masv varchar(100) not null,
	madt varchar(100) not null,
	noithuctap nvarchar(100),
	quangduong int,
	ketqua int
);
alter table sinhvien_detai add constraint pk_masv_madt primary key(masv, madt);
alter table sinhvien add constraint ck_hocluc check(0 <= hocluc and hocluc <= 10);
alter table sinhvien_detai add constraint ck_ketqua check(0 <= ketqua and ketqua <= 10);

insert into sinhvien values('522H0120',N'','','','')
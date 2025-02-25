---Bai 1
--Cau 1
create database Quanlysinhvien;
use Quanlysinhvien;

create table khoa (
	makhoa varchar(10) not null,
	tenkhoa nvarchar(50)
);
alter table khoa add constraint pk_makhoa1 primary key(makhoa);

create table sinhvien(
	hosv nvarchar(50),
	tensv nvarchar(50),
	masv varchar(10) not null,
	ngaysinh date,
	phai nvarchar(50),
	makhoa varchar(10)
);
alter table sinhvien add constraint pk_masv1 primary key(masv);
alter table sinhvien add constraint fk_makhoa1 foreign key(makhoa) references khoa(makhoa);

create table monhoc(
	tenmh nvarchar(50),
	mamh varchar(10) not null,
	sotiet int
);
alter table monhoc add constraint pk_mamh1 primary key(mamh);

create table ketqua(
	masv varchar(10) not null,
	mamh varchar(10) not null,
	lanthi int not null,
	diem int
);
alter table ketqua add constraint pk_masv_mamh_lanthi1 primary key(masv, mamh, lanthi);
alter table ketqua add constraint fk_masv1 foreign key(masv) references sinhvien(masv);
alter table ketqua add constraint fk_mamh1 foreign key(mamh) references monhoc(mamh);

INSERT INTO KHOA VALUES('AVAN', 'Khoa anh Van'), ('CNTT', 'Cong Nghe Thong Tin'), ('DTVT', 'Dien Tu Vien Thong'), ('QTKD', 'Quan Tri Kinh Doanh');
INSERT INTO SINHVIEN VALUES('Tran Minh', 'Son', 'S001', '5/1/1985','Nam', 'CNTT'), ('Nguyen Quoc', 'Bao', 'S002', '6/15/1986', 'Nam', 'CNTT'), ('Phan Anh', 'Tung', 'S003', '12/20/1983', 'Nam', 'QTKD'), ('Bui Thi anh', 'Thu', 'S004', '2/1/1985', 'Nu', 'QTKD'), ('Le Thi Lan', 'Anh', 'S005', '7/3/1987', 'Nu', 'DTVT'), ('Nguyen Thi', 'Lam', 'S006','11/25/1984', 'Nu', 'DTVT'), ('Phan Thi', 'Ha', 'S007', '7/3/1988', 'Nu', 'CNTT'), ('Tran The', 'Dung', 'S008', '10/21/1985', 'Nam', 'CNTT');
INSERT INTO MONHOC VALUES('Anh Van', 'AV', 45), ('Co So Du Lieu', 'CSDL', 45), ('Ky Thuat Lap Trinh', 'KTLT', 60), ('Ke Toan Tai Chinh', 'KTTC', 45), ('Toan Cao Cap', 'TCC', 60), ('Tin Hoc Van Phong', 'THVP', 30), ('Tri Tue Nhan Tao', 'TTNT', 45);
INSERT INTO KETQUA VALUES('S001', 'CSDL', 1, 4), ('S001', 'TCC', 1, 6), ('S002', 'CSDL', 1, 3), ('S002', 'CSDL', 2, 6), ('S003', 'KTTC', 1, 5), ('S004', 'AV', 1, 8), ('S004', 'THVP', 1, 4), ('S004', 'THVP', 2, 8), ('S006', 'TCC', 1, 5), ('S007', 'AV', 1, 2), ('S007', 'AV', 2, 9), ('S007', 'KTLT', 1, 6), ('S008', 'AV', 1, 7);
--Cau 2
alter table sinhvien drop constraint fk_makhoa1;
alter table ketqua drop constraint fk_masv1;
alter table ketqua drop constraint fk_mamh1;

--Cau 3
drop table khoa;
drop table monhoc;

--Cau 4
create table khoa (
	makhoa varchar(10) not null,
	tenkhoa nvarchar(50)
);
alter table khoa add constraint pk_makhoa1 primary key(makhoa);

create table sinhvien(
	hosv nvarchar(50),
	tensv nvarchar(50),
	masv varchar(10) not null,
	ngaysinh date,
	phai nvarchar(50),
	makhoa varchar(10)
);
alter table sinhvien add constraint pk_masv1 primary key(masv);
alter table sinhvien add constraint fk_makhoa1 foreign key(makhoa) references khoa(makhoa);

create table monhoc(
	tenmh nvarchar(50),
	mamh varchar(10) not null,
	sotiet int
);
alter table monhoc add constraint pk_mamh1 primary key(mamh);

create table ketqua(
	masv varchar(10) not null,
	mamh varchar(10) not null,
	lanthi int not null,
	diem int
);
alter table ketqua add constraint pk_masv_mamh_lanthi1 primary key(masv, mamh, lanthi);
alter table ketqua add constraint fk_masv1 foreign key(masv) references sinhvien(masv);
alter table ketqua add constraint fk_mamh1 foreign key(mamh) references monhoc(mamh);

--Cau 5
INSERT INTO KHOA VALUES('AVAN', 'Khoa anh Van'), ('CNTT', 'Cong Nghe Thong Tin'), ('DTVT', 'Dien Tu Vien Thong'), ('QTKD', 'Quan Tri Kinh Doanh');
INSERT INTO SINHVIEN VALUES('Tran Minh', 'Son', 'S001', '5/1/1985','Nam', 'CNTT'), ('Nguyen Quoc', 'Bao', 'S002', '6/15/1986', 'Nam', 'CNTT'), ('Phan Anh', 'Tung', 'S003', '12/20/1983', 'Nam', 'QTKD'), ('Bui Thi anh', 'Thu', 'S004', '2/1/1985', 'Nu', 'QTKD'), ('Le Thi Lan', 'Anh', 'S005', '7/3/1987', 'Nu', 'DTVT'), ('Nguyen Thi', 'Lam', 'S006','11/25/1984', 'Nu', 'DTVT'), ('Phan Thi', 'Ha', 'S007', '7/3/1988', 'Nu', 'CNTT'), ('Tran The', 'Dung', 'S008', '10/21/1985', 'Nam', 'CNTT');
INSERT INTO MONHOC VALUES('Anh Van', 'AV', 45), ('Co So Du Lieu', 'CSDL', 45), ('Ky Thuat Lap Trinh', 'KTLT', 60), ('Ke Toan Tai Chinh', 'KTTC', 45), ('Toan Cao Cap', 'TCC', 60), ('Tin Hoc Van Phong', 'THVP', 30), ('Tri Tue Nhan Tao', 'TTNT', 45);
INSERT INTO KETQUA VALUES('S001', 'CSDL', 1, 4), ('S001', 'TCC', 1, 6), ('S002', 'CSDL', 1, 3), ('S002', 'CSDL', 2, 6), ('S003', 'KTTC', 1, 5), ('S004', 'AV', 1, 8), ('S004', 'THVP', 1, 4), ('S004', 'THVP', 2, 8), ('S006', 'TCC', 1, 5), ('S007', 'AV', 1, 2), ('S007', 'AV', 2, 9), ('S007', 'KTLT', 1, 6), ('S008', 'AV', 1, 7);
SELECT * FROM KHOA;
SELECT * FROM SINHVIEN;
SELECT * FROM MONHOC;
SELECT * FROM KETQUA;

--Cau 6
update monhoc
set sotiet = 30
where mamh='TTNT'

--Cau 7
delete from ketqua
where masv='S001'

--Cau 8
INSERT INTO KETQUA VALUES('S001', 'CSDL', 1, 4), ('S001', 'TCC', 1, 6)

--Cau 9
update sinhvien
set hosv = 'Nguyen Van', tensv='Lam', phai = 'Nam' where hosv='Nguyen Thi' and tensv = 'Lam'

--Cau 10
update sinhvien
set makhoa = 'CNTT' where hosv='Le Thi Lan' and tensv='Anh' and makhoa='DTVT'

---Bai 2
--Cau 1
create database Quanlybanhang;
use Quanlybanhang;

create table khachhang(
	makhachhang varchar(10) not null,
	tencongty nvarchar(50),
	tengiaodich nvarchar(50),
	diachi nvarchar(50),
	email varchar(50),
	dienthoai int,
	fax int
);
alter table khachhang add constraint pk_makhachhang1 primary key(makhachhang);

create table nhacungcap (
	macongty varchar(10) not null,
	tencongty nvarchar(50),
	tengiaodich nvarchar(50),
	diachi nvarchar(50),
	dienthoai int,
	fax int,
	email varchar(50)
);
alter table nhacungcap add constraint pk_macongty1 primary key(macongty);

create table loaihang(
	maloaihang varchar(10) not null,
	tenloaihang nvarchar(50)
);
alter table loaihang add constraint pk_maloaihang1 primary key(maloaihang);

create table nhanvien (
	manhanvien varchar(10) not null,
	ho nvarchar(50),
	ten nvarchar(50),
	ngaysinh date,
	ngaylamviec date,
	diachi nvarchar(50),
	dienthoai int,
	luongcoban int,
	phucap int
);
alter table nhanvien add constraint pk_manhanvien1 primary key(manhanvien);

create table dondathang (
	sohoadon varchar(10) not null,
	makhachhang varchar(10),
	manhanvien varchar(10),
	ngaydathang date,
	ngaygiaohang date,
	ngaychuyenhang date,
	noigiaohang nvarchar(50)
);
alter table dondathang add constraint pk_sohoadon1 primary key(sohoadon);
alter table dondathang add constraint fk_manhanvien_manhanvien1 foreign key(manhanvien) references nhanvien(manhanvien);
alter table dondathang add constraint fk_makhachhang_makhachhang1 foreign key(makhachhang) references khachhang(makhachhang);

create table mathang (
	mahang varchar(10) not null,
	tenhang nvarchar(50),
	macongty varchar(10),
	maloaihang varchar(10),
	soluong int,
	donvitinh nvarchar(50),
	giahang int
);
alter table mathang add constraint pk_mahang1 primary key(mahang);
alter table mathang add constraint fk_macongty_macongty1 foreign key(macongty) references nhacungcap(macongty);
alter table mathang add constraint fk_maloaihang_maloaihang1 foreign key(maloaihang) references loaihang(maloaihang);

create table chitietdathang (
	sohoadon varchar(10) not null,
	mahang varchar(10) not null,
	giaban int,
	soluong int,
	mucgiamgia int
);
alter table chitietdathang add constraint pk_sohoadon_mahang1 primary key(sohoadon, mahang);
alter table chitietdathang add constraint fk_sohoadon_sohoadon1 foreign key(sohoadon) references dondathang(sohoadon);
alter table chitietdathang add constraint fk_mahang_mahang1 foreign key(mahang) references mathang(mahang);

-- Cau 2
alter table chitietdathang add constraint default_soluong1 default 1 for soluong;
alter table chitietdathang add constraint default_mucgiamgia1 default 0 for mucgiamgia;

-- Cau 3
alter table dondathang add constraint check_ngaygiaohang_ngaychuyenhang1 check(ngaygiaohang >= ngaydathang and ngaychuyenhang>= ngaydathang);

-- Cau 4
alter table nhanvien add constraint check_nhanvien1 check(year(ngaylamviec) - year(ngaysinh) >= 18 and year(ngaylamviec) - year(ngaysinh) <= 60);

-- Cau5
---Với các bảng đã tạo được, câu lệnh: drop table nhacungcap không thể thực hiện được vì trong bảng mathang có khóa ngoại có thuộc tính là macongty tham chiếu đến bảng nhacungcap có thuộc tính là macongty.

-- Bai 3
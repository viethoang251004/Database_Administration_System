CREATE DATABASE QLSV1;
USE QLSV1;

CREATE TABLE LOP(
	malop VARCHAR(10) NOT NULL,
	TENlop VARCHAR(50) NOT NULL
);

ALTER TABLE LOP ADD CONSTRAINT PK_malop_lop PRIMARY KEY(malop);

CREATE TABLE SINHVIEN(
	MASV VARCHAR(10) NOT NULL,
	hoten VARCHAR(50) NOT NULL,
	ngaysinh SMALLDATETIME NOT NULL,
	malop VARCHAR(10) NOT NULL
);

ALTER TABLE SINHVIEN ADD CONSTRAINT PK_MASV_SINHVIEN PRIMARY KEY(MASV);
ALTER TABLE SINHVIEN ADD CONSTRAINT FK_MALOP_SINHVIEN_LOP FOREIGN KEY(malop) REFERENCES lop(malop);


CREATE TABLE MONHOC(
	TENMH VARCHAR(50) NOT NULL,
	MAMH VARCHAR(10) NOT NULL
);

ALTER TABLE MONHOC ADD CONSTRAINT PK_MAMH_MONHOC PRIMARY KEY(MAMH);

CREATE TABLE KETQUA(
	MASV VARCHAR(10) NOT NULL,
	MAMH VARCHAR(10) NOT NULL,
	DIEM SMALLINT NOT NULL
);

ALTER TABLE KETQUA ADD CONSTRAINT PK_MASV_MAMH_KETQUA PRIMARY KEY(MASV, MAMH);
ALTER TABLE KETQUA ADD CONSTRAINT FK_MASV_KETQUA_SINHVIEN FOREIGN KEY(MASV) REFERENCES SINHVIEN(MASV);
ALTER TABLE KETQUA ADD CONSTRAINT FK_MAMH_KETQUA_MONHOC FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH);

INSERT INTO LOP (malop, TENlop) VALUES ('TH01', 'Lop ky thuat phan mem'), ('TH02', 'Lop mang may tinh'), ('TH03', 'Lop tri tue nhan tao');
INSERT INTO SINHVIEN (MASV, hoten, ngaysinh, malop) VALUES ('SV001', 'Nguyen Van An', '2000-01-05', 'TH01'), ('SV002', 'Tran Thi Bich Phuong', '1999-06-12', 'TH01'), ('SV003', 'Le Hoang Kim Yen', '2001-09-20', 'TH02'), ('SV004', 'Pham Thanh Dao', '2002-03-25', 'TH02'), ('SV005', 'Dang Van Bao', '1998-12-30', 'TH03');
INSERT INTO MONHOC (TENMH, MAMH) VALUES ('Toan cao cap', 'MH001'), ('Lap trinh C++', 'MH002'), ('Mang may tinh', 'MH003');
INSERT INTO KETQUA (MASV, MAMH, DIEM) VALUES ('SV001', 'MH001', 8), ('SV001', 'MH002', 7), ('SV002', 'MH001', 6), ('SV002', 'MH003', 5), ('SV003', 'MH003', 9), ('SV004', 'MH002', 6), ('SV005', 'MH003', 4);

--BAI 4
---Cau a

go

CREATE FUNCTION LayHoTen(@hoten VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @ho VARCHAR(50);
    DECLARE @ten VARCHAR(50);
    DECLARE @holot VARCHAR(50);
    
    SET @hoten = LTRIM(RTRIM(@hoten));
    SET @ho = LEFT(@hoten, CHARINDEX(' ', @hoten + ' ') - 1);
    SET @ten = REVERSE(LEFT(REVERSE(@hoten), CHARINDEX(' ', REVERSE(@hoten) + ' ') - 1));
    SET @holot = REPLACE(@hoten, @ho, '');
    SET @holot = REPLACE(@holot, @ten, '');
    
    RETURN RTRIM(@ho) + ' ' + RTRIM(@holot) + ' ' + RTRIM(@ten);
END;

go

CREATE FUNCTION dbo.GetHoTenLotTen(@fullName VARCHAR(100))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        SUBSTRING(@fullName, 1, CHARINDEX(' ', @fullName) - 1) AS Ho,
        SUBSTRING(@fullName, CHARINDEX(' ', @fullName) + 1, LEN(@fullName) - CHARINDEX(' ', REVERSE(@fullName)) - CHARINDEX(' ',
@fullName)) AS TenLot,
        REVERSE(SUBSTRING(REVERSE(@fullName), 1, CHARINDEX(' ', REVERSE(@fullName)) - 1)) AS Ten
)

go

SELECT Ho, TenLot, Ten 
FROM dbo.GetHoTenLotTen('Truong Tran My Lan')

go

SELECT dbo.LayHoTen('Nguyen Van An') AS HoTen;

---Cau b

go

CREATE FUNCTION LayThongTinSinhVien(@MASV VARCHAR(10))
RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @hoten VARCHAR(50);
    DECLARE @ngaysinh SMALLDATETIME;
    DECLARE @thu VARCHAR(20);
    
    SELECT @hoten = hoten, @ngaysinh = ngaysinh FROM SINHVIEN WHERE MASV = @MASV;
    SET @thu = CASE DATEPART(WEEKDAY, @ngaysinh)
        WHEN 1 THEN N'Chủ Nhật'
        WHEN 2 THEN N'Thứ Hai'
        WHEN 3 THEN N'Thứ Ba'
        WHEN 4 THEN N'Thứ Tư'
        WHEN 5 THEN N'Thứ Năm'
        WHEN 6 THEN N'Thứ Sáu'
        WHEN 7 THEN N'Thứ Bảy'
    END;
    
    RETURN dbo.LayHoTen(@hoten) + N', Ngày sinh: ' + CONVERT(NVARCHAR(10), @ngaysinh, 103) + N', Thứ: ' + @thu;
END;

go

SELECT dbo.LayThongTinSinhVien('SV001') AS ThongTinSinhVien;

---Cau c

go

CREATE FUNCTION SinhVienDiemTrungBinhDuoi5()
RETURNS TABLE
AS
RETURN
SELECT sv.MASV, dbo.LayHoTen(sv.hoten) AS HoTen, YEAR(sv.ngaysinh) AS NamSinh, 
       ROUND(AVG(kq.DIEM * 1.0), 1) AS DiemTrungBinh
FROM SINHVIEN sv
JOIN KETQUA kq ON sv.MASV = kq.MASV
GROUP BY sv.MASV, sv.hoten, sv.ngaysinh
HAVING AVG(kq.DIEM * 1.0) < 5;

go

SELECT * FROM dbo.SinhVienDiemTrungBinhDuoi5();

---Cau d

go

CREATE FUNCTION LayThongTinLop(@MASV VARCHAR(10))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @malop VARCHAR(10);
    DECLARE @TENlop VARCHAR(50);
    
    SELECT @malop = malop FROM SINHVIEN WHERE MASV = @MASV;
    SELECT @TENlop = TENlop FROM LOP WHERE malop = @malop;
    
    RETURN @malop + ' - ' + @TENlop;
END;

go

SELECT dbo.LayThongTinLop('SV001') AS ThongTinLop;

---Cau e

go

CREATE FUNCTION DiemTrungBinhMonHoc(@MAMH VARCHAR(10))
RETURNS FLOAT
AS
BEGIN
    DECLARE @diem_trungbinh FLOAT;
    
    SELECT @diem_trungbinh = AVG(DIEM * 1.0) FROM KETQUA WHERE MAMH = @MAMH;
    
    RETURN @diem_trungbinh;
END;

go

SELECT dbo.DiemTrungBinhMonHoc('MH001') AS DiemTrungBinh;

---Cau f

go

CREATE FUNCTION DiemTrungBinhCaoNhatTheoLop(@malop VARCHAR(10))
RETURNS FLOAT
AS
BEGIN
    DECLARE @diem_cao_nhat FLOAT;
    
    SELECT @diem_cao_nhat = MAX(diem_trungbinh)
    FROM (
        SELECT AVG(kq.DIEM * 1.0) AS diem_trungbinh
        FROM SINHVIEN sv
        JOIN KETQUA kq ON sv.MASV = kq.MASV
        WHERE sv.malop = @malop
        GROUP BY sv.MASV
    ) AS DiemTrungBinhCuaSV;
    
    RETURN @diem_cao_nhat;
END;

go

SELECT dbo.DiemTrungBinhCaoNhatTheoLop('TH01') AS DiemTrungBinhCaoNhat;

---Cau g

go

CREATE FUNCTION TaoMaLopTuDong(@makhoa VARCHAR(10))
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @ma_lonnhat VARCHAR(10);
    DECLARE @sothutu INT;
    DECLARE @ma_lop_moi VARCHAR(10);
    
    SET @ma_lonnhat = (SELECT MAX(malop) FROM LOP WHERE malop LIKE @makhoa + '%');
    
    IF @ma_lonnhat IS NULL
        SET @ma_lonnhat = @makhoa + '00';
    
    SET @sothutu = CAST(RIGHT(@ma_lonnhat, 2) AS INT) + 1;
    SET @ma_lop_moi = @makhoa + RIGHT('0' + CAST(@sothutu AS VARCHAR(2)), 2);
    
    RETURN @ma_lop_moi;
END;

go

SELECT dbo.TaoMaLopTuDong('TH') AS MaLopTuDong;

--BAI 5

create database quanlyNGK;
use quanlyNGK;

create table nsx (
	mansx varchar(50) not null,
	tennsx varchar(50)
);
alter table nsx add constraint pk_mansx_nsx primary key (mansx);

create table ngk (
	mangk varchar(50) not null,
	tenngk varchar(50),
	dvt varchar(50),
	soluong int,
	dongia int,
	maloai varchar(50)
);
alter table ngk add constraint pk_mangk_ngk primary key (mangk);

create table hoadon (
	sohd varchar(50) not null,
	ngaylap datetime
);
alter table hoadon add constraint pk_sohd_hoadon primary key (sohd);

create table cthd (
	sohd varchar(50) not null,
	mangk varchar(50) not null,
	soluong int,
	dongia int
);
alter table cthd add constraint pk_sohd_mangk_cthd primary key (sohd, mangk);
alter table cthd add constraint fk_sohd_cthd_hoadon foreign key (sohd) references hoadon (sohd);
alter table cthd add constraint fk_mangk_cthd_ngk foreign key (mangk) references ngk (mangk);

---Cau a

go

CREATE FUNCTION PhatSinhSoHoaDonMoi(@ngaylap DATETIME)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @sohd VARCHAR(50);
    DECLARE @ngaylap_str VARCHAR(10);
    
    SET @ngaylap_str = REPLACE(CONVERT(VARCHAR, @ngaylap, 5), '/', ''); -- Loại bỏ dấu '/'
    
    SELECT @sohd = MAX(sohd) FROM hoadon WHERE sohd LIKE @ngaylap_str + '%';
    
    IF @sohd IS NULL
        SET @sohd = @ngaylap_str + '001';
    ELSE
        SET @sohd = @ngaylap_str + RIGHT('00' + CAST(CAST(RIGHT(@sohd, 3) AS INT) + 1 AS VARCHAR(3)), 3);
    
    RETURN @sohd;
END;

go

DECLARE @ngaylap DATETIME = GETDATE();
DECLARE @sohd_moi VARCHAR(50);
EXEC @sohd_moi = PhatSinhSoHoaDonMoi @ngaylap;
PRINT @sohd_moi;

---Cau b

go

CREATE PROCEDURE ThemHoaDonMoi
AS
BEGIN
    DECLARE @ngaylap DATETIME = GETDATE();
    DECLARE @sohd VARCHAR(50) = dbo.PhatSinhSoHoaDonMoi(@ngaylap);
    
    INSERT INTO hoadon (sohd, ngaylap) VALUES (@sohd, @ngaylap);
END;

go

EXEC ThemHoaDonMoi;

---Cau c

go

CREATE FUNCTION PhatSinhMaNGKMoi(@maloai VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @sothutu INT;
    DECLARE @ma_ngk_moi VARCHAR(50);
    
    SET @sothutu = ISNULL((SELECT MAX(RIGHT(mangk, 3)) FROM ngk WHERE maloai = @maloai), 0) + 1;
    SET @ma_ngk_moi = @maloai + RIGHT('00' + CAST(@sothutu AS VARCHAR(3)), 3);
    
    RETURN @ma_ngk_moi;
END;

go

DECLARE @maloai VARCHAR(50) = 'COCA';
DECLARE @mangk_moi VARCHAR(50);
EXEC @mangk_moi = PhatSinhMaNGKMoi @maloai;
PRINT @mangk_moi;

---Cau d

go

CREATE PROCEDURE ThemCTHD(@sohd VARCHAR(50), @mangk VARCHAR(50), @soluong INT)
AS
BEGIN
    DECLARE @dongia INT;
    
    SELECT @dongia = dongia FROM ngk WHERE mangk = @mangk;
    SET @dongia = @dongia * 1.5;
    
    INSERT INTO cthd (sohd, mangk, soluong, dongia) VALUES (@sohd, @mangk, @soluong, @dongia);
END;

go

DECLARE @sohd VARCHAR(50) = '2303161';
DECLARE @mangk VARCHAR(50) = 'COCA011';
DECLARE @soluong INT = 5;
EXEC ThemCTHD @sohd, @mangk, @soluong;

---Cau e

go

CREATE FUNCTION TinhTongTienHoaDon(@sohd VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @tongtien INT;
    
    SELECT @tongtien = SUM(soluong * dongia) FROM cthd WHERE sohd = @sohd;
    
    RETURN @tongtien;
END;

go

DECLARE @sohd VARCHAR(50) = '2303161';
DECLARE @tongtien INT;
EXEC @tongtien = TinhTongTienHoaDon @sohd;
PRINT @tongtien;

---Cau f

go

CREATE FUNCTION LayDSNGKBanTrongThang3Nam2016()
RETURNS TABLE
AS
RETURN
SELECT ngk.*
FROM ngk
JOIN cthd ON ngk.mangk = cthd.mangk
JOIN hoadon ON cthd.sohd = hoadon.sohd
WHERE MONTH(hoadon.ngaylap) = 3 AND YEAR(hoadon.ngaylap) = 2016;

go

SELECT * FROM dbo.LayDSNGKBanTrongThang3Nam2016();
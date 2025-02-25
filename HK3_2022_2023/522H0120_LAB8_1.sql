--A
CREATE DATABASE Quanlysinhvien;
USE Quanlysinhvien;

CREATE TABLE KHOA(
	MAKHOA VARCHAR(10) NOT NULL,
	TENKHOA VARCHAR(50) NOT NULL
);

ALTER TABLE KHOA ADD CONSTRAINT PK_MAKHOA1 PRIMARY KEY(MAKHOA);

CREATE TABLE SINHVIEN(
	HOSV VARCHAR(50) NOT NULL,
	TENSV VARCHAR(50) NOT NULL,
	MASV VARCHAR(10) NOT NULL,
	PHAI VARCHAR(10) NOT NULL,
	NAMSINH SMALLDATETIME NOT NULL,
	MAKHOA VARCHAR(10) NOT NULL
);

ALTER TABLE SINHVIEN ADD CONSTRAINT PK_MASV1 PRIMARY KEY(MASV);
ALTER TABLE SINHVIEN ADD CONSTRAINT FK_MAKHOA1 FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA);


CREATE TABLE MONHOC(
	TENMH VARCHAR(50) NOT NULL,
	MAMH VARCHAR(10) NOT NULL,
	SOTIET INT NOT NULL
);

ALTER TABLE MONHOC ADD CONSTRAINT PK_MAMH1 PRIMARY KEY(MAMH);

CREATE TABLE KETQUA(
	MASV VARCHAR(10) NOT NULL,
	MAMH VARCHAR(10) NOT NULL,
	LANTHI SMALLINT NOT NULL,
	DIEM SMALLINT NOT NULL
);

ALTER TABLE KETQUA ADD CONSTRAINT PK_MASV2_MAMH2_LANTHI1 PRIMARY KEY(MASV, MAMH, LANTHI);
ALTER TABLE KETQUA ADD CONSTRAINT FK_MASV1 FOREIGN KEY(MASV) REFERENCES SINHVIEN(MASV);
ALTER TABLE KETQUA ADD CONSTRAINT FK_MAMH1 FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH);

INSERT INTO KHOA VALUES('AVAN', 'Khoa anh Van'), ('CNTT', 'Cong Nghe Thong Tin'), ('DTVT', 'Dien Tu Vien Thong'), ('QTKD', 'Quan Tri Kinh Doanh');
INSERT INTO SINHVIEN VALUES('Tran Minh', 'Son', 'S001', 'Nam', '05/01/1985', 'CNTT'), ('Nguyen Quoc', 'Bao', 'S002', 'Nam', '06/15/1986', 'CNTT'), ('Phan Anh', 'Tung', 'S003', 'Nam', '12/20/1983', 'QTKD'), ('Bui Thi anh', 'Thu', 'S004', 'Nu', '02/01/1985', 'QTKD'), ('Le Thi Lan', 'Anh', 'S005', 'Nu', '07/03/1987', 'DTVT'), ('Nguyen Thi', 'Lam', 'S006', 'Nu','11/25/1984', 'DTVT'), ('Phan Thi', 'Ha', 'S007', 'Nu', '07/03/1988', 'CNTT'), ('Tran The', 'Dung', 'S008', 'Nam', '10/21/1985', 'CNTT');
INSERT INTO MONHOC VALUES('Anh Van', 'AV', '45'), ('Co So Du Lieu', 'CSDL', '45'), ('Ky Thuat Lap Trinh', 'KTLT', '60'), ('Ke Toan Tai Chinh', 'KTTC', '45'), ('Toan Cao Cap', 'TCC', '60'), ('Tin Hoc Van Phong', 'THVP', '30'), ('Tri Tue Nhan Tao', 'TTNT', '45');
INSERT INTO KETQUA VALUES('S001', 'CSDL', '1', '4'), ('S001', 'TCC', '1', '6'), ('S002', 'CSDL', '1', '3'), ('S002', 'CSDL', '2', '6'), ('S003', 'KTTC', '1', '5'), ('S004', 'AV', '1', '8'), ('S004', 'THVP', '1', '4'), ('S004', 'THVP', '2', '8'), ('S006', 'TCC', '1', '5'), ('S007', 'AV', '1', '2'), ('S007', 'AV', '2', '9'), ('S007', 'KTLT', '1', '6'), ('S008', 'AV', '1', '7');
select * from KHOA
select * from SINHVIEN
select * from MONHOC
select * from KETQUA

--B
CREATE DATABASE Quanlybanhang;
USE Quanlybanhang;

CREATE TABLE KHACHHANG(
	MAKHACHHANG VARCHAR(20) NOT NULL,
	TENCONGTY NVARCHAR(100) NOT NULL,
	TENGIAODICH NVARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL,
	DIENTHOAI VARCHAR(20) NOT NULL,
	FAX VARCHAR(20) NOT NULL
);
ALTER TABLE KHACHHANG ADD CONSTRAINT PK_MAKHACHHANG1 PRIMARY KEY(MAKHACHHANG);

CREATE TABLE NHANVIEN(
	MANHANVIEN VARCHAR(20) NOT NULL,
	HO NVARCHAR(100) NOT NULL,
	TEN NVARCHAR(100) NOT NULL,
	NGAYSINH SMALLDATETIME NOT NULL,
	NGAYLAMVIEC SMALLDATETIME NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	DIENTHOAI VARCHAR(20) NOT NULL,
	LUONGCOBAN VARCHAR(20) NOT NULL,
	PHUCAP VARCHAR(20) NOT NULL
);
ALTER TABLE NHANVIEN ADD CONSTRAINT PK_MANHANVIEN1 PRIMARY KEY(MANHANVIEN);

CREATE TABLE NHACUNGCAP(
	MACONGTY VARCHAR(20) NOT NULL,
	TENCONGTY NVARCHAR(100) NOT NULL,
	TENGIAODICH NVARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	DIENTHOAI VARCHAR(20) NOT NULL,
	FAX VARCHAR(20) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL
);
ALTER TABLE NHACUNGCAP ADD CONSTRAINT PK_MACONGTY1 PRIMARY KEY(MACONGTY);

CREATE TABLE LOAIHANG(
	MALOAIHANG VARCHAR(20) NOT NULL,
	TENLOAIHANG NVARCHAR(100) NOT NULL
);
ALTER TABLE LOAIHANG ADD CONSTRAINT PK_MALOAIHANG1 PRIMARY KEY(MALOAIHANG);


CREATE TABLE DONDATHANG(
	SOHOADON VARCHAR(20) NOT NULL,
	MAKHACHHANG VARCHAR(20) NOT NULL,
	MANHANVIEN VARCHAR(20) NOT NULL,
	NGAYDATHANG SMALLDATETIME NOT NULL,
	NGAYGIAOHANG SMALLDATETIME NOT NULL,
	NGAYCHUYENHANG SMALLDATETIME NOT NULL,
	NOIGIAOHANG NVARCHAR(100) NOT NULL
);
ALTER TABLE DONDATHANG ADD CONSTRAINT PK_SOHOADON1 PRIMARY KEY(SOHOADON);
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_MAKHACHHANG1 FOREIGN KEY(MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG);
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_MANHANVIEN1 FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);

CREATE TABLE MATHANG(
	MAHANG VARCHAR(20) NOT NULL,
	TENHANG NVARCHAR(100) NOT NULL,
	MACONGTY VARCHAR(20) NOT NULL,
	MALOAIHANG VARCHAR(20) NOT NULL,
	SOLUONG INT NOT NULL,
	DONVITINH NVARCHAR(20) NOT NULL,
	GIAHANG INT NOT NULL
);
ALTER TABLE MATHANG ADD CONSTRAINT PK_MAHANG1 PRIMARY KEY(MAHANG);
ALTER TABLE MATHANG ADD CONSTRAINT FK_MACONGTY1 FOREIGN KEY(MACONGTY) REFERENCES NHACUNGCAP(MACONGTY);
ALTER TABLE MATHANG ADD CONSTRAINT FK_MALOAIHANG1 FOREIGN KEY(MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG);

CREATE TABLE CHITIETDATHANG(
	SOHOADON VARCHAR(20) NOT NULL,
	MAHANG VARCHAR(20) NOT NULL,
	GIABAN INT NOT NULL,
	SOLUONG INT NOT NULL,
	MUCGIAMGIA INT NOT NULL
);
ALTER TABLE CHITIETDATHANG ADD CONSTRAINT PK_SOHOADON2_MAHANG2 PRIMARY KEY(SOHOADON, MAHANG);
ALTER TABLE CHITIETDATHANG ADD CONSTRAINT FK_MAHANG1 FOREIGN KEY(MAHANG) REFERENCES MATHANG(MAHANG);
ALTER TABLE CHITIETDATHANG ADD CONSTRAINT FK_SOHOADON1 FOREIGN KEY(SOHOADON) REFERENCES DONDATHANG(SOHOADON);

SELECT * FROM KHACHHANG;
SELECT * FROM NHANVIEN;
SELECT * FROM NHACUNGCAP;
SELECT * FROM LOAIHANG;
SELECT * FROM DONDATHANG;
SELECT * FROM MATHANG;
SELECT * FROM CHITIETDATHANG;

go
--A
---Cau 1
CREATE PROCEDURE ThemSinhVienMoi
    @HOSV VARCHAR(50),
    @TENSV VARCHAR(50),
    @MASV VARCHAR(10),
    @PHAI VARCHAR(10),
    @NAMSINH SMALLDATETIME,
    @MAKHOA VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem sinh viên có tồn tại trong bảng SINHVIEN hay chưa
    IF EXISTS (SELECT 1 FROM SINHVIEN WHERE MASV = @MASV)
    BEGIN
        PRINT N'Mã sinh viên đã tồn tại. Vui lòng chọn mã khác.';
        RETURN;
    END

    -- Kiểm tra xem MAKHOA có tồn tại trong bảng KHOA hay không
    IF NOT EXISTS (SELECT 1 FROM KHOA WHERE MAKHOA = @MAKHOA)
    BEGIN
        PRINT N'Mã khoa không tồn tại trong bảng KHOA. Vui lòng kiểm tra lại.';
        RETURN;
    END

    -- Thêm sinh viên mới vào bảng SINHVIEN
    INSERT INTO SINHVIEN (HOSV, TENSV, MASV, PHAI, NAMSINH, MAKHOA)
    VALUES (@HOSV, @TENSV, @MASV, @PHAI, @NAMSINH, @MAKHOA)

    PRINT N'Thêm sinh viên thành công.'
END

EXECUTE ThemSinhVienMoi
    @HOSV = 'Nguyen',
    @TENSV = 'Van Hau',
    @MASV = 'SV001',
    @PHAI = 'Nam',
    @NAMSINH = '2000-01-01',
    @MAKHOA = 'CNTT';

---Cau 2

go

CREATE PROCEDURE ThemSinhVienMoiCoRangBuoc
    @HOSV VARCHAR(50),
    @TENSV VARCHAR(50),
    @MASV VARCHAR(10),
    @PHAI VARCHAR(10),
    @NAMSINH SMALLDATETIME,
    @MAKHOA VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem sinh viên có tồn tại trong bảng SINHVIEN hay chưa
    IF EXISTS (SELECT 1 FROM SINHVIEN WHERE MASV = @MASV)
    BEGIN
        PRINT N'Mã sinh viên đã tồn tại. Vui lòng chọn mã khác.';
        RETURN;
    END

    -- Kiểm tra xem MAKHOA có tồn tại trong bảng KHOA hay không
    IF NOT EXISTS (SELECT 1 FROM KHOA WHERE MAKHOA = @MAKHOA)
    BEGIN
        PRINT N'Mã khoa không tồn tại trong bảng KHOA. Vui lòng kiểm tra lại.';
        RETURN;
    END

    -- Kiểm tra ràng buộc tuổi của sinh viên (lớn hơn hoặc bằng 18 và nhỏ hơn 40)
    DECLARE @CurrentYear INT = YEAR(GETDATE());
    DECLARE @BirthYear INT = YEAR(@NAMSINH);
    DECLARE @Age INT = @CurrentYear - @BirthYear;

    IF @Age < 18 OR @Age >= 40
    BEGIN
        PRINT N'Tuổi của sinh viên phải lớn hơn hoặc bằng 18 và nhỏ hơn 40.';
        RETURN;
    END

    -- Thêm sinh viên mới vào bảng SINHVIEN
    INSERT INTO SINHVIEN (HOSV, TENSV, MASV, PHAI, NAMSINH, MAKHOA)
    VALUES (@HOSV, @TENSV, @MASV, @PHAI, @NAMSINH, @MAKHOA)

    PRINT N'Thêm sinh viên thành công.'
END

EXECUTE ThemSinhVienMoiCoRangBuoc
    @HOSV = 'Nguyen',
    @TENSV = 'Van An',
    @MASV = 'SV003',
    @PHAI = 'Nam',
    @NAMSINH = '2000-01-01',
    @MAKHOA = 'DTVT';

---Cau 3

go

CREATE PROCEDURE ThemKetQuaSinhVien
    @MASV VARCHAR(10),
    @MAMH VARCHAR(10),
    @LANTHI SMALLINT,
    @DIEM SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem SINHVIEN có tồn tại trong bảng SINHVIEN hay không
    IF NOT EXISTS (SELECT 1 FROM SINHVIEN WHERE MASV = @MASV)
    BEGIN
        PRINT N'Mã sinh viên không tồn tại trong bảng SINHVIEN. Vui lòng kiểm tra lại.';
        RETURN;
    END

    -- Kiểm tra xem MONHOC có tồn tại trong bảng MONHOC hay không
    IF NOT EXISTS (SELECT 1 FROM MONHOC WHERE MAMH = @MAMH)
    BEGIN
        PRINT N'Mã môn học không tồn tại trong bảng MONHOC. Vui lòng kiểm tra lại.';
        RETURN;
    END

    -- Thêm kết quả của sinh viên vào bảng KETQUA
    INSERT INTO KETQUA (MASV, MAMH, LANTHI, DIEM)
    VALUES (@MASV, @MAMH, @LANTHI, @DIEM)

    PRINT N'Thêm kết quả của sinh viên thành công.'
END

EXECUTE ThemKetQuaSinhVien
    @MASV = 'S001',
    @MAMH = 'CNTT',
    @LANTHI = 2,
    @DIEM = 9;

---Cau 4

go

create procedure soluongsinhviencuakhoa
	@makhoa varchar(10)
as
begin
	set nocount on;
	--Kiem tra ma khoa co ton tai trong bang Khoa hay khong
	if not exists (select 1 from khoa where makhoa = @makhoa)
	begin
		print N'Mã khoa không tồn tại trong bảng Khoa. Vui lòng kiểm tra lại.';
		return;
	end
	--Lay so luong sinh vien cua khoatu bang sinhvien
	declare @soluongsinhvien int;
	select @soluongsinhvien = count(*) from sinhvien where makhoa = @makhoa;
	print N'Số lượng sinh viên của khoa có mã ' + @makhoa  + ' là: ' + CAST(@soluongsinhvien as varchar);
end

execute soluongsinhviencuakhoa
	@makhoa = 'CNTT';

---Cau 5

go

CREATE PROCEDURE DanhSachSinhVienCuaKhoa
    @MAKHOA VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem MAKHOA có tồn tại trong bảng KHOA hay không
    IF NOT EXISTS (SELECT 1 FROM KHOA WHERE MAKHOA = @MAKHOA)
    BEGIN
        PRINT N'Mã khoa không tồn tại trong bảng KHOA. Vui lòng kiểm tra lại.';
        RETURN;
    END

    -- Lấy danh sách sinh viên của khoa từ bảng SINHVIEN
    SELECT HOSV, TENSV, MASV, PHAI, NAMSINH
    FROM SINHVIEN
    WHERE MAKHOA = @MAKHOA;
END

EXECUTE DanhSachSinhVienCuaKhoa @MAKHOA = 'DTVT';

---Cau 6

go

create procedure thongkesoluongsinhvienmoikhoa
as
begin
	set nocount on
	select makhoa, count(*) as soluongsinhvien
	from sinhvien
	group by makhoa
end

execute thongkesoluongsinhvienmoikhoa

---Cau 7

go

CREATE PROCEDURE XemKetQuaHocTapCuaSinhVien
    @MASV VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem MASV có tồn tại trong bảng SINHVIEN hay không
    IF NOT EXISTS (SELECT 1 FROM SINHVIEN WHERE MASV = @MASV)
    BEGIN
        PRINT N'Mã sinh viên không tồn tại trong bảng SINHVIEN. Vui lòng kiểm tra lại.';
		return;
    END

    -- Lấy kết quả học tập của sinh viên từ bảng KETQUA và MONHOC
    SELECT KQ.MASV, SV.HOSV, SV.TENSV, MH.TENMH, KQ.LANTHI, KQ.DIEM
    FROM KETQUA KQ, MONHOC MH, sinhvien sv
    WHERE kq.masv = sv.masv and kq.mamh = mh.mamh and KQ.MASV = @MASV;
END

EXECUTE XemKetQuaHocTapCuaSinhVien @MASV = 'S001';

---Cau 8

go

CREATE FUNCTION DemSoLuongSinhVienCuaKhoa (@maKhoa VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @soLuongSinhVien INT;

    SELECT @soLuongSinhVien = COUNT(*)
    FROM SINHVIEN
    WHERE MAKHOA = @maKhoa;

    RETURN @soLuongSinhVien
END;

go

DECLARE @maKhoaCanDem VARCHAR(10);
SET @maKhoaCanDem = 'CNTT'; -- Thay 'CNTT' bằng mã khoa cần đếm
SELECT dbo.DemSoLuongSinhVienCuaKhoa(@maKhoaCanDem) AS SoLuongSinhVien;

--B
USE Quanlybanhang;
---Cau 1

go

CREATE PROCEDURE AddNewSupplier
    @MACONGTY VARCHAR(20),
    @TENCONGTY NVARCHAR(100),
    @TENGIAODICH NVARCHAR(100),
    @DIACHI NVARCHAR(100),
    @EMAIL VARCHAR(100),
    @DIENTHOAI VARCHAR(20),
    @FAX VARCHAR(20)
AS
BEGIN
    INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
    VALUES (@MACONGTY, @TENCONGTY, @TENGIAODICH, @DIACHI, @EMAIL, @DIENTHOAI, @FAX);
END;

EXECUTE AddNewSupplier 
    @MACONGTY = 'NCC001',
    @TENCONGTY = N'Tên Công Ty 1',
    @TENGIAODICH = N'Tên Giao Dịch 1',
    @DIACHI = N'Địa chỉ 1',
    @EMAIL = 'email1@example.com',
    @DIENTHOAI = '0123456789',
    @FAX = '0123456789';

---Cau 2

go

CREATE PROCEDURE AddNewItem
    @MAHANG VARCHAR(20),
    @TENHANG NVARCHAR(100),
    @MACONGTY VARCHAR(20),
    @MALOAIHANG VARCHAR(20),
    @SOLUONG INT,
    @DONVITINH NVARCHAR(20),
    @GIAHANG INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM MATHANG WHERE MAHANG = @MAHANG)
    BEGIN
        IF EXISTS (SELECT 1 FROM NHACUNGCAP WHERE MACONGTY = @MACONGTY)
        BEGIN
            IF EXISTS (SELECT 1 FROM LOAIHANG WHERE MALOAIHANG = @MALOAIHANG)
            BEGIN
                INSERT INTO MATHANG (MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
                VALUES (@MAHANG, @TENHANG, @MACONGTY, @MALOAIHANG, @SOLUONG, @DONVITINH, @GIAHANG);
            END
            ELSE
            BEGIN
                RAISERROR ('MALOAIHANG does not exist in LOAIHANG table', 16, 1);
            END
        END
        ELSE
        BEGIN
            RAISERROR ('MACONGTY does not exist in NHACUNGCAP table', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR ('MAHANG already exists in MATHANG table', 16, 1);
    END
END;

EXECUTE AddNewItem 
    @MAHANG = 'MH001',
    @TENHANG = N'Tên Hàng 1',
    @MACONGTY = 'NCC001',
    @MALOAIHANG = 'LH001',
    @SOLUONG = 100,
    @DONVITINH = N'Cái',
    @GIAHANG = 50000;
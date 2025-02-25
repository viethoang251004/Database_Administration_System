USE Quanlysinhvien;

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

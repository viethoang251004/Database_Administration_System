--Bài tập 1
-- Tạo cơ sở dữ liệu
CREATE DATABASE BookStoreDB;
USE BookStoreDB;

-- Tạo bảng NhomSach
CREATE TABLE NhomSach (
    MaNhom CHAR(5) PRIMARY KEY,
    TenNhom NVARCHAR(25)
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    MaNV CHAR(5) PRIMARY KEY,
    HoLot NVARCHAR(25),
    TenNV NVARCHAR(10),
    Phai NVARCHAR(3),
    NgaySinh SMALLDATETIME,
    DiaChi NVARCHAR(40)
);

-- Tạo bảng DanhMucSach
CREATE TABLE DanhMucSach (
    MaSach CHAR(5) PRIMARY KEY,
    TenSach NVARCHAR(40),
    TacGia NVARCHAR(20),
    MaNhom CHAR(5) REFERENCES NhomSach(MaNhom),
    DonGia NUMERIC(5),
    SLTon NUMERIC(5)
);

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHD CHAR(5) PRIMARY KEY,
    NgayBan SMALLDATETIME,
    MaNV CHAR(5) REFERENCES NhanVien(MaNV)
);
ALTER TABLE HoaDon ADD TongTriGia NUMERIC(10, 2);

-- Tạo bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon (
    MaHD CHAR(5) REFERENCES HoaDon(MaHD),
    MaSach CHAR(5) REFERENCES DanhMucSach(MaSach),
    SoLuong NUMERIC(5),
    PRIMARY KEY (MaHD, MaSach)
);

go

---Câu 1
CREATE TRIGGER Trg_Insert_NhomSach
ON NHOMSACH
AFTER INSERT
AS
BEGIN
    DECLARE @RowCount INT
    SELECT @RowCount = COUNT(*) FROM inserted

    PRINT N'Có ' + CAST(@RowCount AS NVARCHAR(10)) + N' mẫu tin được chèn'
END;

go

---Câu 2
CREATE TRIGGER Trg_Insert_HoaDon
ON HOADON
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'HOADON_Luu')
    BEGIN
        CREATE TABLE HOADON_Luu (
            MaHD char(5) PRIMARY KEY,
            NgayBan SmallDatetime,
            MaNV char(5)
        )
    END

    INSERT INTO HOADON_Luu (MaHD, NgayBan, MaNV)
    SELECT MaHD, NgayBan, MaNV
    FROM inserted;
END;

go

---Câu 3
CREATE TRIGGER Trg_InsertUpdateDelete_ChiTietHoaDon
ON ChiTietHoaDon
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    WITH CTE AS (
        SELECT h.MaHD, ISNULL(SUM(d.SoLuong * dm.DonGia), 0) AS TongTriGia
        FROM HoaDon h
        LEFT JOIN ChiTietHoaDon d ON h.MaHD = d.MaHD
        LEFT JOIN DanhMucSach dm ON d.MaSach = dm.MaSach
        GROUP BY h.MaHD
    )
    UPDATE h
    SET h.TongTriGia = c.TongTriGia
    FROM HoaDon h
    INNER JOIN CTE c ON h.MaHD = c.MaHD;
END;

go

---Câu 4
CREATE TRIGGER Trg_InsertUpdate_ChiTietHoaDon
ON ChiTietHoaDon
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN DanhMucSach dm ON i.MaSach = dm.MaSach
        WHERE i.SoLuong <> dm.DonGia
    )
    BEGIN
        RAISERROR (N'SoLuong phải bằng DonGia trong bảng DanhMucSach', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

go

---Câu 5
CREATE TRIGGER Trg_InsertUpdate_HoaDon
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN HOADON h ON i.MaHD = h.MaHD
        WHERE i.NgayBan < h.NgayBan
    )
    BEGIN
        RAISERROR (N'Ngày bán phải lớn hơn hoặc bằng ngày lập hóa đơn', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

go

INSERT INTO NhomSach (MaNhom, TenNhom) VALUES ('N1', 'Nhóm Sách 1');

go

--Bài tập 2
CREATE DATABASE QuanLyThuVien;
USE QuanLyThuVien;

CREATE TABLE DocGia (
    ma_DocGia INT PRIMARY KEY,
    ho NVARCHAR(50),
    tenlot NVARCHAR(50),
    ten NVARCHAR(50),
    ngaysinh DATE
);

CREATE TABLE NguoiLon (
    ma_DocGia INT PRIMARY KEY,
    sonha NVARCHAR(50),
    duong NVARCHAR(50),
    quan NVARCHAR(50),
    dienthoai NVARCHAR(20),
    han_sd DATE
);

CREATE TABLE TreEm (
    ma_DocGia INT PRIMARY KEY,
    ma_DocGia_nguoilon INT,
    FOREIGN KEY (ma_DocGia_nguoilon) REFERENCES NguoiLon(ma_DocGia)
);

CREATE TABLE TuaSach (
    ma_tuasach INT PRIMARY KEY,
    tuasach NVARCHAR(100),
    tacgia NVARCHAR(50),
    tomtat NVARCHAR(500)
);

CREATE TABLE DauSach (
    isbn CHAR(13) PRIMARY KEY,
    ma_tuasach INT,
    ngonngu NVARCHAR(50),
    bia NVARCHAR(50),
    trangthai NVARCHAR(10),
    FOREIGN KEY (ma_tuasach) REFERENCES TuaSach(ma_tuasach)
);

CREATE TABLE CuonSach (
    isbn CHAR(13),
    ma_cuonsach INT PRIMARY KEY,
    tinhtrang NVARCHAR(10),
    FOREIGN KEY (isbn) REFERENCES DauSach(isbn)
);

-- Các dữ liệu mẫu
INSERT INTO TuaSach (ma_tuasach, tuasach, tacgia, tomtat)
VALUES (1, N'Sách A', N'Tác giả A', N'Giới thiệu sách A');

INSERT INTO DauSach (isbn, ma_tuasach, ngonngu, bia, trangthai)
VALUES ('1234567890123', 1, N'Tiếng Việt', N'Bìa mềm', N'Mới');

INSERT INTO CuonSach (isbn, ma_cuonsach, tinhtrang)
VALUES ('1234567890123', 1, N'Yes');

---Câu 1

go

CREATE TRIGGER tg_delMuon
ON Cuonsach
AFTER DELETE
AS
BEGIN
    UPDATE Dausach
    SET trangthai = 'yes'
    FROM Dausach ds
    INNER JOIN deleted d ON ds.isbn = d.isbn;
END;

---Câu 2

go

CREATE TRIGGER tg_insMuon
ON Cuonsach
AFTER INSERT
AS
BEGIN
    UPDATE Dausach
    SET trangthai = 'no'
    FROM Dausach ds
    INNER JOIN inserted i ON ds.isbn = i.isbn;
END;

---Câu 3

go

CREATE TRIGGER tg_updCuonSach
ON Cuonsach
AFTER UPDATE
AS
BEGIN
    UPDATE Dausach
    SET trangthai = i.tinhtrang
    FROM Dausach ds
    INNER JOIN inserted i ON ds.isbn = i.isbn;
END;

---Câu 4

go

CREATE TRIGGER tg_InfThongBao
ON Tuasach
AFTER INSERT, UPDATE
AS
BEGIN
    PRINT N'Đã thêm mới tựa sách';
END;

---Câu 5

go

CREATE TRIGGER tg_SưaSach
ON Tuasach
AFTER UPDATE
AS
BEGIN
    DECLARE @UpdatedTitles NVARCHAR(MAX) = '';
    DECLARE @NewAuthors NVARCHAR(MAX) = '';
    DECLARE @OldAuthors NVARCHAR(MAX) = '';

    SELECT @UpdatedTitles += CAST(ma_tuasach AS NVARCHAR(50)) + ', '
    FROM inserted;

    SELECT @NewAuthors += CAST(ma_tuasach AS NVARCHAR(50)) + ' - ' + tacgia + ', '
    FROM inserted;

    SELECT @OldAuthors += CAST(ma_tuasach AS NVARCHAR(50)) + ' - ' + tacgia + ', '
    FROM deleted;

    IF LEN(@UpdatedTitles) > 0
    BEGIN
        PRINT N'Danh sách mã các tựa sách vừa được sửa: ' + LEFT(@UpdatedTitles, LEN(@UpdatedTitles) - 1);
    END;

    IF LEN(@NewAuthors) > 0
    BEGIN
        PRINT N'Danh sách mã tựa sách vừa được sửa và tên tác giả mới: ' + LEFT(@NewAuthors, LEN(@NewAuthors) - 1);
    END;

    IF LEN(@OldAuthors) > 0
    BEGIN
        PRINT N'Danh sách mã tựa sách vừa được sửa và tên tác giả cũ: ' + LEFT(@OldAuthors, LEN(@OldAuthors) - 1);
    END;

    IF LEN(@NewAuthors) > 0 AND LEN(@OldAuthors) > 0
    BEGIN
        PRINT N'Danh sách mã tựa sách vừa được sửa cùng tên tác giả cũ và tác giả mới:';
        
        SELECT @UpdatedTitles = '';
        SELECT @UpdatedTitles += CAST(ma_tuasach AS NVARCHAR(50)) + ' - ' + tacgia + ', '
        FROM inserted;

        PRINT @UpdatedTitles;
    END;
END;

---Câu 6

go

CREATE TRIGGER tg_KiemTraTrung
ON Tuasach
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Tuasach t
        WHERE t.tuasach = (SELECT tuasach FROM inserted) AND t.ma_tuasach <> (SELECT ma_tuasach FROM inserted)
    )
    BEGIN
        PRINT N'Tựa sách trùng tên với tựa sách đã có trong CSDL';
        ROLLBACK;
    END;
END;

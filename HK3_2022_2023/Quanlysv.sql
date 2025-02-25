create database Quanlysv;
use Quanlysv;
drop database Quanlysv
ALTER DATABASE Quanlysv SET OFFLINE WITH ROLLBACK IMMEDIATE;

-- Xem các kết nối đang sử dụng cơ sở dữ liệu
SELECT *
FROM sys.sysprocesses
WHERE DB_NAME(dbid) = 'Quanlysv';

-- Xem người dùng đang sử dụng cơ sở dữ liệu
USE master;
SELECT *
FROM sys.sysdatabases
WHERE name = 'Quanlysv';

create table dmkhoa (
	makhoa char(2) not null,
	tenkhoa nvarchar(50) not null
);
drop table dmkhoa;
alter table dmkhoa add constraint pk_makhoa_dmkhoa primary key(makhoa);


create table dmmh (
	mamh char(2) not null,
	tenmh nvarchar(30) not null,
	sotiet tinyint not null
);
alter table dmmh add constraint pk_mamh_dmmh primary key(mamh);

create table dmsv (
	masv char(3) not null,
	hosv nvarchar(30) not null,
	tensv nvarchar(10) not null,
	phai bit not null,
	ngaysinh datetime not null,
	noisinh nvarchar(25) not null,
	makhoa char(2) not null,
	hocbong float
);
alter table dmsv add constraint pk_masv_dmsv primary key(masv);
alter table dmsv add constraint fk_makhoa_dmsv foreign key(makhoa) references dmkhoa(makhoa);

create table ketqua (
	masv char(3) not null,
	mamh char(2) not null,
	lanthi tinyint not null,
	diem decimal(4, 2) not null
);
alter table ketqua add constraint pk_masv_mamh_lanthi_ketqua primary key(masv, mamh, lanthi);
alter table ketqua add constraint fk_masv_ketqua foreign key(masv) references dmsv(masv);
alter table ketqua add constraint fk_mamh_ketqua foreign key(mamh) references dmmh(mamh);

go
--Bai tap ham
--1)
CREATE FUNCTION dbo.GetStudentBirthInfo
(
    @masv CHAR(3)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        hosv + ' ' + tensv AS FullName,
        ngaysinh AS BirthDate,
        CASE DATEPART(WEEKDAY, ngaysinh)
            WHEN 1 THEN N'Chủ nhật'
            WHEN 2 THEN N'Thứ hai'
            WHEN 3 THEN N'Thứ ba'
            WHEN 4 THEN N'Thứ tư'
            WHEN 5 THEN N'Thứ năm'
            WHEN 6 THEN N'Thứ sáu'
            WHEN 7 THEN N'Thứ bảy'
        END AS DayOfWeek
    FROM
        dmsv
    WHERE
        masv = @masv
);

go
--2)
CREATE FUNCTION dbo.GetStudentsWithLowAverage()
RETURNS @ResultTable TABLE (
    masv CHAR(3),
    hoten NVARCHAR(40),
    namsinh INT,
    diemtb DECIMAL(4, 1)
)
AS
BEGIN
    INSERT INTO @ResultTable
    SELECT
        dmsv.masv,
        CONCAT(dmsv.hosv, ' ', dmsv.tensv) AS hoten,
        YEAR(dmsv.ngaysinh) AS namsinh,
        AVG(ketqua.diem) AS diemtb
    FROM
        dmsv
    INNER JOIN
        ketqua ON dmsv.masv = ketqua.masv
    GROUP BY
        dmsv.masv, dmsv.hosv, dmsv.tensv, dmsv.ngaysinh
    HAVING
        AVG(ketqua.diem) < 5.0;
    
    RETURN;
END;

go
--3)
CREATE FUNCTION dbo.GetClassInfoFromStudentID
(
    @masv CHAR(3)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ketqua.masv,
        dmkhoa.makhoa AS malop,
        dmkhoa.tenkhoa AS tenlop
    FROM
        ketqua
    INNER JOIN
        dmsv ON ketqua.masv = dmsv.masv
    INNER JOIN
        dmkhoa ON dmsv.makhoa = dmkhoa.makhoa
    WHERE
        ketqua.masv = @masv
);

go
--4)
CREATE FUNCTION dbo.GetAverageScoreBySubject
(
    @mamh CHAR(2)
)
RETURNS DECIMAL(4, 2)
AS
BEGIN
    DECLARE @average DECIMAL(4, 2);

    SELECT @average = AVG(diem)
    FROM ketqua
    WHERE mamh = @mamh;

    RETURN @average;
END;

go
--5)
CREATE FUNCTION dbo.GetClassInfoFromStudentID1
(
    @masv CHAR(3)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ketqua.masv,
        dmkhoa.makhoa AS malop,
        dmkhoa.tenkhoa AS tenlop
    FROM
        ketqua
    INNER JOIN
        dmsv ON ketqua.masv = dmsv.masv
    INNER JOIN
        dmkhoa ON dmsv.makhoa = dmkhoa.makhoa
    WHERE
        ketqua.masv = @masv
);

go

select * from dmkhoa;
select * from dmmh;
select * from dmsv;
select * from ketqua;

go

--Bai tap stored procedure
--1)
CREATE PROCEDURE dbo.GetStudentCountByDepartment
    @makhoa CHAR(2)
AS
BEGIN
    DECLARE @studentCount INT;

    SELECT @studentCount = COUNT(*)
    FROM dmsv
    WHERE makhoa = @makhoa;

    PRINT 'So luong sinh vien cua khoa ' + @makhoa + ': ' + CAST(@studentCount AS VARCHAR);
END;

DROP PROCEDURE dbo.GetStudentCountByDepartment

go

DECLARE @makhoa CHAR(2);
SET @makhoa = 'cn';
EXEC dbo.GetStudentCountByDepartment @makhoa;

go

--2)
CREATE PROCEDURE dbo.GetStudentsByDepartment
    @makhoa CHAR(2)
AS
BEGIN
    SELECT *
    FROM dmsv
    WHERE makhoa = @makhoa;
END;

go

DECLARE @makhoa CHAR(2);
SET @makhoa = 'dt';
EXEC dbo.GetStudentsByDepartment @makhoa;

go

--3)
CREATE PROCEDURE dbo.CountStudentsByDepartment
AS
BEGIN
    SELECT makhoa, COUNT(*) AS TotalStudents
    FROM dmsv
    GROUP BY makhoa;
END;

go

EXEC dbo.CountStudentsByDepartment;

go

--4)
CREATE PROCEDURE dbo.GetStudentResults
    @masv CHAR(3)
AS
BEGIN
    SELECT dmsv.masv, dmsv.hosv, dmsv.tensv, dmmh.tenmh, ketqua.lanthi, ketqua.diem
    FROM dmsv
    INNER JOIN ketqua ON dmsv.masv = ketqua.masv
    INNER JOIN dmmh ON ketqua.mamh = dmmh.mamh
    WHERE dmsv.masv = @masv;
END;

go

DECLARE @studentID CHAR(3);
SET @studentID = '002';
EXEC dbo.GetStudentResults @studentID;

go

--5)
CREATE PROCEDURE dbo.CountStudentsByDepartment1
    @makhoa CHAR(2)
AS
BEGIN
    DECLARE @count INT;
    
    SELECT @count = COUNT(*)
    FROM dmsv
    WHERE makhoa = @makhoa;
    
    SELECT @count AS StudentCount;
END;

go

DECLARE @departmentID CHAR(2);
SET @departmentID = 'cn';
EXEC dbo.CountStudentsByDepartment1 @departmentID;

go
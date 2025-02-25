Create database Quanlysinhvien
Use Quanlysinhvien

Create table khoa
(
	makhoa varchar(10) primary key,
	tenkhoa nvarchar(50) not null
)


Create table sinhvien
(
	hosv	nvarchar(50) not null,
	tensv	nvarchar(10) not null,
	masv	varchar(10) primary key,
	ngaysinh smalldatetime not null,
	phai	nvarchar(5) not null,
	makhoa	varchar(10)
)
Alter table sinhvien add constraint fk_sv_khoa foreign key(makhoa) references khoa(makhoa)

Create table monhoc
(
	tenmh	nvarchar(50) not null,
	mamh	varchar(10) primary key,
	sotiet	int not null
)


Create table ketqua
(
	masv varchar(10),
	mamh	varchar(10),
	lanthi	int,
	diem int,
	primary key(masv,mamh,lanthi)
)
Alter table ketqua add constraint fk_kq_sv foreign key(masv) references sinhvien(masv)
Alter table ketqua add constraint fk_kq_mh foreign key(mamh) references monhoc(mamh)


Insert into khoa values('AVAN', 'Khoa anh Van')
Insert into khoa values('CNTT', 'Cong nghe thong tin')
Insert into khoa values('DTVT', 'Dien tu vien thong')
Insert into khoa values('QTKD', 'Quan tri kinh doanh')

Insert into monhoc values('Anh van', 'AV', 45)
Insert into monhoc values('co so du lieu', 'CSDL', 45)
Insert into monhoc values('Ky thuat lap trinh', 'KTLT', 60)
Insert into monhoc values('Ke toan tai chinh', 'KTTC', 45)
Insert into monhoc values('Toan cao cap', 'TCC', 60)
Insert into monhoc values('Tin hoc van phong', 'THVP', 30)
Insert into monhoc values('Tri tue nhan tao', 'TTTNT', 45)

Insert into sinhvien values('Tran Minh', 'Son', 'S001', '5/1/1985', 'Nam', 'CNTT')
Insert into sinhvien values('Nguyen Quoc', 'Bao', 'S002', '6/15/1986', 'Nam', 'CNTT')
Insert into sinhvien values('Phan Anh', 'Tung', 'S003', '12/20/1983', 'Nam', 'QTKD')
Insert into sinhvien values('Bui thi Anh', 'Thu', 'S004', '2/1/1985', 'Nu', 'QTKD')
Insert into sinhvien values('Le Thi Lan', 'Anh', 'S005', '7/3/1987', 'Nu', 'DTVT')
Insert into sinhvien values('Nguyen Thi', 'Lam', 'S006', '11/25/1984', 'Nu', 'DTVT')
Insert into sinhvien values('Phan thi', 'Ha', ' S007', '7/3/1988', 'Nu', 'CNTT')
Insert into sinhvien values('Tran The', 'Dung', 'S008', '10/21/1985', 'Nam', 'CNTT')

Insert into ketqua values('S001', 'CSDL', 1, 4)
Insert into ketqua values('S001', 'TCC', 1, 6)
Insert into ketqua values('S002', 'CSDL', 1, 3)
Insert into ketqua values('S002', 'CSDL', 2, 6)
Insert into ketqua values('S003', 'KTTC', 1, 5)
Insert into ketqua values('S004', 'AV', 1, 8)
Insert into ketqua values('S004', 'THVP', 1, 4)
Insert into ketqua values('S004', 'THVP', 2, 8)
Insert into ketqua values('S006', 'TCC', 1, 5)
Insert into ketqua values('S007', 'AV', 1, 2)
Insert into ketqua values('S007', 'AV', 2, 9)
Insert into ketqua values('S007', 'KTLT', 1, 6)
Insert into ketqua values('S008', 'AV', 1, 7)

Select * from khoa
Select * from monhoc
Select * from ketqua
Select * from sinhvien

--1
Create proc cau1 @hosv nvarchar(50), @tensv nvarchar(10), @masv varchar(10), @ns smalldatetime, @phai nvarchar(5), @mk varchar(10)
As
Begin	
	Insert into sinhvien values(@hosv,@tensv,@masv,@ns,@phai,@mk)
End
Execute cau1 N'Nguyen Dinh Viet', N'Hoang', 'SV001', '25/10/2004', N'Nam', 'CNTT'

--2
Create proc cau2 @hosv nvarchar(50), @tensv nvarchar(10), @masv varchar(10), @ns smalldatetime, @phai nvarchar(5), @mk varchar(10)
As
Begin
	Declare @tuoi int = year(getdate()) - year(@ns)
	--Ktra tuoi
	if @tuoi >= 18 and @tuoi < 40
	Begin
		if (Select masv from sinhvien where @masv = masv)=0
		Begin
			if (Select count(*) from khoa where @mk = makhoa)=1
			Begin
				Insert into sinhvien values(@hosv,@tensv,@masv,@ns,@phai,@mk)
			End
			else
				print N'Không tồn tại mã khoa'
			Return
		End
		else
			print N'Mã sv đã tồn tại'
		Return
	End
	Else
		print N'Tuổi không hợp lệ'
	Return
End
Execute cau2 N'Do Hoang', N'Dung', 'S010', '06/06/2001', N'Nam', 'QTKD'

--3
Create proc cau3 @masv varchar(10), @mamh varchar(10), @lt int, @diem float
As
Begin
	if (Select count(*) from sinhvien where @masv = masv) = 1
	Begin
		if (Select count(*) from monhoc where @mamh = mamh) = 1
		Begin
			Insert into ketqua values(@masv,@mamh,@lt,@diem)
		End
		Else
			print N'Khong ton tai mon hoc'
		Return
	End
	Else
		print N'Khong ton tai masv'
	Return
End
Execute cau3 'SV001', 'CSDL', 1, 7.5

--4
Create proc cau4 @mk varchar(10)
As
Begin 
	Select count(*) 
	From sinhvien
	Where @mk = makhoa
End
Execute cau4 'CNTT'

--5
Create function cau5 (@mk varchar(10))
Returns table
as
	Return (Select *
			From sinhvien
			Where @mk = makhoa)
Select * from cau5('CNTT')

--6
Create function cau6()
Returns table
as
	Return(Select k.makhoa, tenkhoa, count(*) as N' So luong sv'
			From khoa k, sinhvien s
			Where s.makhoa = k.makhoa
			Group by k.makhoa, tenkhoa)
Select * from cau6()

--7
Create function cau7 (@masv varchar(10))
Returns table
As
	Return (Select * 
			From ketqua
			Where @masv = masv)
Select * from cau7('S002')

--8
Create function cau_8 (@mk varchar(10))
Returns int
As
Begin
	Declare @slsv int

	Select @slsv = count(*)
	From sinhvien
	Where @mk = makhoa

	Return @slsv
End
print dbo.cau_8('CNTT')

--B.1
Create proc caub1 @mact varchar(3), @tenct nvarchar(50), @tengd nvarchar(50), @dc nvarchar(20), @dt varchar(10), @fax varchar(20), @email varchar(20)
As
Begin
	Insert into nhacungcap values(@mact,@tenct,@tengd,@dc,@dt,@fax,@email)
End
Execute caub1 'CT1', N'Cong ty A', N'Giao dich A', N'TpHCM', '0838895156', '', '522H0120@student.tdtu.edu.vn'

--B.2
Create proc caub2 @mamh varchar(5), @ten nvarchar(20), @mact varchar(3), @maloai varchar(3)
As
Begin
	If @mamh not in (Select mahang from Mathang) and @mact not in (Select macongty from nhacungcap)
	Begin
		Insert into Mathang values (@mamh,@ten,@mact,@maloai)
		Print N'Thêm thành công'
	End
	Else
		Print N'Trùng mamh hoặc mact không tồn tại'
End

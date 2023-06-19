create database QLKS1
--drop database QLKS
GO

Use QLKS1
GO
create table TAIKHOAN
(
	Username nvarchar(50) primary key not null,
	password nvarchar(50) not null
)
CREATE TABLE DANHMUCPHONG
(
	MaPhong int PRIMARY KEY,
	MaLoaiPhong varchar(4) NOT NULL,
	TenPhong nvarchar(50) NOT NULL,
	TinhTrangPhong nvarchar(50) NOT NULL default N'Trống'
)
ALTER TABLE DANHMUCPHONG
   ADD CONSTRAINT FK_DANHMUCPHONG_LOAIPHONG_PK FOREIGN KEY (MaLoaiPhong)
      REFERENCES dbo.LOAIPHONG (MaLoaiPhong)
;
-- drop table DANHMUCPHONG
GO

CREATE TABLE LOAIPHONG
(
	MaLoaiPhong varchar(4) PRIMARY KEY,
	TenLoaiPhong nvarchar(50) NOT NULL,
	DonGia int NOT NULL
)
-- drop table LOAIPHONG
GO

CREATE TABLE LOAIKHACHHANG
(
	MaLoaiKhach varchar(4) PRIMARY KEY,
	TenLoaiKhach nvarchar(50) NOT NULL,
	HeSoPhuThu float NOT NULL
)
-- drop table LOAIKHACHHANG
GO

CREATE TABLE PHIEUTHUEPHONG
(
	MaPhieuThuePhong int PRIMARY KEY,
	MaPhong int NOT NULL,
	DonGiaThue1Ngay float NOT NULL,
	SoKhachTrongPhong int NOT NULL,
	NgayBatDauThue date NOT NULL default getdate()
	foreign key (MaPhong) references dbo.DANHMUCPHONG(MaPhong),
	foreign key (SoKhachTrongPhong) references dbo.TILEPHUTHU(KhachThuBaoNhieu)
)
-- drop table PHIEUTHUEPHONG
GO

CREATE TABLE CT_PHIEUTHUEPHONG
(
	MaPhieuThuePhong int,
	MaLoaiKhach varchar(4),
	CMND nchar(10) NOT NULL,
	TenKhachHang nvarchar(50) NOT NULL,
	DiaChi nvarchar(50) NOT NULL
	Constraint CT_PHIEUTHUEPHONG_pk PRIMARY KEY (MaPhieuThuePhong,MaLoaiKhach)
	FOREIGN KEY (MaLoaiKhach) references dbo.LOAIKHACHHANG(MaLoaiKhach),
	foreign key (MaPhieuThuePhong) references dbo.PHIEUTHUEPHONG(MaPhieuThuePhong)
)

GO
/*Drop TABLE CT_PHIEUTHUEPHONG*/

CREATE TABLE TILEPHUTHU
(
	KhachThuBaoNhieu int PRIMARY KEY ,
	TiLePhuThu float NOT NULL
)
-- drop table TILEPHUTHU
GO

CREATE TABLE HOADON
(
	MaHoaDon int PRIMARY KEY,
	TenKhachHangThanhToan nvarchar(50) NOT NULL,
	DiaChi nvarchar(50) NOT NULL,
	NgayThanhToan date NOT NULL default getdate(),
	TriGia float NOT NULL
)
-- drop table HOADON
GO

CREATE TABLE CT_HOADON
(
	MaPhieuThuePhong int,
	MaHoaDon int,
	SoNgayThue int NOT NULL,
	SoTienPhaiTra float NOT NULL
	CONSTRAINT CT_HOADON_pk PRIMARY KEY (MaPhieuThuePhong,MaHoaDon)
	FOREIGN KEY (MaPhieuThuePhong) references dbo.PHIEUTHUEPHONG(MaPhieuThuePhong),
	Foreign key (MaHoaDon) references dbo.HOADON(MaHoaDon)
)
-- drop table CT_HOADON
GO

CREATE TABLE BAOCAODOANHTHUTHANG
(
	MaBCDTT int PRIMARY KEY,
	Thang date NOT NULL,
	Nam date NOT NULL,
	TongDoanhThu float NOT NULL default 0,
)
-- drop table BAOCAODOANHTHUTHANG
GO

CREATE TABLE CT_BAOCAODOANHTHUTHANG
(
	MaCTBKDTT int primary key,
	MaBCDTT int NOT NULL,
	MaHoaDon int NOT NULL,
	Thang date NOT NULL,
	Nam date NOT NULL,
	MaLoaiPhong varchar(4) NOT NULL,
	DoanhThu float NOT NULL default 0,
	TiLe float
	foreign key (MaBCDTT) references dbo.BAOCAODOANHTHUTHANG(MaBCDTT),
	foreign key (MaHoaDon) references dbo.HOADON(MaHoaDon)
)
-- drop table CT_BAOCAODOANHTHUTHANG
GO

CREATE TABLE THAMSO
(
	SoKhachToiDa int NOT NULL,
	SoKhachKhongTinhPhuThu int NOT NULL
)
-- drop table THAMSO
GO
alter table DANHMUCPHONG
drop constraint FK_DANHMUCPHONG_LOAIPHONG_PK

insert into dbo.TAIKHOAN(Username,password)
values (N'Nhom3',20521495)
insert into dbo.TAIKHOAN(Username,password)
values (N'Kiet',20521495)
insert into dbo.TAIKHOAN(Username,password)
values (N'Tri',20521495)
insert into dbo.TAIKHOAN(Username,password)
values (N'Minh',20521495)
go

create proc USP_GetListAccount
@Username nvarchar(50)
as
begin
select * from dbo.TAIKHOAN where @Username = Username
end
go

exec USP_GetListAccount @Username = 'Nhom3'


select * from TAIKHOAN


-- Thêm phòng
declare @room int = 1
while @room<= 10
begin 
	insert dbo.DANHMUCPHONG(MaPhong,TenPhong,MaLoaiPhong,TinhTrangPhong)
	Values (@room,N'Phòng A'+cast(@room as nvarchar(50)),N'A',N'Trống')
	set @room =@room+1
end


declare @roomb int = 11
while @roomb<= 20
begin 
	insert dbo.DANHMUCPHONG(MaPhong,TenPhong,MaLoaiPhong,TinhTrangPhong)
	Values (@roomb,N'Phòng B'+cast(@roomb as nvarchar(50)),N'B',N'Trống')
	set @roomb =@roomb+1
end

declare @roomc int = 21
while @roomc<= 30
begin 
	insert dbo.DANHMUCPHONG(MaPhong,TenPhong,MaLoaiPhong,TinhTrangPhong)
	Values (@roomc,N'Phòng C'+cast(@roomc-20 as nvarchar(50)),N'C',N'Trống')
	set @roomc=@roomc+1
end

select * from DANHMUCPHONG
go

create proc USP_GetRoomList
AS Select * From DANHMUCPHONG
Go

update danhmucphong set TinhTrangPhong = N'Có người' where MaLoaiPhong='A'
go
-- Thêm loại khách hàng
insert into LOAIKHACHHANG(MaLoaiKhach,TenLoaiKhach,HeSoPhuThu) values (N'IN',N'Khách nội địa',1.0) 
insert into LOAIKHACHHANG(MaLoaiKhach,TenLoaiKhach,HeSoPhuThu) values (N'OUT',N'Khách ngoại địa',1.5) 
go
select * from LOAIKHACHHANG

-- Thêm tỉ lệ phụ thu
insert into TILEPHUTHU(KhachThuBaoNhieu,TiLePhuThu) values (2,1.0)
insert into TILEPHUTHU(KhachThuBaoNhieu,TiLePhuThu) values (3,1.25)
select * from TILEPHUTHU

-- Thêm loại phòng
insert into LOAIPHONG(MaLoaiPhong,TenLoaiPhong,DonGia) values (N'A',N'Loại phòng A',150000)
insert into LOAIPHONG(MaLoaiPhong,TenLoaiPhong,DonGia) values (N'B',N'Loại phòng B',170000)
insert into LOAIPHONG(MaLoaiPhong,TenLoaiPhong,DonGia) values (N'C',N'Loại phòng C',200000)
select * from LOAIPHONG


-- Thêm phiếu thuê phòng
Insert PHIEUTHUEPHONG(MaPhieuThuePhong,MaPhong,DonGiaThue1Ngay,SoKhachTrongPhong,NgayBatDauThue)
values (1,1,170000,2,getdate())
Insert PHIEUTHUEPHONG(MaPhieuThuePhong,MaPhong,DonGiaThue1Ngay,SoKhachTrongPhong,NgayBatDauThue)
values (2,2,170000,2,getdate())
Insert PHIEUTHUEPHONG(MaPhieuThuePhong,MaPhong,DonGiaThue1Ngay,SoKhachTrongPhong,NgayBatDauThue)
values (3,3,170000,2,getdate())
Insert PHIEUTHUEPHONG(MaPhieuThuePhong,MaPhong,DonGiaThue1Ngay,SoKhachTrongPhong,NgayBatDauThue)
values (4,4,170000,2,getdate())

select * from PHIEUTHUEPHONG
select * from PHIEUTHUEPHONG where MaPhong =N'A1'
-- Thêm chi tiết phiếu thuê
Insert CT_PHIEUTHUEPHONG(MaPhieuThuePhong,MaLoaiKhach,CMND,TenKhachHang,DiaChi)
values (1,N'IN',12345,N'Kiệt',N'ktx')
Insert CT_PHIEUTHUEPHONG(MaPhieuThuePhong,MaLoaiKhach,CMND,TenKhachHang,DiaChi)
values (2,N'OUT',123453,N'Kiệt',N'ktxkhua')
Insert CT_PHIEUTHUEPHONG(MaPhieuThuePhong,MaLoaiKhach,CMND,TenKhachHang,DiaChi)
values (3,N'IN',123454,N'Kiệt',N'ktxkhub')
Insert CT_PHIEUTHUEPHONG(MaPhieuThuePhong,MaLoaiKhach,CMND,TenKhachHang,DiaChi)
values (3,N'OUT',1234,N'Kiệt2',N'ktxkhubc')
Insert CT_PHIEUTHUEPHONG(MaPhieuThuePhong,MaLoaiKhach,CMND,TenKhachHang,DiaChi)
values (4,N'IN',123456,N'Kiệt',N'ktxkhuc')
select * from CT_PHIEUTHUEPHONG

select * from CT_PHIEUTHUEPHONG where MaPhieuThuePhong = N'M001'

select * from HOADON
insert HOADON(MaHoaDon, TenKhachHangThanhToan, DiaChi, TriGia)
values (1, N'Kiệt', N'ktx', 340000)
insert HOADON(MaHoaDon, TenKhachHangThanhToan, DiaChi, TriGia)
values (2, N'Kiệt', N'ktxkhua', 340000)
insert HOADON(MaHoaDon, TenKhachHangThanhToan, DiaChi, TriGia)
values (3, N'Kiệt', N'ktxkhub', 340000)


insert CT_HOADON(MaPhieuThuePhong, MaHoaDon, SoNgayThue, SoTienPhaiTra)
values (1, 1, 2, 340000)
insert CT_HOADON(MaPhieuThuePhong, MaHoaDon, SoNgayThue, SoTienPhaiTra)
values (2, 2, 2, 340000)
insert CT_HOADON(MaPhieuThuePhong, MaHoaDon, SoNgayThue, SoTienPhaiTra)
values (3, 3, 2, 340000)

select * from HOADON
select * from CT_HOADON
select * from PHIEUTHUEPHONG
select * from CT_PHIEUTHUEPHONG
select *  from DANHMUCPHONG
Update dbo.DANHMUCPHONG SET TinhTrangPhong = N'Đang sửa chữa' where MaLoaiPhong='A'
go
select * from dbo.DANHMUCPHONG
select * from LOAIPHONG
select *from LOAIKHACHHANG
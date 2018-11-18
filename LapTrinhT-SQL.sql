-- Lập trình T-SQL

decalare @LuongLN int, @Luongnn int, @tongluong int
select @LuongLN = MAX(Luong), @luongnn=Min(luong), @tongluong=sum(luong)
from NhanVien
where MaPB = 'PB01'
print 'Luong lon nhat la'+convert(varchar(10), @luongLN)
print 'Tong luong la' + convert(@tongluong as varchar)

-- IF
select MaNV, MaPB, MaNQL, iif (GioiTinh = 'Nam', 1, 0) as gioitinh, Luong
from NhanVien
-- CASE
select MaNV, HoTen, MaPB, MaNQL, (CASE GioiTinh when 'Nam' then 1
												when N'Nữ' then 0
												else 2 end) as gioitinh
from NhanVien 

/* Trigger */
-- Thêm nv vào bảng NhanVien 
alter trigger themnv on NhanVien for insert
as
begin
	declare @Ma char(10)
	select @Ma = MaNV from inserted
	print 'Ma nhan vien vua them la'+@ma
end
-- Vô hiệu hóa Trigger
disable trigger 
-- Thực Thi
select * from NhanVien
insert into NhanVien(MaNV, HoTen) values('nv9',N'Khuất Duy Tiến')
-- Update
update NhanVien
set HoTen=N'Trần Đình Đồng'
where MaNV='nv9'
-- Tao trigger xoa di thong tin nhan vien nao do
alter trigger XoaNV on NhanVien instead of delete
as
begin
	declare @Ma char(10)
	select @Ma = MaNV from deleted
	delete from PhanCong where MaNV=@Ma
	delete from ThanNhan where MaNV=@Ma
	update PhongBan set MaTP=NULL where MaTP=@Ma
	delete NhanVien where MaNV=@Ma 
end

delete from NhanVien where MaNV='nv9'

-- Tạo trigger để tự động cập nhật cho trường số nhân viên trong bảng PhongBan khi add, edit, delete NV trong bảng NhanVien
create trigger XoaNV_CapNhat on NhanVien for insert, delete, update
as
begin
	declare @mapb char(10)
	select @mapb= MaPB from inserted
	update PhongBan set TongNV=TongNV+1 where MaPB=@mapb
	set @mapb=NULL
	select @mapb = MaPB from deleted
	update PhongBan set TongNV=TongNV-1 where MaPB=@mapb
	set @mapb=NULL
	-- di chuyen nhan vien thi tong so nhan vien khong thay doi
end
select * from PhongBan
delete from NhanVien where MaNV='nv9'

create trigger CapNhatTSNV on NhanVien for insert, update, delete
as
begin
	declare @mapb char(10)
	select @mapb=MaPB from inserted
	update PhongBan set TongNV=(select count (MaNV) from NhanVien where MaPB=@mapb) where MaPB=@mapb
	select @mapb=MaPB from deleted
	update PhongBan set TongNV=(select count (MaNV) from NhanVien where MaPB=@mapb) where MaPB=@mapb
end

update NhanVien set MaPB='pb1' where MaPB='pb2'

-- Con trỏ
-- VD1:
declare Tro cursor scroll
	for select * from NhanVien order by HoTen
open Tro
fetch first from Tro
while (@@FETCH_STATUS=0)
begin	
	fetch next from Tro
end  
--VD2: Tạo thủ tục sử dụng con trỏ để đánh số báo danh cho các nhân viên thi chứng chỉ ngoại ngữ. nhân viên tham gia thi ddc lưu trong bảng danh sách gồm: SBD, MaNV, Hoten, NgaySinh. Yêu cầu SBD có định dạng SBD+số thứ tự.
drop table danhsach
Begin
create table danhsach(sobd char(10),manv char(10), hoten nvarchar(50))
declare @ma char(10), @ten nvarchar(50),@ns datetime,@i int
set @i=1
DECLARE cur_tro CURSOR FORWARD_ONLY FOR SELECT MaNV, HoTen from
NhanVien
OPEN cur_tro
WHILE 0=0--@@FETCH_STATUS=0
BEGIN
FETCH NEXT FROM cur_tro
INTO @ma,@ten
IF @@FETCH_STATUS<>0
BREAK
insert into danhsach values('SBD'+convert(char(7),@i),@ma,@ten)
set @i=@i+1
end
CLOSE cur_tro
DEALLOCATE cur_tro
End

select * from danhsach

-- Them truong tong so gio vao bang du an su dung con tro cap nhat lai gia tri cho truong tong so gio
ALTER TABLE DuAn ADD tongsogio int

DECLARE @ma char(10),@tsg int
DECLARE troda CURSOR FORWARD_ONLY
FOR Select MaDA,sum(SoGio)
From PhanCong
Group by MaDA
OPEN troda
FETCH FIRST FROM troda into @ma,@tsg
WHILE @@FETCH_STATUS=0
BEGIN
update DuAn set tongsogio =@tsg where MaDA=@ma
Print N' Đang cập nhật mã dự án '+@ma
FETCH NEXT FROM troda INTO @ma,@tsg
END

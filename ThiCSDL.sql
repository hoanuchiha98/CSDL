/*20 Câu Truy Vấn SQL đơn giản và Đại số Quan hệ*/

--1. Đưa ra mã lớp, tên lớp học phần, Sĩ số, Mã môn học của Lớp học phần
select MaLop, TenLopHocPhan, SiSo, MaMonHoc
from LopHocPhan
--2. Đưa ra Mã giáo viên, Tên giáo viên, Mã lịch thực hành tương ứng và chưa đăng ký thực hành
select gv.MaGiaoVien, TenGiaoVien, MaLichThucHanh 
from GiaoVien gv left join LichThucHanh lth
on gv.MaGiaoVien=lth.MaGiaoVien
--3. Đưa ra Mã nhân viên, Tên nhân viên, SĐT của Nhân viên
select MaNhanVien, TenNhanVien, SDT
from NhanVien
--4. Đưa ra Mã phiếu nhập, Ngày nhập của Phiếu nhập
select MaPhieuNhap, NgayNhap
from PhieuNhap
--5. Đưa ra Tiết bắt đầu, Tiết kết thúc, Ngày, Nội dung thực hành
select TietBatDau, TietKetThuc, Ngay, NoiDungThucHanh
from ChiTietLichThucHanh
--6. Đưa ra Mã lớp, Tên lớp học phần có sĩ số lớn hơn 70
select MaLop, TenLopHocPhan, SiSo
from LopHocPhan
where SiSo>70
--7. Đưa ra Mã Lịch thực hành, Số buổi, Mã lớp, Mã giáo viên có số buổi nhỏ hơn 8
select MaLichThucHanh, SoBuoi, MaLop, MaGiaoVien
from LichThucHanh
where SoBuoi<8
--8. Đưa ra STT, Mã phiếu nhập, Số lượng của máy tính có tình trạng là Tốt khi nhập
select STT, MaPhieuNhap, SoLuong
from NhapMayTinh
where TinhTrang = N'Tốt'
--9. Đưa ra Mã phòng máy, Tên phòng máy, Số máy có số máy lớn hơn 7
select MaPhongMay, TenPhongMay, SoMay
from PhongMay 
where SoMay>7
--10. Đưa ra STT, Cấu hình, TB Ngoại Vi của phòng máy có mã là pm1
select STT, CauHinh, ThietBiNgoaiVi
from MayTinh
where MaPhong='pm1'
--11. Đưa ra Mã môn học, Tên môn học có Số DVHT>3
select MaMonHoc, TenMonHoc, SoDVHT
from MonHoc
where SoDVHT>3
--12. Đưa ra Mã giáo viên, Tên giáo viên, SDT của những giáo viên có họ Nguyễn
select MaGiaoVien, TenGiaoVien, SDT
from GiaoVien
where TenGiaoVien like N'Nguyễn%'
--13. Đưa ra Mã giáo viên, Tên giáo viên, SĐT dạy bộ môn Công nghệ thông tin
select MaGiaoVien, TenGiaoVien, SDT
from BoMon bm, GiaoVien gv
where bm.MaBoMon=gv.MaBoMon and TenBoMon=N'Công nghệ thông tin'
--14. Đưa ra Mã lớp, Tên lớp học phần, Sĩ số, Số DVHT học môn Cơ sở dữ liệu
select MaLop, TenLopHocPhan, SiSo, SoDVHT
from LopHocPhan lhp, MonHoc mh 
where lhp.MaMonHoc=mh.MaMonHoc and TenMonHoc=N'Cơ sở dữ liệu'
--15. Đưa ra STT, Cấu hình, Thiết Bị Ngoại vi của phòng máy có tên Microsoft
select STT, CauHinh, ThietBiNgoaiVi
from PhongMay pm, MayTinh mt
where pm.MaPhongMay=mt.MaPhong and pm.TenPhongMay='Microsoft'
--16. Đưa ra Mã lịch thực hành, Số buổi, Mã lớp, Tên giáo viên của bộ môn Hệ thống thông tin
select MaLichThucHanh, SoBuoi,  MaLop, TenGiaoVien
from BoMon bm, GiaoVien gv, LichThucHanh lth
where bm.MaBoMon=gv.MaBoMon and gv.MaGiaoVien=lth.MaGiaoVien and bm.TenBoMon=N'Hệ thống thông tin'
--17. Đưa ra Mã lớp, Mã giáo viên, Tiết bắt đầu, Tiết kết thúc, Nội dung thực hành, Tên phòng máy của phòng máy có mã là pm1
select MaLop, MaGiaoVien, TietBatDau, TietKetThuc, NoiDungThucHanh, TenPhongMay
from LichThucHanh lth, ChiTietLichThucHanh ctlth, PhongMay pm
where lth.MaLichThucHanh=ctlth.MaLichThucHanh and ctlth.MaPhongMay=pm.MaPhongMay and pm.MaPhongMay='pm1'
--18. Đưa ra STT, Ngày nhập, Mã nhân viên, Cấu Hình, Thiết Bị Ngoại Vi của máy tính có tình trạng là tốt
select mt.stt, NgayNhap, MaNhanVien, CauHinh, ThietBiNgoaiVi
from PhieuNhap pn, MayTinh mt, NhapMayTinh nmt  
where pn.MaPhieuNhap=nmt.MaPhieuNhap and mt.STT=nmt.STT and TinhTrang=N'Tốt'
--19. Đưa ra Mã bộ môn, Tên bộ môn, số giáo viên dạy bộ môn Công nghệ mạng
select bm.MaBoMon, TenBoMon, count(gv.MaGiaoVien) as N'Số giáo viên'
from BoMon bm, GiaoVien gv
where bm.MaBoMon=gv.MaBoMon and TenBoMon=N'Công nghệ mạng'
group by bm.MaBoMon, TenBoMon
--20. Đếm số thiết bị Điều hòa trong từng phòng máy
select pm.MaPhongMay, pm.TenPhongMay, count(MaThietBi) as N'Số điều hòa'
from PhongMay pm, ThietBiKhac tbk
where pm.MaPhongMay=tbk.MaPhong and TenThietBi=N'Điều hòa'
group by pm.MaPhongMay, pm.TenPhongMay

/*10 câu Truy vấn SQL nâng cao*/
--21. Đưa ra Mã nhân viên, Tên nhân viên trực vào ngày 2018-02-10 ở Phòng máy có tên là Steve Job
select MaNhanVien, TenNhanVien
from NhanVien
where MaNhanVien in(select MaNhanVien 
					from ChiTietLichThucHanh 
					where Ngay='2018-02-10' and MaPhongMay in (select MaPhongMay 
															   from PhongMay
															   where TenPhongMay='Steve Job'))
--22. Đưa ra Mã giáo viên, Tên giáo viên dạy lớp có mã là ml1 vào ngày 2018-03-10 
select gv.MaGiaoVien, gv.TenGiaoVien
from GiaoVien gv, (select MaGiaoVien 
				   from LichThucHanh lth, (select MaLichThucHanh 
										   from ChiTietLichThucHanh
									       where Ngay='2018-01-10' ) lthy
				   where lth.MaLichThucHanh=lthy.MaLichThucHanh and lth.MaLop='ml11') gv1
where gv.MaGiaoVien=gv1.MaGiaoVien
--23. Đưa ra Mã giáo viên, Tên giáo viên chưa có lịch thực hành
select MaGiaoVien, TenGiaoVien
from GiaoVien 
where MaGiaoVien not in (select MaGiaoVien from LichThucHanh)
--24. Đếm số thiết bị có tình trạng tốt theo từng phòng
select pm.MaPhongMay, TenPhongMay, count(tbk.MaThietBi) as N'Số thiết bị'
from PhongMay pm, ThietBiKhac tbk, NhapThietBi ntb 
where pm.MaPhongMay=tbk.MaPhong and tbk.MaThietBi=ntb.MaThietBi and TinhTrang=N'Tốt'
group by pm.MaPhongMay, TenPhongMay
--25. Đưa ra nhân viên trực nhiều ngày nhất
select top 1 with ties MaNhanVien, count(MaNhanVien) as Songaytruc
from ChiTietLichThucHanh
group by MaNhanVien
order by Songaytruc desc
--26. Đưa ra bộ môn có 2 giáo viên trở lên
select bm.MaBoMon, TenBoMon, count(MaGiaoVien) as SoGV
from BoMon bm, GiaoVien gv
where bm.MaBoMon=gv.MaBoMon
group by bm.MaBoMon, TenBoMon
having count(MaGiaoVien)>2
--27. Đưa ra STT, Mã phiếu nhập vào ngày 2018-10-01
select STT, MaPhieuNhap
from NhapMayTinh
where MaPhieuNhap in (select MaPhieuNhap from PhieuNhap where NgayNhap='2018-10-01')
--28. Đưa ra Mã phiếu sửa chữa, Ngày sửa chữa của thiết bị có tình trạng là gãy
select MaPhieuSuaChua, NgaySuaChua
from PhieuSuaChua
where MaPhieuSuaChua in (select MaPhieuSuaChua from SuaChuaThietBi where TinhTrang=N'Hỏng nguồn')
--29. Thêm trường Tổng số ngày trực kiểu int vào bảng nhân viên 
alter table NhanVien
add TongNgayTruc int
--30. Cập nhật giá trị cho trường Tổng số ngày trực
update NhanVien
set TongNgayTruc = (select count(MaNhanVien)
					from ChiTietLichThucHanh
					group by MaNhanVien
					having MaNhanVien=NhanVien.MaNhanVien)

/*10 câu lệnh T-SQL*/
--31. Tạo thủ tục thêm máy vào bảng Máy tính
create proc ThemMay (@STT nchar(10), @CH nvarchar(50), @TBNV nvarchar(50), @MP nchar(10))
as
begin
	insert into MayTinh(STT,CauHinh,ThietBiNgoaiVi,MaPhong)
	values (@STT,@CH,@TBNV,@MP)
end
ThemMay'mt25','RAM 16GB,SSD 1TB','KeyBoard,Mouse,HeadPhone','pm1'
--32. Thống kê Giáo viên theo Mã bộ môn
create proc ThongKeGV(@MaBoMon nchar(10))
as
begin
	select *
	from GiaoVien where MaBoMon=@MaBoMon
end
ThongKeGV'bm1'
--33. Tạo thủ tục thống kê số lịch thực hành tham gia của từng giáo viên theo bộ môn có tên là gì đấy
create proc ThongKeSLTH(@TenBoMon nvarchar(50))
as
begin
	select gv.MaGiaoVien, TenGiaoVien, count(MaLichThucHanh) as N'Số lịch thực hành'
	from BoMon bm, GiaoVien gv, LichThucHanh lth
	where bm.MaBoMon=gv.MaBoMon and gv.MaGiaoVien=lth.MaGiaoVien and TenBoMon=@TenBoMon
	group by gv.MaGiaoVien, TenGiaoVien
end
ThongKeSLTH N'Công nghệ thông tin'
--34. Tạo thủ tục thêm 1 sửa chữa mới sau đó thêm tất cả máy tính thuoc phòng máy có mã là pm1 vào phiếu này
create proc ThemSuaChua_pm1(@maPSC char(10), @ngay date)
as
begin
	insert into PhieuSuaChua(MaPhieuSuaChua,NgaySuaChua)
	values (@maPSC, @ngay)
	insert into SuaChuaMayTinh(MaPhieuSuaChua,STT)
	select @maPSC, STT
	from MayTinh
	where MaPhong='pm1'
end
ThemSuaChua_pm1 N'psc7', '2018-10-27'
--35. Xem danh sách môn học của lớp học phần có tên là gì đấy
alter proc XemDSMH_LHP(@tenLHP nvarchar(50))
as
begin
	select mh.MaMonHoc,mh.TenMonHoc
	from LopHocPhan lhp, MonHoc mh
	where lhp.MaMonHoc=mh.MaMonHoc and TenLopHocPhan=@tenLHP
end
XemDSMH_LHP N'Cơ sở dữ liệu 1'
--36. Tạo thủ tục thêm giáo viên, đưa tất cả lịch thực hành chưa có giáo viên nào cho giáo viên này
alter proc ThemGV_LTH(@maGV char(10), @tenGV nvarchar(50))
as
begin
	insert into GiaoVien(MaGiaoVien, TenGiaoVien)
	values (@maGV, @tenGV)
	update LichThucHanh
	set MaGiaoVien=@maGV
	where MaGiaoVien is NULL
end
ThemGV_LTH 'GV11',N'Hoàng Văn Thụ'
--37. Tạo hàm thống kê số ca cho nhân viên có mã là gì đó nếu không có thì thống kê cho từng nhân viên
alter function ThongKeSoCa_NV(@ma char(10))
returns @thongKe table
(
	MaNhanVien char(10),
	SoNgay int
)
as
begin 
	if((@ma is NULL) or (@ma=''))
		insert into @thongKe
		select MaNhanVien, count(Ngay)
		from ChiTietLichThucHanh
		group by MaNhanVien
	else 
		insert into @thongKe
		select MaNhanVien, count(Ngay)
		from ChiTietLichThucHanh
		where MaNhanVien=@ma
		group by MaNhanVien
	return
end
select * from dbo.ThongKeSoCa_NV('')
--38. Tạo hàm đưa ra danh sách giáo viên thuộc bộ môn có mã là gì đó
create function XemDSGV(@maBoMon char(10))
returns table
as return(
	select MaGiaoVien, TenGiaoVien
	from GiaoVien gv inner join BoMon bm
	on gv.MaBoMon=bm.MaBoMon
	where gv.MaBoMon=@maBoMon)
select * from dbo.XemDSGV('bm1')
--39. Tạo trigger xóa Giáo Viên và các bảng liên quan
create trigger XoaGiaoVien on GiaoVien instead of delete
as
begin
	declare @magv char(10), @tengv nvarchar(50)
	select @magv=MaGiaoVien, @tengv=TenGiaoVien from deleted
	delete LichThucHanh where MaGiaoVien=@magv
	delete GiaoVien where MaGiaoVien=@magv
	print N'Mã giáo viên vừa xóa là: '+@magv
	print N'Tên giáo viên vừa xóa là: '+@tengv
end
delete GiaoVien where MaGiaoVien='GV11'
--40. Tạo trigger tự động cập nhật số máy tính nhập trong bảng Phiếu nhập khi thêm, sửa, xóa máy tính trong bảng Nhập máy tính 
alter trigger CapNhatSoMayTinhNhap on PhieuNhap for insert, update, delete
as
begin
	declare @maPhieuNhap char(10)
	select @maPhieuNhap=MaPhieuNhap from inserted
	update PhieuNhap set TongMayTinhNhap=(select count(STT) from NhapMayTinh where MaPhieuNhap=@maPhieuNhap)
	where MaPhieuNhap=@maPhieuNhap
	select @maPhieuNhap=MaPhieuNhap from deleted
	update PhieuNhap set TongMayTinhNhap=(select count(STT) from NhapMayTinh where MaPhieuNhap=@maPhieuNhap)
	where MaPhieuNhap=@maPhieuNhap
end
select * from PhieuNhap delete from NhapMayTinh where STT='mt6'


		



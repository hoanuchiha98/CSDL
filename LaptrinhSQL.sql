select MaNV N'Mã nhân viên', HoTen N'Họ tên', TenPB N'Tên phòng ban'
from NhanVien nv, PhongBan pb
where (Luong between 1000 and 4000) 
	and (nv.MaPB=pb.MaPB)


--đưa ra manv, hoten của nhân viên làm trưởng phòng
select nv.MaNV, HoTen
from NhanVien nv, PhongBan pb
where nv.MaNV=pb.MaTP



-- mada, tenda, tenpb phụ trach du an
select da.MaDA, TenDA, TenPB
from DuAn da, PhongBan pb
where da.MaPB=pb.MaPB


--manv, hotennv, tenthannhan, quanhe
select nv.MaNV, HoTen, HoTenTN, QuanHe
from NhanVien nv, ThanhNhan tn
where nv.MaNV = tn.MaNV

--manv, hotennv, tendu ma nhan vien tham gia
select nv.MaNV, HoTen, TenDA
from NhanVien nv, PhanCong pc, DuAn da
where (nv.MaNV = pc.MaNV) and (pc.MaDA=da.MaDA)

-- manv hotennv, tenda mà nhân viên trưởng phòng tham gia
select MaNV, HoTen
from NhanVien nv, PhongBan pb
where nv.MaNV = pb.MaTP

--manv,hotennv của nhân viên làm người giám sát
select nv1.MaNV N'Mã nhân viên', nv1.Hoten N'Họ tên'
from NhanVien nv1, NhanVien nv2
where nv1.MaNV=nv2.MaNQL
--manv, hotennv, tenthannhan, quanhe của nhân viên có tham gia dự án
select nv.MaNV,nv.HoTen, HoTenTN, QuanHe
from NhanVien nv, ThanhNhan tn , PhanCong pc
where (nv.MaNV=tn.MaNV) and (nv.MaNV=pc.MaNV) 

--nhân viên phòng số 5 
select nv.MaNV, HoTen, TenDA
from NhanVien nv, DuAn da, PhanCong pc
where (nv.MaPB='pb3') and (da.TenDA='aqua')and (pc.SoGio>10) 
		and (nv.MaNV=pc.MaNV) and (da.MaDA=pc.MaDA)

-- manv tennv truong phong cua phong co tham gia du an           
select nv.MaNV N'Mã', HoTen, pb.TenPB, da.TenDA
from NhanVien nv, PhongBan pb, DuAn da
where( nv.MaNV=pb.MaTP ) and (pb.MaPB=da.MaPB)

-- maPB tênpb ten du an ma truong phong tham gia du an
select pb.MaPB,TenPB,TenDA
from PhongBan pb, DuAn da,PhanCong pc
where (pb.MaPB= da.MaPB) and (pc.MaNV=pb.MaTP)


-- select danh sach cột
-- from bảng1 [inner] join bảng2 on <biểu thức nối> join bảng3 on <biểu thức nối> ... join bảngN on< biểu thức nối>
-- where điều kiện lặp

-- điều kiện nối >< điều kiện lặp
-- left|right [full]

-- manv tennv tenpb tương ứng
select MaNV, HoTen,pb.MaPB,TenPB
from NhanVien nv join PhongBan pb on (nv.MaPB=pb.MaPB)

select MaNV, HoTen,TenPB
from NhanVien left join PhongBan on (NhanVien.MaPB=PhongBan.MaPB)

select MaNV, HoTen,TenPB
from NhanVien right join PhongBan on (NhanVien.MaPB=PhongBan.MaPB)

select MaNV, HoTen,TenPB
from NhanVien full join PhongBan on (NhanVien.MaPB=PhongBan.MaPB)


-- manv, hoten nv làm  trưởng phòng
select MaNV,HoTen
from NhanVien
where MaNV in(
	select MaTP
	from PhongBan
)

-- manv, hoten nv làm ngs
select MaNV, HoTen
from NhanVien
where MaNV in(
	select MaNQL
	from NhanVien
)
-- mapb ten pb chua co tp chua phu trach du an nào
select MaPB, TenPB
from PhongBan
where PhongBan.MaTP ISNULL and MaPB not in (
	select MaPB from DuAn
)


-- manv hotennv luong cua nhung nv co luong lon hon tat ca luong nv phong Tự động hóa => long phan cap
select MaNV, HoTen, Luong
from NhanVien
where Luong>all (
	select Luong
	from NhanVien nv , PhongBan pb
	where  nv.MaPB=pb.MaPB and pb.TenPB=N'Tự động hóa'
)
select MaNV, HoTen, Luong
from NhanVien
where Luong>all (
	select Luong
	from NhanVien 
	where  MaPB in (
		select MaPb
		from PhongBan
		where TenPB=N'Tự động hóa'
	)
)
-- mapb, tenpb, ten da ma truong phong tham gia
select pb.MaPB, pb.TenPB, da.TenDA
from PhongBan pb, DuAn da 
where pb.MaPB=da.MaPB and pb.MaTP in(
	select nv.MaNV
	from NhanVien nv, PhanCong pc
	where nv.MaNV= pc.MaNV
)

-- dua ra danh sach nhan vien la truong phong
select nv.MaNV, nv.HoTen
from NhanVien nv, (select pb.MaTP from PhongBan pb where pb.MaTP IS NOT NULL) nv_tp
where nv.MaNV=nv_tp.MaTP
-- dua ra nhan vien la truong phong => long tuong quan
select nv.MaNV, nv.HoTen
from NhanVien nv
where exists (
	select *
	from PhongBan
	where MaTP=nv.MaNV
)
-- dua ra danh sanh nhan vien co nguoi giam sat
select nv.MaNV, nv.HoTen
from NhanVien nv, (select MaNV from NhanVien where MaNQL is not null) nv_gs
where nv.MaNV = nv_gs.MaNV
-- nhan vien co luong bang luong cua it nhat 1 nguoi trong pb2
select nv.MaNV, nv.HoTen, nv.Luong
from NhanVien nv, (select Luong from NhanVien where MaPB='pb2') luongNV
where nv.Luong = luongNV.Luong

-- nhan vien va phong ban tuong ung
select nv.MaNV, nv.HoTen , pb.TenPB
from NhanVien nv, (select MaPB, TenPB from PhongBan) pb
where nv.MaPB = pb.MaPB

-- dua ra nhan vien la nguoi giam sat
select distinct nv.MaNV, nv.HoTen  -- loai cac phan tu trung nhau distinct
from NhanVien nv, (select MaNQL from NhanVien ) ql
where nv.MaNV =ql.MaNQL

-- cho biet ma du an co nhan vien co ho la nguyen tham gia du an hoac truong phong phu trach du an co ho nguyen
select pc.MaDA 
from NhanVien nv, PhanCong pc
where nv.MaNV= pc.MaNV and nv.HoTen LIKE N'Nguyễn%'
 union
 select da.MaDA
 from PhongBan pb, NhanVien nv, DuAn da
 where da.MaPB=pb.MaPB and nv.MaNV=pb.MaTP and nv.HoTen LIKE N'Nguyễn%'

 -- dua ra nhan vien la truong phong vua tham gia du an
 select nv.MaNV, nv.HoTen
 from NhanVien nv, PhongBan pb
 where nv.MaNV=pb.MaTP
 union 
 select nv.MaNV, nv.HoTen
 from NhanVien nv, PhanCong pc
 where nv.MaNV=pc.MaNV
 -- Tim nhung nhan vien khong co than nhan
 select nv.MaNV, nv.HoTen
 from NhanVien nv
 except 
 select nv.MaNV, nv.HoTen
 from NhanVien nv, ThanhNhan tn
 where nv.MaNV=tn.MaNV
 --dem so nhan vien da co troong phong ban
 select count (MaNV)
 from NhanVien
 where MaPB is not null

 -- dem so nhan vien theo tung phong ban
 select nv.MaPB, TenPB, count(MaNV) soNV
 from NhanVien nv, PhongBan pb
 where nv.MaPB=pb.MaPB 
 group by nv.MaPB, TenPB
  -- dua ra phong ban co tu 2 nhan vien tro len
 select nv.MaPB, TenPB, count(MaNV) soNV
 from NhanVien nv, PhongBan pb
 where nv.MaPB=pb.MaPB 
 group by nv.MaPB, TenPB
 having COUNT(MaNV) >=2
 -- dem so du an tham gia theo tung nhan vien , thong tin dua ra gom manv, so du an

 select nv.MaNV, HoTen, count(MaDA)
 from PhanCong pc, NhanVien nv
 where pc.MaNV=nv.MaNV
 group by nv.MaNV,HoTen
 having count (MaDA)>=2

 --ma nhan vien, ho ten , tong so gio 
 select MaNV, sum(SoGio)
 from PhanCong
 group by MaNV

 -- dua ra thong tin nhanvien, cua nhung nhan vien co luong lon nhat trong moi phong ban
select nv.MaNV,nv.HoTen, nv.Luong, nv.MaPB
from NhanVien nv, ( 
		select pb.MaPB, max(luong) as 'Luong_PB'
		from NhanVien nv, PhongBan pb
		where nv.MaPB= pb.MaPB
		group by pb.MaPB ) as LuongMax
where nv.MaPB = LuongMax.MaPB and LuongMax.Luong_PB = nv.Luong


-- ma da, ten da khong co thanh vien tham gia
select MaDA, TenDa
from DuAn
where MaDA not in(
	select MaDA
	from PhanCong
)
-- ma da, ten da,khong co truong phong tham gia
select MaDA, TenDA
from DuAn
where MaDA not in (
	select MaDA
	from PhongBan, PhanCong
	where PhongBan.MaTP=PhanCong.MaNV
)


select da.MaDA, TenDA
from DuAn da, PhanCong pc
where da.MaDA = pc.MaDA
except 
select da.MaDA, TenDA
from DuAn da, PhanCong pc, PhongBan pb
where pc.MaDA =da.MaDA and pc.MaNV = pb.MaTP

-- ma da, ten da, co truong phong tham gia
select MaDA, TenDA
from DuAn
where MaDA in (
	select MaDA
	from PhongBan, PhanCong
	where PhongBan.MaTP=PhanCong.MaNV
)
-- ma nv, ten nv, ten da ma nhan vien tham gia
select nv.MaNV,nv.HoTen,da.TenDA
from NhanVien nv, DuAn da, PhanCong pc
where nv.MaNV=pc.MaNV and da.MaDA= pc.MaDA

-- dua ra ma pb, ten pb, tong so than nhan theo tung phong ban
select  pb.MaPB, TenPB
from PhongBan pb


-- ma da, ten da, ten nv tham gia co than nhan
select da.MaDA, da.MaDA, nv.HoTen
from DuAn da, NhanVien nv, PhanCong pc
where da.MaDA=pc.MaDA and pc.MaNV = nv.MaNV  and nv.MaNV in
(
	select MaNV
	from ThanhNhan
)

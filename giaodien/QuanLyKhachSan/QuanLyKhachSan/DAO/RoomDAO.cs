
using QuanLyKhachSan.DTO;
using QuanLyKhachSan.QuanLyKhachSanDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyKhachSan.DAO
{
    public class RoomDAO
    {
        private static RoomDAO instance;

        public static RoomDAO Instance
        {
            get
            {
                if (instance == null) instance = new RoomDAO(); return RoomDAO.instance;
            }
            private set
            {
                RoomDAO.instance = value;
            }
        }
        public static int RoomWidth = 100;
        public static int RoomHeight = 100;
        private RoomDAO() { }
        public List<Room> LoadRoomList()
        {
            List<Room> roomList = new List<Room>();
            DataTable data = DataProvider.Instance.ExecuteQuery("USP_GetRoomList");
            foreach (DataRow item in data.Rows)
            {
                Room room = new Room(item);
                roomList.Add(room);

            }


            return roomList;
        }

        public bool InsertRoom(int maphong, string tenphong, string maloaiphong, string tinhtrangphong)
        {
            string q = string.Format("INSERT dbo.DANHMUCPHONG (MaPhong,TenPhong,MaLoaiPhong,TinhTrangPhong) VALUES ({0},N'{1}',N'{2}',N'{3}')", maphong, tenphong, maloaiphong, tinhtrangphong);
            int result = DataProvider.Instance.ExecuteNonQuery(q);
            return result > 0;
        }
        public bool UpdateRoom(string maloaiphong, string tinhtrangphong, string tenphong, int maphong)
        {
            string q = string.Format("Update dbo.DANHMUCPHONG SET TinhTrangPhong = N'{0}',  MaLoaiPhong = N'{1}', TenPhong = N'{2}', MaPhong = {3} where MaPhong = {4}", tinhtrangphong, maloaiphong, tenphong, maphong,maphong);
            int result = DataProvider.Instance.ExecuteNonQuery(q);
            return result > 0;
        }
        public bool DeleteRoom(int maphong)
        {
            string q = string.Format("Delete dbo.DANHMUCPHONG Where MaPhong = {0} ", maphong);
            int result = DataProvider.Instance.ExecuteNonQuery(q);
            return result > 0;
        }

    }
}

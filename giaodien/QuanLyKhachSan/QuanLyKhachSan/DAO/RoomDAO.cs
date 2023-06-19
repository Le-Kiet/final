
using QuanLyKhachSan.DTO;
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
        public void SwitchRoom(int maphongmot, int maphonghai)
        {
            DataProvider.Instance.ExecuteQuery("USP_SwitchTableTest @MaPhongMot ="+ maphongmot +", @MaPhongHai = "+maphonghai);
        }
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
    }
}

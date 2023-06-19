using QuanLyKhachSan.DAO;
using QuanLyKhachSan.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace QuanLyKhachSan
{
    public partial class TableManager : Form
    {
        public TableManager()
        {
            InitializeComponent();
            loadRoom();
        }
        #region Method
        void loadRoom()
        {
            List<Room> roomList = RoomDAO.Instance.LoadRoomList();
            foreach (Room item in roomList)
            {
                Button btn = new Button() { Width =RoomDAO.RoomWidth,Height=RoomDAO.RoomHeight};
                btn.Text = item.Tenphong + Environment.NewLine + item.Tinhtrangphong;
                btn.Click += btn_Click;
                btn.Tag = item;
                switch (item.Tinhtrangphong)
                {
                    case "Trống":
                        btn.BackColor = Color.YellowGreen;
                        break;
                    case "Có người":
                        btn.BackColor = Color.Red;
                        break;
                    default:
                        btn.BackColor = Color.Yellow;
                        break;
                }

                flpTable.Controls.Add(btn);
            }
        }
        void showVoucher(int maphieuthuephong)
        {
          List<VoucherInfo> listVoucherInfo = VoucherInfoDAO.Instance.GetListVoucherInfo(VoucherDAO.Instance.GetUncheckVoucherByRoom(maphieuthuephong));
            foreach (VoucherInfo item in listVoucherInfo)
            {
                ListViewItem lsvItem = new ListViewItem(item.Maphieuthuephong.ToString());
                lsvItem.SubItems.Add(item.Tenkhachhang.ToString());
                listVoucher1.Items.Add(lsvItem);
            }
        }

        #endregion
        #region Events

        private void btn_Click(object sender, EventArgs e)
        {
            int RoomID = ((sender as Button).Tag as Room).Maphong;
            showVoucher(RoomID);
        }
        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            admin f = new admin();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void danhSáchLoạiPhòngToolStripMenuItem_Click(object sender, EventArgs e)
        {
            RoomKind f = new RoomKind();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void danhSáchPhòngTrốngToolStripMenuItem1_Click(object sender, EventArgs e)
        {

        }

        private void phiếuThuêPhòngToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }
        #endregion

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void TableManager_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Info_Room f = new Info_Room();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}

import 'package:bitaqwa/dashboard/menu_data.dart';
import 'package:bitaqwa/dashboard/color_constant.dart';
import 'package:flutter/material.dart';

class BasicDashboardScreen extends StatelessWidget {
  const BasicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBackground,
      // 1. BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConstant.colorPrimary,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Fokus di Home
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.headset_mic), label: 'Bantuan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. HEADER (Sapaan & Notifikasi)
                _buildHeader(),
                const SizedBox(height: 20),

                // 3. SEARCH BAR
                _buildSearchBar(),
                const SizedBox(height: 20),

                // 4. BANNER UTAMA
                _buildBanner(),
                const SizedBox(height: 24),

                // 5. MENU LAYANAN POPULER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Layanan Populer',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstant.colorText),
                    ),
                    Text(
                      'Lihat semua',
                      style: TextStyle(fontSize: 14, color: ColorConstant.colorPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildMenuGrid(context),
                
                const SizedBox(height: 24),
                
                // 6. REKOMENDASI
                const Text(
                  'Rekomendasi Untukmu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstant.colorText),
                ),
                const SizedBox(height: 12),
                _buildRecommendedCards(),
                const SizedBox(height: 20), // Spasi bawah
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET PENYUSUN ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on, color: ColorConstant.colorPrimary, size: 20),
                SizedBox(width: 4),
                Text(
                  'Indonesia, Jakarta',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorConstant.colorText),
                ),
                Icon(Icons.keyboard_arrow_down, size: 18, color: ColorConstant.colorText),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Assalamu\'alaikum, Pengguna',
              style: TextStyle(color: ColorConstant.colorTextSecondary, fontSize: 13),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorConstant.colorBorder),
                color: ColorConstant.colorWhite,
              ),
              child: const Icon(Icons.notifications_none, size: 20, color: ColorConstant.colorText),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Colors.grey),
          hintText: 'Cari doa atau fitur...',
          hintStyle: const TextStyle(color: ColorConstant.colorTextSecondary),
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.tune, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.colorPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jadwal Sholat Hari Ini',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Subuh 04:30',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                // Tombol Buka Jadwal
                // Dibungkus Material agar bisa diklik di masa depan
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, size: 16, color: ColorConstant.colorPrimary),
                        SizedBox(width: 8),
                        Text(
                          'Buka Jadwal',
                          style: TextStyle(
                            color: ColorConstant.colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.mosque,
              size: 150,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, 
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8, 
      ),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final menu = menus[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, menu.route);
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstant.colorWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorConstant.colorBorder),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorConstant.colorPrimary.withOpacity(0.1), 
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    menu.image,
                    height: 30,
                    width: 30,
                    // Fallback icon jika gambar tidak ditemukan
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.apps, color: ColorConstant.colorPrimary),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  menu.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.colorText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecommendedCards() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCardRecommendation('Doa Pagi', 'Bacaan doa sebelum beraktivitas', Icons.wb_sunny),
          const SizedBox(width: 12),
          _buildCardRecommendation('Doa Tidur', 'Bacaan doa sebelum istirahat', Icons.nightlight_round),
        ],
      ),
    );
  }

  Widget _buildCardRecommendation(String title, String subtitle, IconData icon) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.colorWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorConstant.colorBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorConstant.colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: ColorConstant.colorPrimary, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ColorConstant.colorText),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: ColorConstant.colorTextSecondary, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
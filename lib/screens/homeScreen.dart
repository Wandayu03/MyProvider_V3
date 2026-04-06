import 'package:flutter/material.dart';
import 'package:internet_provider/screens/loginScreen.dart';
import 'package:internet_provider/screens/packageScreen.dart';
import '../theme/appframe.dart';
import '../screens/loginScreen.dart';
import '../screens/packageScreen.dart';

class HomeScreen extends StatelessWidget {
  final String identifier;
  const HomeScreen({super.key, required this.identifier});

  String get displayName {
    if (identifier.contains('@')) return identifier.split('@').first;
    if (identifier.startsWith('0') || identifier.startsWith('+')) {
      return identifier.length > 7
          ? '${identifier.substring(0, 4)}****${identifier.substring(identifier.length - 3)}'
          : identifier;
    }
    return identifier;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 180,
              floating: false,
              pinned: true,
              backgroundColor: Appframe.primary,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () => _confirmLogout(context),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Appframe.primary,
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.wifi, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'MyProvider',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Halo, $displayName 👋',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Paket aktif hingga 30 April 2025',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats row
                    Row(
                      children: [
                        _StatCard(icon: Icons.speed, label: 'Kecepatan', value: '50 Mbps'),
                        const SizedBox(width: 12),
                        _StatCard(icon: Icons.signal_wifi_4_bar, label: 'Uptime', value: '98%'),
                        const SizedBox(width: 12),
                        _StatCard(icon: Icons.devices, label: 'Perangkat', value: '5'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Status card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Appframe.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Appframe.primaryAccent),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Appframe.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Paket Turbo 50 Mbps',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Appframe.primaryDark)),
                              Text('Status: Aktif',
                                  style: TextStyle(fontSize: 13, color: Colors.green[700])),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Appframe.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('AKTIF',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Menu Utama',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _MenuCard(
                          icon: Icons.inventory_2_outlined,
                          label: 'Beli Paket',
                          color: Appframe.primary,
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Packagescreen())),
                        ),
                        _MenuCard(
                          icon: Icons.receipt_long_outlined,
                          label: 'Tagihan',
                          color: const Color(0xFF2196F3),
                          onTap: () {},
                        ),
                        _MenuCard(
                          icon: Icons.router_outlined,
                          label: 'Status Jaringan',
                          color: const Color(0xFF9C27B0),
                          onTap: () {},
                        ),
                        _MenuCard(
                          icon: Icons.headset_mic_outlined,
                          label: 'Bantuan',
                          color: const Color(0xFFFF9800),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Promo banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Appframe.primaryDark, Appframe.primary],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Upgrade ke Giga!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                SizedBox(height: 4),
                                Text('300 Mbps, cocok untuk seluruh keluarga',
                                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const Packagescreen())),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Appframe.primary,
                              minimumSize: const Size(80, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: const Text('Upgrade', style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const Login()));
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 36)),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Appframe.primary, size: 22),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14, color: Appframe.primaryDark)),
            Text(label,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _MenuCard({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
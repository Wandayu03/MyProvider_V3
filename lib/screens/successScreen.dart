import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/packageModel.dart';
import '../theme/appframe.dart';
import 'homeScreen.dart';

class SuksesScreen extends StatelessWidget {
  final InternetPackage package;
  final String transactionId;

  const SuksesScreen({
    super.key,
    required this.package,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final now = DateTime.now();
    final dateStr = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              // Success icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Appframe.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: Appframe.primary, size: 60),
              ),
              const SizedBox(height: 20),

              const Text(
                'Pembayaran Berhasil!',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700, color: Appframe.primaryDark),
              ),
              const SizedBox(height: 8),
              Text(
                'Paket ${package.name} ${package.speed} Anda sudah aktif.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 28),

              // Receipt card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _receiptRow('Paket', '${package.name} ${package.speed}'),
                    _receiptRow('Nominal', currency.format(package.total)),
                    _receiptRow('No. Transaksi', transactionId),
                    _receiptRow('Tanggal', dateStr),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Status',
                            style: TextStyle(fontSize: 13, color: Colors.grey)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Appframe.primaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Appframe.primary, size: 14),
                              SizedBox(width: 4),
                              Text('SUKSES',
                                  style: TextStyle(
                                      color: Appframe.primaryDark,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen(identifier: '')),
                  (route) => false,
                ),
                child: const Text('Kembali ke Beranda'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: const Text('Unduh Bukti Pembayaran',
                    style: TextStyle(color: Appframe.primary)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:internet_provider/theme/appframe.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/packageModel.dart';
import '../theme/appframe.dart';
import 'successScreen.dart';

class PembayaranScreen extends StatefulWidget {
  final InternetPackage package;
  const PembayaranScreen({super.key, required this.package});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  final _currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  bool _isLoading = false;

  // Data QRIS (dalam produksi ini berisi string QR dari payment gateway)
  String get _qrisData =>
      'MYPROVIDER|PKG:${widget.package.id}|AMT:${widget.package.total}|TRX:${DateTime.now().millisecondsSinceEpoch}';

  String get _transactionId =>
      'TRX${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

  Future<void> _konfirmasiPembayaran() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // simulasi verifikasi
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuksesScreen(
          package: widget.package,
          transactionId: _transactionId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pkg = widget.package;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran QRIS'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ringkasan
            _SectionCard(
              title: 'Ringkasan Pesanan',
              child: Column(
                children: [
                  _Row(label: 'Paket', value: '${pkg.name} ${pkg.speed}'),
                  _Row(label: 'Periode', value: '1 Bulan'),
                  _Row(label: 'Harga', value: _currency.format(pkg.pricePerMonth)),
                  _Row(label: 'PPN 11%', value: _currency.format(pkg.ppn)),
                  const Divider(),
                  _Row(
                    label: 'Total Bayar',
                    value: _currency.format(pkg.total),
                    isBold: true,
                    valueColor: Appframe.primaryDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // QRIS
            _SectionCard(
              title: 'Scan QRIS',
              child: Column(
                children: [
                  // Logo QRIS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('QRIS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                letterSpacing: 2)),
                      ),
                      const SizedBox(width: 8),
                      Text('MyProvider', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // QR Code
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Appframe.primaryLight, width: 2),
                    ),
                    child: QrImageView(
                      data: _qrisData,
                      version: QrVersions.auto,
                      size: 200,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Appframe.primaryDark,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Appframe.primaryDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    _currency.format(pkg.total),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Appframe.primaryDark),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Berlaku 15 menit · Semua e-wallet & m-banking',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  // Accepted apps
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: ['GoPay', 'OVO', 'Dana', 'ShopeePay', 'BCA', 'Mandiri', 'BNI']
                        .map((app) => Chip(
                              label: Text(app, style: const TextStyle(fontSize: 11)),
                              padding: EdgeInsets.zero,
                              backgroundColor: Appframe.primaryLight,
                              side: BorderSide.none,
                              labelStyle: const TextStyle(color: Appframe.primaryDark),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _konfirmasiPembayaran,
              child: _isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : const Text('Saya Sudah Membayar'),
            ),
            const SizedBox(height: 12),

            Text(
              'Klik tombol di atas setelah pembayaran berhasil.\nTransaksi akan diverifikasi otomatis.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Appframe.primaryDark)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  const _Row({required this.label, required this.value, this.isBold = false, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: isBold ? 15 : 13,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
                  color: valueColor ?? Colors.black87)),
        ],
      ),
    );
  }
}